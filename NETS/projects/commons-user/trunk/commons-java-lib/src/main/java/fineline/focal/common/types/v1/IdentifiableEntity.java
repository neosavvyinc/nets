package fineline.focal.common.types.v1;

import java.io.Serializable;

/**
 * This class is a derivative work of Fineline via Tommy Odom.
 * The code herein cannot be distributed without first establishing prior written consent
 * from tommy.odom@gmail.com
 */
public interface IdentifiableEntity extends Serializable
{
    public Long getEntityId();
}
