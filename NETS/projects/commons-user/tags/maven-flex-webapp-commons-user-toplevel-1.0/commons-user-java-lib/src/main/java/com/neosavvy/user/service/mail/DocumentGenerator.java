package com.neosavvy.user.service.mail;

import groovy.lang.Writable;
import groovy.text.SimpleTemplateEngine;
import groovy.text.Template;
import groovy.text.TemplateEngine;

import java.io.BufferedOutputStream;
import java.io.ByteArrayOutputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.StringReader;
import java.net.URL;
import java.net.URLConnection;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.print.Doc;
import javax.print.DocFlavor;
import javax.print.DocPrintJob;
import javax.print.PrintException;
import javax.print.PrintService;
import javax.print.PrintServiceLookup;
import javax.print.SimpleDoc;
import javax.print.attribute.HashPrintRequestAttributeSet;
import javax.print.attribute.PrintRequestAttributeSet;
import javax.print.attribute.standard.MediaSizeName;
import javax.xml.transform.Result;
import javax.xml.transform.Source;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.sax.SAXResult;
import javax.xml.transform.stream.StreamSource;

import org.apache.fop.apps.FOPException;
import org.apache.fop.apps.Fop;
import org.apache.fop.apps.FopFactory;
import org.apache.fop.apps.MimeConstants;
import org.codehaus.groovy.control.CompilationFailedException;


/**
 * This class is a derivative work of Fineline via Tommy Odom.
 * The code herein cannot be distributed without first establishing prior written consent
 * from tommy.odom@gmail.com
 */
public class DocumentGenerator
{
    private TemplateEngine templateEngine;
    private FopFactory fopFactory;
    private Map<URL, CachedTemplate> templateCache = new HashMap<URL, CachedTemplate>();
    
    public DocumentGenerator() {
        templateEngine = new SimpleTemplateEngine();
        fopFactory = FopFactory.newInstance();
    }
    
    public String processTemplate(URL templateFile, Map<String, Object> bindings) throws DocumentGenerationException {
        try {
            Template template = createTemplate(templateFile);
            Writable fo = template.make(bindings);
            return fo.toString();
        }
        catch (FileNotFoundException e) {
            throw new DocumentGenerationException("Could not locate template file " + templateFile, e);
        }
        catch (CompilationFailedException e) {
            throw new DocumentGenerationException("Error compiling template file: " + e.getMessage(), e);
        }
        catch (Exception e) {
            throw new DocumentGenerationException("An unexpected error occured while processing the template: " + e.getMessage(), e);
        }
    }

    private Template createTemplate(URL templateFile) throws ClassNotFoundException, IOException {
        CachedTemplate cachedTemplate = templateCache.get(templateFile);
        
        if (cachedTemplate != null) {
            try {
                URLConnection connection = templateFile.openConnection();
                connection.connect();
                long templateLastModified = connection.getLastModified();
                
                if (cachedTemplate.getCacheDate().after(new Date(templateLastModified))) {
                    return cachedTemplate.getTemplate();
                }
            }
            catch (Exception e) {
                // ignore, just treat this as a cache miss
            }
        }
        Template template = templateEngine.createTemplate(templateFile);
        cachedTemplate = new CachedTemplate();
        cachedTemplate.setCacheDate(new Date());
        cachedTemplate.setTemplate(template);
        templateCache.put(templateFile, cachedTemplate);
        
        return template;
    }

    public byte[] generateDocument(URL templateFile, Map<String, Object> bindings, String mimeType) throws DocumentGenerationException {
        try {
            String fo = processTemplate(templateFile, bindings);
            
            ByteArrayOutputStream byteStream = new ByteArrayOutputStream();
            BufferedOutputStream bufferedStream = new BufferedOutputStream(byteStream);
            Fop fop = fopFactory.newFop(mimeType, bufferedStream);
            TransformerFactory factory = TransformerFactory.newInstance();
            Transformer transformer = factory.newTransformer(); 
            Source src = new StreamSource(new StringReader(fo));
            Result res = new SAXResult(fop.getDefaultHandler());
            transformer.transform(src, res);
            
            bufferedStream.flush();
            bufferedStream.close();
            return byteStream.toByteArray();
        }
        catch (DocumentGenerationException e) {
            throw e;
        }
        catch (FOPException e) {
            throw new DocumentGenerationException("Error occurred transforming the XSL FO into the output format: " + e.getMessage(), e);
        }
        catch (Exception e) {
            throw new DocumentGenerationException("An error occurred generating document: " + e.getMessage(), e);
        }
    }
    
    public void generateAndPrintDocument(URL templateFile, Map<String, Object> bindings, MediaSizeName mediaSize, String printerName) 
        throws DocumentGenerationException, PrintException  {
        
        DocFlavor flavor = DocFlavor.BYTE_ARRAY.POSTSCRIPT;
        PrintRequestAttributeSet attributes = new HashPrintRequestAttributeSet(); 
        attributes.add(mediaSize);
        PrintService service = lookupPrintService(flavor, printerName);
        if (service == null) {
            throw new PrintException("A PostScript-capable printer with name=" + printerName + " could not be found");
        }
        
        DocPrintJob printJob = service.createPrintJob();
        byte[] document = generateDocument(templateFile, bindings, MimeConstants.MIME_POSTSCRIPT);
        Doc doc = new SimpleDoc(document, flavor, null);
        printJob.print(doc, attributes);
    }
    
    public void printPDF(InputStream pdf, MediaSizeName mediaSize, String printerName) throws PrintException {
        DocFlavor flavor = DocFlavor.INPUT_STREAM.PDF;
        PrintRequestAttributeSet attributes = new HashPrintRequestAttributeSet(); 
        attributes.add(mediaSize);
        PrintService service = lookupPrintService(flavor, printerName);
        if (service == null) {
            throw new PrintException("A PDF-capable printer with name=" + printerName + " could not be found");
        }
        DocPrintJob printJob = service.createPrintJob();
        Doc doc = new SimpleDoc(pdf, flavor, null);
        printJob.print(doc, attributes);
    }
    
    private PrintService lookupPrintService(DocFlavor flavor, String printerName) {
        PrintService[] services = PrintServiceLookup.lookupPrintServices(flavor, null);
        if (services == null || services.length == 0) {
            return null;
        }
        if (printerName == null) {
            return services[0];
        }
        for (PrintService service : services) {
            if (service.getName().equals(printerName)) {
                return service;
            }
        }
        return null;
    }
}
