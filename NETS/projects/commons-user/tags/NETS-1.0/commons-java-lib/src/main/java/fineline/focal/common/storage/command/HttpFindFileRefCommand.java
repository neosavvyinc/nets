package fineline.focal.common.storage.command;

import java.io.IOException;

import fineline.focal.common.types.v1.StorageServiceFileRef;
import org.apache.commons.httpclient.HttpMethod;
import org.apache.commons.httpclient.methods.GetMethod;

import fineline.focal.common.storage.StorageException;

/**
 * This class is a derivative work of Fineline via Tommy Odom.
 * The code herein cannot be distributed without first establishing prior written consent
 * from tommy.odom@gmail.com
 */
public class HttpFindFileRefCommand extends AbstractStorageServiceHttpCommand
{
    private String bucket;
    private String key;
    private StorageServiceFileRef storageServiceFileRef = null;
    
    public HttpFindFileRefCommand(String url, String bucket, String key) {
        super(url);
        this.bucket = bucket;
        this.key = key;
    }

    
    @Override
    protected HttpMethod createMethod() throws StorageException {
        return new GetMethod(buildPathUrl(bucket, key));
    }

    @Override
    protected void onError(int statusCode) throws StorageException {
        // ignore, we'll treat this as not found and handle it by returning a null file ref
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
