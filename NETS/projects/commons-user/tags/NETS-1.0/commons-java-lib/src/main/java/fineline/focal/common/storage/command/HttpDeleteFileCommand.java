package fineline.focal.common.storage.command;

import fineline.focal.common.types.v1.StorageServiceFileRef;
import org.apache.commons.httpclient.HttpMethod;
import org.apache.commons.httpclient.methods.DeleteMethod;

import fineline.focal.common.storage.StorageException;

/**
 * This class is a derivative work of Fineline via Tommy Odom.
 * The code herein cannot be distributed without first establishing prior written consent
 * from tommy.odom@gmail.com
 */
public class HttpDeleteFileCommand extends AbstractStorageServiceHttpCommand
{
    private StorageServiceFileRef ref;
    
    public HttpDeleteFileCommand(String url, StorageServiceFileRef ref) {
        super(url);
        this.ref = ref;
    }

    @Override
    protected HttpMethod createMethod() throws StorageException {
        return new DeleteMethod(buildPathUrl(ref));
    }

    @Override
    protected void onError(int statusCode) throws StorageException {
        throw new StorageException("Delete failed, server returned an error.");
    }

    @Override
    protected void onOk() {
        // do nothing
    }

}
