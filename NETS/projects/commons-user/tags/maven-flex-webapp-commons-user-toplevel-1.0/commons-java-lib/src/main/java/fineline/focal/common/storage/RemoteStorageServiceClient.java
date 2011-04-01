package fineline.focal.common.storage;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.net.MalformedURLException;
import java.net.URL;

import fineline.focal.common.types.v1.StorageServiceFileRef;
import fineline.focal.common.storage.command.HttpCloneFileCommand;
import fineline.focal.common.storage.command.HttpDeleteFileCommand;
import fineline.focal.common.storage.command.HttpDownloadFileCommand;
import fineline.focal.common.storage.command.HttpFindFileRefCommand;
import fineline.focal.common.storage.command.HttpUploadFileCommand;
import fineline.focal.common.utils.FileUtils;

/**
 * This class is a derivative work of Fineline via Tommy Odom.
 * The code herein cannot be distributed without first establishing prior written consent
 * from tommy.odom@gmail.com
 */
public class RemoteStorageServiceClient implements StorageServiceClient
{
    private String storageServiceFileUrl;
    private String storageServiceFileRefUrl;
    private String storageServiceRevertFileRefUrl;
    private String storageServiceCloneFileRefUrl;

    public void cleanupTempFiles(StorageServiceFileRef ref, File tempFile) {
        // We always want to delete in remote because we can't be pointing to
        // the same thing as the server.
        tempFile.delete();
    }

    public void deleteFile(StorageServiceFileRef ref) throws StorageException {
        HttpDeleteFileCommand command = new HttpDeleteFileCommand(getStorageServiceFileUrl(), ref);
        command.execute();
    }

    public File downloadFile(StorageServiceFileRef ref) throws StorageException {
        return downloadFile(ref, null);
    }

    public File downloadFile(StorageServiceFileRef ref, File destinationFile) throws StorageException {
        
        try {
            if (destinationFile == null) {
                destinationFile = File.createTempFile("storageDownload", null);
            }
            
            HttpDownloadFileCommand command = new HttpDownloadFileCommand(getStorageServiceFileUrl(), ref, destinationFile);
            command.execute();
        }
        catch (Exception e) {
            throw new StorageException(e.getMessage(), e);
        }
        
        return destinationFile;
    }

    public StorageServiceFileRef findFile(String bucket, String key) throws StorageException {
        HttpFindFileRefCommand command = new HttpFindFileRefCommand(getStorageServiceFileRefUrl(), bucket, key);
        command.execute();
        return command.getStorageServiceFileRef();
    }
        
    public InputStream getInputStream(StorageServiceFileRef ref) throws StorageException {
        try {
            URL url = new URL(buildFilePath(ref.getBucket(), ref.getKey()));
            return url.openStream();
        }
        catch (MalformedURLException e) {
            throw new StorageException("Invalid storage URL " + buildFilePath(ref.getBucket(), ref.getKey()), e);
        }
        catch (IOException e) {
            throw new StorageException(e.getMessage(), e);
        }
    }

    public StorageServiceFileRef uploadFile(File source, String fileName, String bucket, String owner) throws StorageException {
        return uploadFile(source, fileName, bucket, null, owner);
    }

    public StorageServiceFileRef uploadFile(File source, String fileName, String bucket, String key, String owner) throws StorageException {
        String name = fileName;
        if (name == null) {
            name = source.getName();
        }
        
        HttpUploadFileCommand command = new HttpUploadFileCommand(getStorageServiceFileUrl(), source, name, FileUtils.getContentType(source), bucket, key, owner);
        command.execute();
        return command.getStorageServiceFileRef();
    }

    public StorageServiceFileRef cloneFile(String bucket, StorageServiceFileRef ref) throws StorageException {
        HttpCloneFileCommand command = new HttpCloneFileCommand(getStorageServiceCloneFileRefUrl(), bucket, ref.getBucket(), ref.getKey());
        command.execute();
        return command.getStorageServiceFileRef();
    }

    protected String buildFilePath(String bucket, String key) {
        return getStorageServiceFileUrl() + "/" + bucket + "/" + key;
    }
    
    protected String buildFileRefPath(String bucket, String key) {
        return getStorageServiceFileRefUrl() + "/" + bucket + "/" + key;
    }

    public String getStorageServiceFileUrl() {
        return storageServiceFileUrl;
    }

    public void setStorageServiceFileUrl(String storageServiceFileUrl) {
        this.storageServiceFileUrl = storageServiceFileUrl;
    }

    public String getStorageServiceFileRefUrl() {
        return storageServiceFileRefUrl;
    }

    public void setStorageServiceFileRefUrl(String storageServiceFileRefUrl) {
        this.storageServiceFileRefUrl = storageServiceFileRefUrl;
    }

    public String getStorageServiceRevertFileRefUrl() {
        return storageServiceRevertFileRefUrl;
    }

    public void setStorageServiceRevertFileRefUrl(String storageServiceRevertFileRefUrl) {
        this.storageServiceRevertFileRefUrl = storageServiceRevertFileRefUrl;
    }

    public String getStorageServiceCloneFileRefUrl() {
        return storageServiceCloneFileRefUrl;
    }

    public void setStorageServiceCloneFileRefUrl(String storageServiceCloneFileRefUrl) {
        this.storageServiceCloneFileRefUrl = storageServiceCloneFileRefUrl;
    }

    public StorageServiceFileRef uploadStream(InputStream source, String fileName, String contentType, String bucket, String key,
            String owner) throws StorageException {
        File tempFile;
        try {
            tempFile = File.createTempFile("upload", null);
            FileUtils.writeFile(source, tempFile);
        }
        catch (IOException e) {
            throw new StorageException(e);
        }
        
        try {
            HttpUploadFileCommand command = new HttpUploadFileCommand(getStorageServiceFileUrl(), tempFile, fileName, contentType, bucket, key, owner);
            command.execute();
            return command.getStorageServiceFileRef();
            
        }
        finally {
            tempFile.delete();
        }
    }
    
    public void updateFileOwnership(String oldOwner, String newOwner) {
        // TODO: Implement me
    }
}
