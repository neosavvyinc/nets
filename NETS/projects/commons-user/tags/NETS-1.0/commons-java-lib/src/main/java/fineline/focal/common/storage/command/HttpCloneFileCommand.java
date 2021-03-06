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
public class HttpCloneFileCommand extends AbstractStorageServiceHttpCommand
{
    private String destinationBucket;
    private String sourceBucket;
    private String key;
    private StorageServiceFileRef storageServiceFileRef = null;
    
    public HttpCloneFileCommand(String url, String destinationBucket, String sourceBucket, String key) {
        super(url);
        this.destinationBucket = destinationBucket;
        this.sourceBucket = sourceBucket;
        this.key = key;
    }
    
    @Override
    protected HttpMethod createMethod() throws StorageException {
        return new GetMethod(buildUrl(url, destinationBucket, sourceBucket, (key == null ? "" : key)));
    }

    @Override
    protected void onError(int statusCode) throws StorageException {
        try {
            throw new StorageException("Clone file failed, the server returned an error code " + statusCode + ".  Response was " + method.getResponseBodyAsString());
        }
        catch (IOException e) {
            throw new StorageException("Clone file failed, the server returned an error code " + statusCode + ".  Response was unknown");
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
