package fineline.focal.common.storage.command;

import java.io.ByteArrayInputStream;
import java.io.IOException;

import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Unmarshaller;

import fineline.focal.common.types.v1.StorageServiceFileRef;
import fineline.focal.common.storage.StorageException;

/**
 * This class is a derivative work of Fineline via Tommy Odom.
 * The code herein cannot be distributed without first establishing prior written consent
 * from tommy.odom@gmail.com
 */
public abstract class AbstractStorageServiceHttpCommand extends AbstractHttpClientCommand
{
    public AbstractStorageServiceHttpCommand(String url) {
        super(url);
    }

    protected StorageServiceFileRef parseStorageServiceFileRef(String xml) throws StorageException {
        ByteArrayInputStream input = new ByteArrayInputStream(xml.getBytes());
        try {
            JAXBContext jc = JAXBContext.newInstance(StorageServiceFileRef.class);
            Unmarshaller unmarshaller = jc.createUnmarshaller();
            Object result = unmarshaller.unmarshal(input);
            
            if (!(result instanceof StorageServiceFileRef)) {
                throw new StorageException("Parsing the response returned an object of type " + result.getClass().getName() + " instead of storage service file reference.");
            }
            
            return (StorageServiceFileRef)result;
        }
        catch (JAXBException e) {
            throw new StorageException("Unable to parse response. Reason: " + e.getMessage(), e);
        }
        finally {
            try {
                input.close();
            }
            catch (IOException e) {
                // ignore
            }
        }
    }
    
    protected String buildPathUrl(StorageServiceFileRef ref) throws StorageException {
        return buildPathUrl(ref.getBucket(), ref.getKey());
    }
    
    protected String buildPathUrl(String bucket, String key) throws StorageException {
        return buildUrl(url, bucket, (key == null ? "" : key));
    }
}
