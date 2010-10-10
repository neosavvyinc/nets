package fineline.focal.storage.service.v1;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;

import javax.mail.internet.ContentDisposition;
import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.WebApplicationException;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Request;
import javax.ws.rs.core.Response;

import fineline.focal.common.http.HttpUtils;
import org.apache.commons.fileupload.FileItemIterator;
import org.apache.commons.fileupload.FileItemStream;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.fileupload.util.Streams;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.cxf.jaxrs.ext.MessageContext;
import org.apache.geronimo.mail.util.RFC2231Encoder;

import fineline.focal.common.storage.FileStorage;
import fineline.focal.common.storage.ResourceNotFoundException;
import fineline.focal.common.storage.StorageBucketType;
import fineline.focal.common.types.v1.StorageServiceFileRef;
import fineline.focal.common.utils.FileUtils;
import fineline.focal.common.utils.StringUtils;
import org.springframework.security.access.AccessDecisionManager;
import org.springframework.security.access.SecurityConfig;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;

public class StorageServiceImpl implements StorageService
{   
    private static Log log = LogFactory.getLog(StorageServiceImpl.class);

    private FileStorage fileStorage;
    private AccessDecisionManager fileAccessDecisionManager;

    public StorageServiceFileRef findFileRef(String bucket, String key) {
        StorageServiceFileRef ref = fileStorage.findFileRef(bucket, key);
        return ref;
    }
    
    public Response downloadFile(String bucket, String key) throws Exception {
        StorageServiceFileRef ref = fileStorage.findFileRef(bucket, key);
        if (ref == null) {
            throw new ResourceNotFoundException("The file reference for the key " + key + " under bucket " + bucket + " was not found.");
        }
        
        fileAccessDecisionManager.decide(SecurityContextHolder.getContext().getAuthentication(), ref, SecurityConfig.createList("OBJECT_ACL_READ"));
        
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
    
    public StorageServiceFileRef uploadFile(Request request, String bucket, String key) throws Exception {
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();

        String owner = null;
        if (principal instanceof UserDetails)
            owner = ((UserDetails) principal).getUsername();
        else if (principal instanceof String )
            owner = principal.toString();

        String fileNameOverride = null;
        FileItemIterator iter = new ServletFileUpload().getItemIterator(HttpUtils.getHttpRequest());
        
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
                        parseContentType(item.getContentType()), item.openStream(), owner);
            }
        }
            
        return null;
    }
    
    
    public String deleteFile(String bucket, String key) throws Exception {
        StorageServiceFileRef ref = fileStorage.findFileRef(bucket, key);
        if (ref == null) {
            throw new ResourceNotFoundException("The file reference for the key " + key + " under bucket " + bucket + " was not found.");
        }
        
        //fileAccessDecisionManager.decide(SecurityContextHolder.getContext().getAuthentication(), ref, null);
    	fileStorage.deleteFile(bucket, key);
    	return "File deleted successfully.";
    }

    private String parseContentType(String contentType) {
        if (!StringUtils.isEmpty(contentType)) {
            int delimiter = contentType.indexOf(';');

            if (delimiter != -1) {
                return contentType.substring(0, delimiter);
            }
            
        }

        return contentType;
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

}
