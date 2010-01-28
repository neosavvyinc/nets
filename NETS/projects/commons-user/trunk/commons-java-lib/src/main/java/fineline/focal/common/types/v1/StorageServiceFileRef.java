package fineline.focal.common.types.v1;

import java.net.URL;

import javax.activation.DataSource;
import javax.activation.URLDataSource;
import javax.persistence.Column;
import javax.persistence.DiscriminatorValue;
import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Transient;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

import com.neosavvy.security.SecuredObject;
import fineline.focal.common.utils.StringUtils;
import flex.messaging.annotations.FlexField;
import flex.messaging.annotations.FlexField.FlexFieldType;

/**
 * This class is a derivative work of Fineline via Tommy Odom.
 * The code herein cannot be distributed without first establishing prior written consent
 * from tommy.odom@gmail.com
 */
@XmlRootElement(namespace = "urn:fineline:focal:common:types:v1")
@Entity
@Table(name = "storage_service_file_refs")
@DiscriminatorValue("storage_service")
public class StorageServiceFileRef extends FileRef implements SecuredObject<StorageServiceFileRef> {
    private static final long serialVersionUID = 1L;
    
    private static String storageServiceDownloadUrl;
    
	private String bucket;
	private String key;
	private String location;
	private String fileName;
	private String contentType;
	private String owner;
	
    @Transient
	public String getDownloadURL() {
	    return storageServiceDownloadUrl + '/' + bucket + '/' + getUriEncodedKey();
	}

    @Transient
	public DataSource getDataSource() throws Exception{
	    return new URLDataSource(new URL(getDownloadURL()));
	}

	@XmlElement(required = true)
	@Column(name="bucket", length=50, nullable=false)
	public String getBucket() {
		return bucket;
	}

	public void setBucket(String bucket) {
		this.bucket = bucket;
	}

	@XmlElement(required = true)
	@Column(name="file_key", length=100, nullable=false)
	public String getKey() {
		return key;
	}

	public void setKey(String key) {
		this.key = key;
	}

	@XmlElement(required = false)
	@Column(name="file_name", length=256, nullable=true)
	public String getFileName() {
	    if (fileName == null) {
	        return getFileNameFromKey();
	    }
		return fileName;
	}
	
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	
    @XmlElement(required = false)
	@Column(name="location", length=20, nullable=true)
	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	@XmlElement(required = false)
	@Column(name="content_type", length=50, nullable=true)
	public String getContentType() {
		return contentType;
	}

	public void setContentType(String contentType) {
		this.contentType = contentType;
	}

	@XmlElement(required=false)
	@Column(name="owner", nullable=true)
	public String getOwner() {
        return owner;
    }
    public void setOwner(String owner) {
        this.owner = owner;
    }

    // This getter/setter is intended to be used by Spring to initialize the download URL
	@Transient
	@XmlTransient
	@FlexField(fieldType = FlexFieldType.Excluded)
	public String getStorageServiceDownloadUrl() {
	    return storageServiceDownloadUrl;
	}
	
	public void setStorageServiceDownloadUrl(String url) {
	    storageServiceDownloadUrl = url;
	}

    @XmlTransient
    @Transient
    public String getOwnerUsername() {
        return owner;
    }

    @XmlTransient
    @Transient
    public Class<StorageServiceFileRef> getAclClass() {
        return StorageServiceFileRef.class;
    }

    @XmlTransient
    @Transient
    public SecuredObject getAclParentObject() {
        return null;
    }

    @XmlTransient
    @Transient
    public Class getAclParentClass() {
        return Object.class;
    }

    @Transient
    private String getUriEncodedKey() {
        String[] segments = key.split("/");
        StringBuilder builder = new StringBuilder();
	    
        for (String segment : segments) {
            builder.append(StringUtils.uriEscape(segment));
	        builder.append("/");
	    }
        
        if (segments.length > 0 && !key.endsWith("/")) {
            builder.deleteCharAt(builder.length() - 1);
        }
	    
        return builder.toString();
	}
	
    @Transient
	private String getFileNameFromKey() {
	    if (StringUtils.isEmpty(getKey())) {
	        return null;
	    }
	    
        StringBuilder builder = new StringBuilder(getKey());
        int pathIndex = builder.lastIndexOf("/");
        
        if (pathIndex != -1) {
            return builder.substring(pathIndex + 1);
        }
        
        return builder.toString();	    
	}
}
