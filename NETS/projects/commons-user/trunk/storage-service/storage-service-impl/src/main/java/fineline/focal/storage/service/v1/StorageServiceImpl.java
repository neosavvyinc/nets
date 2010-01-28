package fineline.focal.storage.service.v1;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;

import javax.mail.internet.ContentDisposition;
import javax.ws.rs.WebApplicationException;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import org.apache.commons.fileupload.FileItemIterator;
import org.apache.commons.fileupload.FileItemStream;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.fileupload.util.Streams;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.cxf.jaxrs.ext.MessageContext;
import org.apache.geronimo.mail.util.RFC2231Encoder;
import org.springframework.security.AccessDecisionManager;
import org.springframework.security.context.SecurityContextHolder;

import fineline.focal.common.storage.FileStorage;
import fineline.focal.common.storage.ResourceNotFoundException;
import fineline.focal.common.storage.StorageBucketType;
import fineline.focal.common.types.v1.StorageServiceFileRef;
import fineline.focal.common.utils.FileUtils;
import fineline.focal.common.utils.StringUtils;

public class StorageServiceImpl implements StorageService
{   
    private static Log log = LogFactory.getLog(StorageServiceImpl.class);

    @Context
    private MessageContext messageContext;
    private FileStorage fileStorage;
    private AccessDecisionManager fileAccessDecisionManager;
    private String unarchiveCommand;

    public StorageServiceFileRef findFileRef(String bucket, String key) {
        StorageServiceFileRef ref = fileStorage.findFileRef(bucket, key);
        return ref;
    }
    
    public Response downloadFile(String bucket, String key) throws Exception {
        StorageServiceFileRef ref = fileStorage.findFileRef(bucket, key);
        if (ref == null) {
            throw new ResourceNotFoundException("The file reference for the key " + key + " under bucket " + bucket + " was not found.");
        }
        
        fileAccessDecisionManager.decide(SecurityContextHolder.getContext().getAuthentication(), ref, null);
        
        if (ref.isStatusDeleted()) {
            throw new ResourceNotFoundException("The file reference for the key " + key + " under bucket " + bucket + " has been marked deleted.");
        }
    	
    	File file = fileStorage.getFile(ref);
    	if (!file.exists()) {
    	    throw new ResourceNotFoundException("The file referenced by key " + key + " under bucket " + bucket + " does not exist.");
    	}

    	String mimeType = MediaType.APPLICATION_OCTET_STREAM;
    	
    	if (ref.getContentType() != null) {
    		mimeType = ref.getContentType();
    	}
    	else if (ref.getKey().toLowerCase().endsWith(".stl") || (ref.getFileName() != null && ref.getFileName().toLowerCase().endsWith(".stl"))) {
            mimeType = "model/stl";
        }
        
    	StreamingFileOutput output = new StreamingFileOutput(file);
    	if (fileStorage.getBucket(bucket).getType() == StorageBucketType.TEMPORARY) {
    	    output.setStreamCompleteListener(new OneTimeDownloadStreamCompleteListener(fileStorage, bucket, key));
    	}
    	
        Response.ResponseBuilder builder = Response.ok(output, mimeType);
        
        if (ref.getFileName() != null) {
            RFC2231Encoder encoder = new RFC2231Encoder();
        	builder.header("Content-disposition", "filename*=" + encoder.encode("UTF-8", "", ref.getFileName()) + "");
        }
        
        builder.header("Content-length", file.length());
        
        return builder.build();
    }
    
    public StorageServiceFileRef uploadFile(String bucket, String key) throws Exception {
        String owner = null;
        String fileNameOverride = null;
        FileItemIterator iter = new ServletFileUpload().getItemIterator(messageContext.getHttpServletRequest());
        
        StorageServiceFileRef ref = fileStorage.findFileRef(bucket, key);
        if (ref != null) {
            fileAccessDecisionManager.decide(SecurityContextHolder.getContext().getAuthentication(), ref, null);
        }
        
        
        while (iter.hasNext()) {
            FileItemStream item = iter.next();
            if (item.isFormField() && item.getFieldName().equals("owner")) {
                owner = Streams.asString(item.openStream());
            }
            else if (item.isFormField() && item.getFieldName().equals("fileNameOverride")) {
                fileNameOverride = Streams.asString(item.openStream());
            }
            else if (!item.isFormField()){
                return fileStorage.saveFile(bucket, key, (!StringUtils.isEmpty(fileNameOverride) ? fileNameOverride : item.getName()), 
                        item.getContentType(), item.openStream(), owner);
            }
        }
            
        return null;
    }
    
    
    private void createFileRefs(File dir, List<StorageServiceFileRef> fileRefs, String bucket, String owner) throws IOException, ResourceNotFoundException {
        for (File child : dir.listFiles()) {
            if (child.isFile()) {
                StorageServiceFileRef fileRef = fileStorage.saveFile(bucket, null, child.getName(), FileUtils.getContentType(child.getName()), new FileInputStream(child), owner);
                fileRefs.add(fileRef);
            }
            else if (child.isDirectory()) {
                createFileRefs(child, fileRefs, bucket, owner);
            }
        }
    }

    public String deleteFile(String bucket, String key) throws Exception {
        StorageServiceFileRef ref = fileStorage.findFileRef(bucket, key);
        if (ref == null) {
            throw new ResourceNotFoundException("The file reference for the key " + key + " under bucket " + bucket + " was not found.");
        }
        
        fileAccessDecisionManager.decide(SecurityContextHolder.getContext().getAuthentication(), ref, null);
    	fileStorage.deleteFile(bucket, key);
    	return "File deleted successfully.";
    }
    
    public StorageServiceFileRef cloneFile(String destinationBucket, String sourceBucket, String key) throws Exception {
        StorageServiceFileRef sourceRef = fileStorage.findFileRef(sourceBucket, key);
        
        if (sourceRef == null) {
            throw new ResourceNotFoundException("The file reference for the key " + key + " under bucket " + sourceBucket + " was not found.");
        }
        
        File source = fileStorage.getFile(sourceRef);
        
        if (source == null || !source.exists()) {
            throw new ResourceNotFoundException("The file for the key " + key + " under bucket " + sourceBucket + " was not found.");
        }
        
        return fileStorage.saveFile(destinationBucket, null, sourceRef.getFileName(), sourceRef.getContentType(), new FileInputStream(source), sourceRef.getOwner());
    }
    
    private String buildContentTypeString(MediaType type) {
    	if (type == null) {
    		return null;
    	}
    	
    	StringBuilder builder = new StringBuilder();
    	builder.append(type.getType());
    	
    	if (type.getSubtype() != null) {
    		builder.append("/");
    		builder.append(type.getSubtype());
    	}
    	
    	return builder.toString();
    }
    
    private String parseFileName(String contentDispositionValue) throws javax.mail.internet.ParseException, UnsupportedEncodingException, IOException {
        ContentDisposition disp = new ContentDisposition(contentDispositionValue);
        if (disp.getParameter("filename") != null) {
            return disp.getParameter("filename");
        }
        else if (disp.getParameter("filename*") != null) {
            RFC2231Encoder encoder = new RFC2231Encoder();
            return encoder.decode(disp.getParameter("filename*")); 
        }
        else {
            return "";
        }
    }
    
    public boolean updateFileOwnership(String oldOwner, String newOwner) {
        fileStorage.updateOwnership(oldOwner, newOwner);
        return true;
    }
    
	public FileStorage getFileStorage() {
		return fileStorage;
	}
	public void setFileStorage(FileStorage fileStorage) {
		this.fileStorage = fileStorage;
	}

    public AccessDecisionManager getFileAccessDecisionManager() {
        return fileAccessDecisionManager;
    }
    public void setFileAccessDecisionManager(AccessDecisionManager fileAccessDecisionManager) {
        this.fileAccessDecisionManager = fileAccessDecisionManager;
    }

    public String getUnarchiveCommand() {
        return unarchiveCommand;
    }
    public void setUnarchiveCommand(String unarchiveCommand) {
        this.unarchiveCommand = unarchiveCommand;
    }
}
