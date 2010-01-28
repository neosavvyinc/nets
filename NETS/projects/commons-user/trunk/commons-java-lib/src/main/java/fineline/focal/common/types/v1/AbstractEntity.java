package fineline.focal.common.types.v1;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.EntityListeners;
import javax.persistence.MappedSuperclass;
import javax.persistence.PrePersist;
import javax.persistence.PreUpdate;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;
import javax.xml.bind.annotation.XmlAttribute;
import javax.xml.bind.annotation.XmlTransient;

import org.eclipse.persistence.annotations.Cache;
import org.eclipse.persistence.annotations.CacheCoordinationType;

import flex.messaging.annotations.FlexClass;
import flex.messaging.annotations.FlexField;
import flex.messaging.annotations.FlexClass.FlexClassType;
import flex.messaging.annotations.FlexField.FlexFieldType;

/**
 * This class is a derivative work of Fineline via Tommy Odom.
 * The code herein cannot be distributed without first establishing prior written consent
 * from tommy.odom@gmail.com
 */
@XmlTransient
@MappedSuperclass
@FlexClass(classType=FlexClassType.RemoteObject)
@Cache(coordinationType=CacheCoordinationType.INVALIDATE_CHANGED_OBJECTS)
@EntityListeners(EntityListenerManager.class)
public abstract class AbstractEntity implements Serializable, IdentifiableEntity 
{
	private static final long serialVersionUID = 1L;
	
	public static final char STATUS_ACTIVE = 'a';
	public static final char STATUS_TRANSIENT = 't';
	public static final char STATUS_DELETED = 'd';
	
	protected Long id;
	protected Date creationDate;
	protected Date lastModifiedDate;
	private char recordStatus = STATUS_ACTIVE;
	
	@PrePersist
	public void prePersist() {
        if (getCreationDate() == null) {
            setCreationDate(new Date());
        }
        if (getLastModifiedDate() == null) {
        	setLastModifiedDate(new Date());
        }
	}
	
	@PreUpdate
	public void preUpdate() {
	    if (getCreationDate() == null) {
	        setCreationDate(new Date());
	    }
	    
		setLastModifiedDate(new Date());
	}
	
	@XmlAttribute(required=false)
	@Transient
    @FlexField(fieldType = FlexFieldType.Excluded)
	public Long getEntityId() {
		return id;
	}
	public void setEntityId(Long id) {
		this.id = id;
	}

	@XmlAttribute(required=false)
	@Column(name="created_at", nullable=false, updatable=false)
	@Temporal(TemporalType.TIMESTAMP)
    @FlexField(fieldType=FlexFieldType.ReadWrite)
	public Date getCreationDate() {
		return creationDate;
	}
	public void setCreationDate(Date creationDate) {
		this.creationDate = creationDate;
	}
	
	@XmlAttribute(required=false)
	@Column(name="last_modified_at", nullable=false)
	@Temporal(TemporalType.TIMESTAMP)
    @FlexField(fieldType=FlexFieldType.ReadWrite)
	public Date getLastModifiedDate() {
		return lastModifiedDate;
	}
	public void setLastModifiedDate(Date lastModifiedDate) {
		this.lastModifiedDate = lastModifiedDate;
	}

	@XmlTransient
	@Column(name="record_status", nullable=false)
    @FlexField(fieldType = FlexFieldType.Excluded)
	public char getRecordStatus() {
		return recordStatus;
	}
	public void setRecordStatus(char recordStatus) {
	    if (recordStatus == '\0') {
	        this.recordStatus = STATUS_ACTIVE;
	    }
	    else {
	        this.recordStatus = recordStatus;
	    }
	}
	
	@FlexField(fieldType=FlexFieldType.Excluded)
	public boolean isStatusTransient() {
		return recordStatus == STATUS_TRANSIENT;
	}
	
    @FlexField(fieldType=FlexFieldType.Transient)
	public boolean isStatusActive() {
		return recordStatus == STATUS_ACTIVE;
	}

    @FlexField(fieldType=FlexFieldType.Excluded)
    public boolean isStatusActiveOrTransient() {
        return recordStatus == STATUS_ACTIVE || recordStatus == STATUS_TRANSIENT;
    }
    
    @XmlAttribute(name="deleted")
    @FlexField(fieldType=FlexFieldType.Transient)
    @Transient
    public boolean isStatusDeleted() {
        return recordStatus == STATUS_DELETED;
    }
    
    public void setStatusDeleted(boolean deleted) {
    	if (deleted) {
    		recordStatus = STATUS_DELETED;
    	}
    }
    
    @Override
    public int hashCode() {
        final int prime = 31;
        int result = 1;
        result = prime * result + ((id == null) ? 0 : id.hashCode());
        return result;
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (obj == null) {
            return false;
        }
        if (getClass() != obj.getClass()) {
            return false;
        }
        final AbstractEntity other = (AbstractEntity) obj;
        // if the id is null then don't consider it equal even if the
        // other object's id is null
        if (id == null) {
            return false;
        }
        else if (!id.equals(other.id)) {
            return false;
        }
        return true;
    }

    protected <EntityType extends AbstractEntity> List<EntityType> filterEntitiesByRecordStatuses(List<EntityType> entities, char... statuses) {
        if (entities == null) {
            return entities;
        }
        
        List<EntityType> filteredElements = new ArrayList<EntityType>();
        
        for (EntityType entity : entities) {
            for (char status : statuses) {
                if (entity.getRecordStatus() == status) {
                    filteredElements.add(entity);
                }
            }
        }
        
        return filteredElements;
    }
	
	
}
