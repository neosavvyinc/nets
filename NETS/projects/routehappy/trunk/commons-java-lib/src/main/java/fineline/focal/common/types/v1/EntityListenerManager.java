package fineline.focal.common.types.v1;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.PostLoad;
import javax.persistence.PostPersist;
import javax.persistence.PostRemove;
import javax.persistence.PostUpdate;
import javax.persistence.PrePersist;
import javax.persistence.PreRemove;
import javax.persistence.PreUpdate;
import javax.persistence.Transient;
import javax.xml.bind.annotation.XmlTransient;


/**
 * This class is a derivative work of Fineline via Tommy Odom.
 * The code herein cannot be distributed without first establishing prior written consent
 * from tommy.odom@gmail.com
 */
public class EntityListenerManager
{
    private static List<EntityListener> listeners = new ArrayList<EntityListener>();
//
//    This getter/setter is intended to be used by Spring to inject Spring-managed EntityListeners
//    @Transient
//    @XmlTransient
//    @FlexField(fieldType = FlexFieldType.Excluded)
//    public List<EntityListener> getListeners() {
//        return listeners;
//    }
    
    public void setListeners(List<EntityListener> listeners) {
        EntityListenerManager.listeners = listeners;
    }
    
    @PostLoad
    public void postLoad(Object entity) {
        for (EntityListener listener : listeners) {
            listener.postLoad(entity);
        }
    }
    
    @PostPersist
    public void postPersist(Object entity) {
        for (EntityListener listener : listeners) {
            listener.postPersist(entity);
        }
    }
    
    @PostRemove
    public void postRemove(Object entity) {
        for (EntityListener listener : listeners) {
            listener.postRemove(entity);
        }
    }
    
    @PostUpdate
    public void postUpdate(Object entity) {
        for (EntityListener listener : listeners) {
            listener.postUpdate(entity);
        }
    }
    
    @PrePersist
    public void prePersist(Object entity) {
        for (EntityListener listener : listeners) {
            listener.prePersist(entity);
        }
    }
    
    @PreRemove
    public void preRemove(Object entity) {
        for (EntityListener listener : listeners) {
            listener.preRemove(entity);
        }
    }
    
    @PreUpdate
    public void preUpdate(Object entity) {
        for (EntityListener listener : listeners) {
            listener.preUpdate(entity);
        }
    }
}
