package fineline.focal.storage.service.v1;

import fineline.focal.common.storage.FileStorage;

public class OneTimeDownloadStreamCompleteListener implements StreamCompleteListener
{
    private FileStorage fileStorage;
    private String bucket;
    private String key;
    
    public OneTimeDownloadStreamCompleteListener(FileStorage fileStorage, String bucket, String key) {
        this.fileStorage = fileStorage;
        this.bucket = bucket;
        this.key = key;
    }
    
    public void onStreamComplete() {  
        try {
            fileStorage.deleteFile(bucket, key);
        }
        catch (Exception e) {
            e.printStackTrace();
        }
    }
}
