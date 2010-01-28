package fineline.focal.common.storage;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;

import fineline.focal.common.types.v1.StorageServiceFileRef;

/**
 * This class is a derivative work of Fineline via Tommy Odom.
 * The code herein cannot be distributed without first establishing prior written consent
 * from tommy.odom@gmail.com
 */
public interface FileStorage {
    StorageBucket getBucket(String name);
	File getFile(String bucket, String key) throws ResourceNotFoundException;
	File getFile(StorageServiceFileRef ref) throws ResourceNotFoundException;
	StorageServiceFileRef findFileRef(String bucket, String key);
	StorageServiceFileRef saveFile(String bucket, String key, String fileName, String contentType, InputStream data, String owner) 
	    throws ResourceNotFoundException, IOException;
	void deleteFile(String bucket, String key) throws ResourceNotFoundException, IOException;
	void updateOwnership(String oldOwner, String newOwner);
}
