package fineline.focal.common.storage.command;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import fineline.focal.common.types.v1.StorageServiceFileRef;
import org.apache.commons.httpclient.HttpMethod;
import org.apache.commons.httpclient.methods.PostMethod;
import org.apache.commons.httpclient.methods.multipart.FilePart;
import org.apache.commons.httpclient.methods.multipart.MultipartRequestEntity;
import org.apache.commons.httpclient.methods.multipart.Part;
import org.apache.commons.httpclient.methods.multipart.StringPart;

import fineline.focal.common.storage.StorageException;

/**
 * This class is a derivative work of Fineline via Tommy Odom.
 * The code herein cannot be distributed without first establishing prior written consent
 * from tommy.odom@gmail.com
 */
public class HttpUploadFileCommand extends AbstractStorageServiceHttpCommand
{
    private File source;
    private String fileName;
    private String contentType;
    private String bucket;
    private String key;
    private String owner;
    private StorageServiceFileRef storageServiceFileRef;

    public HttpUploadFileCommand(String url, File source, String fileName, String contentType, String bucket, String key, String owner) {
        super(url);
        this.source = source;
        this.fileName = fileName;
        this.contentType = contentType;
        this.bucket = bucket;
        this.key = key;
        this.owner = owner;
    }

    @Override
    protected HttpMethod createMethod() throws StorageException {
        PostMethod method = new PostMethod(buildPathUrl(bucket, key));
        
        try {
            List<Part> parts = new ArrayList<Part>();
            if (owner != null) {
                parts.add(new StringPart("owner", owner));
            }
            // The FilePart has to come last in the list of parts
            parts.add(new FilePart(fileName, source, contentType, null));
            
            method.setRequestEntity(new MultipartRequestEntity(parts.toArray(new Part[parts.size()]), method.getParams()));
        }
        catch (FileNotFoundException e) {
            throw new StorageException(e.getMessage(), e);
        }
        
        return method;
    }

    @Override
    protected void onError(int statusCode) throws StorageException {
        try {
            throw new StorageException("Upload failed, the server returned an error code " + statusCode + ".  Response was " + method.getResponseBodyAsString());
        }
        catch (IOException e) {
            throw new StorageException("Upload failed, the server returned an error code " + statusCode + ".  Response was unknown");
        }
    }

    @Override
    protected void onOk() throws StorageException {
        try {
            this.storageServiceFileRef = parseStorageServiceFileRef(method.getResponseBodyAsString());
        }
        catch (IOException e) {
            throw new StorageException(e.getMessage(), e);
        }
    }

    public StorageServiceFileRef getStorageServiceFileRef() {
        return storageServiceFileRef;
    }

}
