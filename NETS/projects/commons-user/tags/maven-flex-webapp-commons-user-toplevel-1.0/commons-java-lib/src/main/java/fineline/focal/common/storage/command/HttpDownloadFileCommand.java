package fineline.focal.common.storage.command;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;

import fineline.focal.common.types.v1.StorageServiceFileRef;
import org.apache.commons.httpclient.HttpMethod;
import org.apache.commons.httpclient.methods.GetMethod;

import fineline.focal.common.storage.StorageException;
import fineline.focal.common.utils.FileUtils;

/**
 * This class is a derivative work of Fineline via Tommy Odom.
 * The code herein cannot be distributed without first establishing prior written consent
 * from tommy.odom@gmail.com
 */
public class HttpDownloadFileCommand extends AbstractStorageServiceHttpCommand
{
    private StorageServiceFileRef ref;
    private File destinationFile;
    
    public HttpDownloadFileCommand(String url, StorageServiceFileRef ref, File destinationFile) {
        super(url);
        this.ref = ref;
        this.destinationFile = destinationFile;
    }
    
    @Override
    protected HttpMethod createMethod() throws StorageException {
        return new GetMethod(buildPathUrl(ref));
    }

    @Override
    protected void onError(int statusCode) throws StorageException {
        try {
            throw new StorageException("Download failed, the server returned an error code " + statusCode + ".  Response was " + method.getResponseBodyAsString());
        }
        catch (IOException e) {
            throw new StorageException("Download failed, the server returned an error code " + statusCode + ".  Response was unknown");
        }
    }

    @Override
    protected void onOk() throws StorageException {
        try {
            InputStream input = method.getResponseBodyAsStream();
            if (input == null) {
                throw new StorageException("No response received.");
            }
            
            FileUtils.writeFile(new BufferedInputStream(input), destinationFile);
        }
        catch (IOException e) {
            throw new StorageException(e.getMessage(), e);
        }
        
    }

}
