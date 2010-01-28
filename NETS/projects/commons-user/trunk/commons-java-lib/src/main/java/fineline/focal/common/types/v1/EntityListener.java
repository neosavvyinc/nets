package fineline.focal.common.types.v1;

/**
 * This class is a derivative work of Fineline via Tommy Odom.
 * The code herein cannot be distributed without first establishing prior written consent
 * from tommy.odom@gmail.com
 */
public interface EntityListener
{
    public void postLoad(Object entity);
    public void postPersist(Object entity);
    public void postRemove(Object entity);
    public void postUpdate(Object entity);
    public void prePersist(Object entity);
    public void preRemove(Object entity);
    public void preUpdate(Object entity);
}
