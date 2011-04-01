package fineline.focal.common.storage;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;

import fineline.focal.common.types.v1.StorageServiceFileRef;
import fineline.focal.common.utils.FileUtils;

/**
 * This class is a derivative work of Fineline via Tommy Odom.
 * The code herein cannot be distributed without first establishing prior written consent
 * from tommy.odom@gmail.com
 */
public class LocalStorageServiceClient implements StorageServiceClient {
	private FileStorage fileStorage;
	
	public void deleteFile(StorageServiceFileRef ref) throws StorageException {
		try {
			fileStorage.deleteFile(ref.getBucket(), ref.getKey());
		} catch (ResourceNotFoundException e) {
			throw new StorageException(e.getMessage(), e);
		} catch (IOException e) {
			throw new StorageException(e.getMessage(), e);
		}
	}

	public File downloadFile(StorageServiceFileRef ref) throws StorageException {
		return downloadFile(ref, null);
	}

	public File downloadFile(StorageServiceFileRef ref, File destinationFile) throws StorageException {
		try {
			File source = fileStorage.getFile(ref);
			if (destinationFile == null) {
				return source;
			}
			
			FileUtils.copyFile(source, destinationFile);
			return destinationFile;
		} catch (ResourceNotFoundException e) {
			throw new StorageException(e.getMessage(), e);
		} catch (FileNotFoundException e) {
			throw new StorageException(e.getMessage(), e);
		} catch (IOException e) {
			throw new StorageException(e.getMessage(), e);
		}
	}

	public StorageServiceFileRef findFile(String bucket, String key) {
		return fileStorage.findFileRef(bucket, key);
	}

	public InputStream getInputStream(StorageServiceFileRef ref) throws StorageException {
		try {
			return new FileInputStream(fileStorage.getFile(ref));
		} catch (FileNotFoundException e) {
			throw new StorageException(e.getMessage(), e);
		} catch (ResourceNotFoundException e) {
			throw new StorageException(e.getMessage(), e);
		}
	}

    public StorageServiceFileRef uploadFile(File source, String fileName, String bucket, String owner) throws StorageException {
        return uploadFile(source, fileName, bucket, null, owner);
    }

    public StorageServiceFileRef uploadFile(File source, String fileName, String bucket, String key, String owner) throws StorageException {
		try {
	        String name = fileName;
	        if (name == null) {
	            name = source.getName();
	        }

	        return uploadStream(new FileInputStream(source), name, FileUtils.getContentType(source), bucket, key, owner);
		} catch (FileNotFoundException e) {
			throw new StorageException(e.getMessage(), e);
		}
	}

	public void cleanupTempFiles(StorageServiceFileRef ref, File tempFile) throws StorageException {
		try {
			File sourceFile = fileStorage.getFile(ref);
			
			// if the file storage doesn't know about our ref or if 
			// the file storage points to another file other than this temp file
			// then it's safe to delete the temp file
			if (sourceFile == null || !sourceFile.equals(tempFile)) {
				tempFile.delete();
			}
		} catch (ResourceNotFoundException e) {
			throw new StorageException(e.getMessage(), e);
		}
	}
	
    public StorageServiceFileRef cloneFile(String bucket, StorageServiceFileRef ref) throws StorageException {       
        try {
            File source = fileStorage.getFile(ref);
            if (source == null || !source.exists()) {
                throw new StorageException("The source file was not found.");
            }
            
            return fileStorage.saveFile(bucket, null, ref.getFileName(), ref.getContentType(), new FileInputStream(source), ref.getOwner());
        }
        catch (ResourceNotFoundException e) {
            throw new StorageException(e.getMessage(), e);
        }
        catch (FileNotFoundException e) {
            throw new StorageException(e.getMessage(), e);
        }
        catch (IOException e) {
            throw new StorageException(e.getMessage(), e);
        }
        
    }   

    public FileStorage getFileStorage() {
		return fileStorage;
	}

	public void setFileStorage(FileStorage fileStorage) {
		this.fileStorage = fileStorage;
	}

    public StorageServiceFileRef uploadStream(InputStream source, String fileName, String contentType, String bucket, String key,
            String owner) throws StorageException {
        try {
            return fileStorage.saveFile(bucket, key, fileName, contentType, source, owner);
        }
        catch (ResourceNotFoundException e) {
            throw new StorageException(e.getMessage(), e);
        }
        catch (IOException e) {
            throw new StorageException(e.getMessage(), e);
        }
    }
    
    public void updateFileOwnership(String oldOwner, String newOwner) {
        fileStorage.updateOwnership(oldOwner, newOwner);
    }
}
