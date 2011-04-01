package fineline.focal.common.storage;

import java.io.File;
import java.io.InputStream;

import fineline.focal.common.types.v1.StorageServiceFileRef;

/**
 * This class is a derivative work of Fineline via Tommy Odom.
 * The code herein cannot be distributed without first establishing prior written consent
 * from tommy.odom@gmail.com
 */
public interface StorageServiceClient {
	InputStream getInputStream(StorageServiceFileRef ref) throws StorageException;
	
	/**
	 * Downloads the given file ref from the storage service to a temporary file if downloading remotely
	 * or if accessing the storage repository locally then the file returned is the source file.
	 * 
	 * @param ref The file to download
	 * @throws fineline.focal.common.storage.StorageException
	 * @return The downloaded file or the source file if accessing locally
	 */
	File downloadFile(StorageServiceFileRef ref) throws StorageException;
	
	/**
	 * Downloads the given file ref to the location specified by the destination file or to a temporary file if null.
	 * 
	 * @param ref The file to download
	 * @param destinationFile The location to write the download to or null.
	 * @throws fineline.focal.common.storage.StorageException
	 * @return The downloaded file or the source file if accessing locally
	 */
	File downloadFile(StorageServiceFileRef ref, File destinationFile) throws StorageException;
	
	/**
	 * Uploads the file at the given URL to the the specified bucket in the storage service.  
	 * The key will be auto-generated by the storage service.
	 * 
	 * @param source The file to upload
     * @param fileName The name of the file or null to use the source's filename.
	 * @param bucket The bucket to upload the file to
	 * @param owner The username of the user who owns the file
	 * @throws fineline.focal.common.storage.StorageException
	 * @return A reference to the uploaded file
	 */
	StorageServiceFileRef uploadFile(File source, String fileName, String bucket, String owner) throws StorageException;

    /**
     * Uploads the file at the given URL to the the specified bucket in the storage service.  
     * The key will be auto-generated by the storage service.
     * 
     * @param source The file to upload
     * @param fileName The name of the file or null to use the source's filename.
     * @param bucket The bucket to upload the file to
     * @param key The key to assign to the file
     * @param owner The username of the user who owns the file
     * @throws fineline.focal.common.storage.StorageException
     * @return A reference to the uploaded file
     */
    StorageServiceFileRef uploadFile(File source, String fileName, String bucket, String key, String owner) throws StorageException;

    /**
     * Uploads the stream to the the specified bucket in the storage service.  
     * The key is used to uniquely identify the file within the bucket.  If the key already exists
     * then the storage service will replace the file contents with the new stream contents. 
     * 
     * @param source The stream to upload
     * @param fileName The name of the file or null to use the source's filename.
     * @param contentType The content type to use for the source content
     * @param bucket The bucket to upload the file to
     * @param key The unique identifier of the file within the bucket
     * @param overwriteOriginal true if the original file version should be overwritten
     * @param owner The username of the user who owns the file
     * @throws fineline.focal.common.storage.StorageException
     * @return A reference to the uploaded file
     */
    StorageServiceFileRef uploadStream(InputStream source, String fileName, String contentType, String bucket, String key, String owner) throws StorageException;

	/**
	 * Attempts to locate a file with the unique identifier of key in the specified bucket in the storage service.
	 * 
	 * @param bucket The bucket to search in
	 * @param key The unique identifier of the file to find
	 * @throws fineline.focal.common.storage.StorageException
	 * @return A reference to the file in the storage service or null if not found
	 */
	StorageServiceFileRef findFile(String bucket, String key) throws StorageException;
	
	/**
	 * Removes the file reference from the storage service. 
	 * 
	 * @param ref The file reference to remove
	 * @throws fineline.focal.common.storage.StorageException
	 */
	void deleteFile(StorageServiceFileRef ref) throws StorageException;
	
	/**
	 * Deletes the local temporary file if necessary.
	 * 
	 * @param ref The file reference related to the temporary file
	 * @param tempFile The potential temporary file that needs to be deleted
	 * @throws fineline.focal.common.storage.StorageException
	 */
	void cleanupTempFiles(StorageServiceFileRef ref, File tempFile) throws StorageException;
	
    /**
     * Creates a copy of the file using an auto-assigned key name.
     * 
     * @param bucket The bucket to store the clone in
     * @param ref The file reference to clone
     * @throws fineline.focal.common.storage.StorageException
     * @return A reference to the newly created file reference
     */
    StorageServiceFileRef cloneFile(String bucket, StorageServiceFileRef ref) throws StorageException;
    
    /**
     * Sets owner to the newOwner for all files that are currently owned by the oldOwner.
     * 
     * @param oldOwner
     * @param newOwner
     */
    void updateFileOwnership(String oldOwner, String newOwner);
}
