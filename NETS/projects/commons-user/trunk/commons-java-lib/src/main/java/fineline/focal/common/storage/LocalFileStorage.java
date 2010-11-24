package fineline.focal.common.storage;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.Date;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import fineline.focal.common.types.v1.StorageServiceFileRef;
import org.apache.commons.lang.time.FastDateFormat;
import org.eclipse.persistence.config.HintValues;
import org.eclipse.persistence.config.QueryHints;
import org.im4java.core.ConvertCmd;
import org.im4java.core.IM4JavaException;
import org.im4java.core.IMOperation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import fineline.focal.common.types.v1.AbstractEntity;
import fineline.focal.common.utils.FileUtils;
import fineline.focal.common.utils.StringUtils;

/**
 * This class is a derivative work of Fineline via Tommy Odom.
 * The code herein cannot be distributed without first establishing prior written consent
 * from tommy.odom@gmail.com
 */
public class LocalFileStorage implements FileStorage {
	
    @PersistenceContext
    private EntityManager entityManager;
    private List<StorageBucket> buckets;
    
    private FastDateFormat dateFormatter = FastDateFormat.getInstance("yyyy" + File.separatorChar + "MM" + File.separatorChar + "dd");
    
    @Transactional(readOnly = true)
    public File getFile(String bucket, String key) throws ResourceNotFoundException {
        StorageServiceFileRef ref = findFileRef(bucket, key);
        if (ref == null) {
            throw new ResourceNotFoundException("The file reference for the key " + key + " was under bucket " + bucket + " was not found.");
        }
        
        return getFile(ref);
	}

    public File getFile(StorageServiceFileRef ref) throws ResourceNotFoundException {
        return getFile(ref, null);
    }


    @Transactional(readOnly = true)
    public File getFile(StorageServiceFileRef ref, String size) throws ResourceNotFoundException {
    	String bucket = ref.getBucket();
    	String key = ref.getKey();

    	File file = lookupFilePath(ref, size);
        if (!file.exists()) {
            throw new ResourceNotFoundException("The key " + key + " was not found under bucket " + bucket);
        }

        return file;    	
    }
    
    @Transactional(readOnly = true)    
    public StorageServiceFileRef findFileRef(String bucket, String key) {
        // we intentionally don't filter on status active here to allow us to operate on deleted files
    	Query query = entityManager.createQuery("SELECT s FROM StorageServiceFileRef s WHERE s.bucket = :bucket AND s.key = :key");
        query.setHint(QueryHints.REFRESH, HintValues.TRUE);
    	query.setParameter("bucket", bucket);
    	query.setParameter("key", key);
    	
    	// We use getResultList here because getSingleResult throws an exception instead of returning null which doesn't work
    	// well for our upload use case where the ref may not yet exist
    	List results = query.getResultList();
    	
    	if (results != null && !results.isEmpty()) {
    		return (StorageServiceFileRef)results.get(0);
    	}
    	
    	return null;
    }
    
    @Transactional(rollbackFor={ResourceNotFoundException.class, IOException.class})
    public StorageServiceFileRef saveFile(String bucket, String key, String fileName, String contentType, InputStream data, String owner) 
        throws ResourceNotFoundException, IOException {
        
        File bucketDir = lookupBucketDirectory(bucket);

        StorageServiceFileRef ref = findFileRef(bucket, key);
        
        String extension = FileUtils.getExtension(fileName);
        
        if (StringUtils.isEmpty(extension)) {
            extension = FileUtils.getExtensionFromContentType(contentType);
            if (!"dat".equals(extension)) {
                fileName = fileName + "." + extension;
            }
        }

        if (extension.toLowerCase().equals(FileUtils.STL_EXTENSION)) {
        	contentType = FileUtils.CONTENT_TYPE_STL;
        	extension = FileUtils.STL_EXTENSION;
        }
        
        if (ref == null) {
        	ref = createNewFileRef(bucket, key, fileName, contentType);
        	entityManager.persist(ref);
        	
        	if (StringUtils.isEmpty(key)) {
        		ref.setKey(ref.getId().toString() + extension);
        	}
        }
                
        File parentDir = bucketDir;
        
        if (ref.getLocation() != null) {
        	parentDir = new File(parentDir, ref.getLocation());
        }
        
        File file = new File(parentDir, ref.getKey());
        
        if (!parentDir.exists()) {
        	parentDir.mkdirs();
        }
                
        FileUtils.writeFile(data, file);

        writeViewableImage(ref, parentDir);
        writeThumbnailImage(ref, parentDir);

        ref.setContentType(contentType);
        ref.setFileSize(file.length());
        ref.setOwner(owner);
        ref.setLastModifiedDate(new Date());        
        ref.setRecordStatus(AbstractEntity.STATUS_ACTIVE);
        entityManager.flush();
        
    	return ref;
    }

    private void writeThumbnailImage(StorageServiceFileRef ref, File parentDir) {
        String imPath="/opt/local/bin:/usr/bin";
        ConvertCmd cmd = new ConvertCmd();
        cmd.setSearchPath(imPath);

        // create the operation, add images and operators/options
        IMOperation op = new IMOperation();
        String sourceImage = parentDir.getAbsolutePath() + "/" + ref.getKey();
        String destinationImage = sourceImage.replaceFirst(".jpg", "-thumb.jpg");
        op.addImage(sourceImage);
        op.resize(200,300);
        op.addImage(destinationImage);

        try {
            cmd.run(op);
        } catch (IOException e) {
            e.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
        } catch (InterruptedException e) {
            e.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
        } catch (IM4JavaException e) {
            e.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
        }
    }

    private void writeViewableImage(StorageServiceFileRef ref, File parentDir) {
        String imPath="/opt/local/bin:/usr/bin";
        ConvertCmd cmd = new ConvertCmd();
        cmd.setSearchPath(imPath);

        // create the operation, add images and operators/options
        IMOperation op = new IMOperation();
        String sourceImage = parentDir.getAbsolutePath() + "/" + ref.getKey();
        String destinationImage = sourceImage.replaceFirst(".jpg", "-viewable.jpg");
        op.addImage(sourceImage);
        op.resize(640,480);
        op.addImage(destinationImage);

        try {
            cmd.run(op);
        } catch (IOException e) {
            e.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
        } catch (InterruptedException e) {
            e.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
        } catch (IM4JavaException e) {
            e.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
        }
    }

    @Transactional(propagation = Propagation.REQUIRES_NEW, rollbackFor={ResourceNotFoundException.class, IOException.class})
    public void deleteFile(String bucket, String key) throws ResourceNotFoundException, IOException {
        StorageServiceFileRef ref = findFileRef(bucket, key);
        if (ref == null) {
            throw new ResourceNotFoundException("The file reference for the key " + key + " was under bucket " + bucket + " was not found.");
        }
        
        ref.setRecordStatus(AbstractEntity.STATUS_DELETED);
        entityManager.flush();
    }
    
        
    @Transactional
    public void updateOwnership(String oldOwner, String newOwner) {
        Query query = entityManager.createQuery("UPDATE StorageServiceFileRef fr SET fr.owner=:newOwner WHERE fr.owner=:oldOwner");
        query.setParameter("oldOwner", oldOwner);
        query.setParameter("newOwner", newOwner);
        query.executeUpdate();
    }
    
    private StorageServiceFileRef createNewFileRef(String bucket, String key, String fileName, String contentType) {
    	StorageServiceFileRef ref = new StorageServiceFileRef();
    	ref.setBucket(bucket);
    	ref.setLocation(dateFormatter.format(new Date()));
    	ref.setKey((StringUtils.isEmpty(key) ? "auto-assign" : key));
    	ref.setFileName(fileName);
    	ref.setContentType(contentType);
    	
    	return ref;
    }
    
    private File lookupBucketDirectory(String bucketName) throws ResourceNotFoundException {
    	StorageBucket bucket = getBucket(bucketName);
        
        if (bucket == null) {
            throw new ResourceNotFoundException("The bucket " + bucketName + " is not a known bucket.");
        }

        if (!bucket.getDirectory().exists()) {
            throw new ResourceNotFoundException("The directory for bucket " + bucketName + " does not exist");
        }
        
        return bucket.getDirectory();
    }

    private File lookupFilePath(StorageServiceFileRef ref) throws ResourceNotFoundException {
        return lookupFilePath( ref, null );
    }

    private File lookupFilePath(StorageServiceFileRef ref, String size) throws ResourceNotFoundException {
    	File parentDir = lookupBucketDirectory(ref.getBucket());
    	
        if (ref.getLocation() != null) {
        	parentDir = new File(parentDir, ref.getLocation());
        	
        	if (!parentDir.exists()) {
                throw new ResourceNotFoundException("The location of the file reference could not be found.");        		
        	}
        }

        String fileName = ref.getKey();
        if( "thumb".equals(size) )
        {
            fileName = fileName.replace(".", "-thumb.");
        }
        else if ( "viewable".equals(size) )
        {
            fileName = fileName.replace(".", "-viewable.");
        }
        
        return new File(parentDir, fileName);
    }
        
    public StorageBucket getBucket(String name) {
        for (StorageBucket bucket : buckets) {
            if (bucket.getName().equals(name)) {
                return bucket;
            }
        }
        return null;
    }

    public List<StorageBucket> getBuckets() {
        return buckets;
    }
    public void setBuckets(List<StorageBucket> buckets) {
        this.buckets = buckets;
    }
    
    
        
}
