package fineline.focal.common.types.v1;

import flex.messaging.annotations.FlexClass;
import flex.messaging.annotations.FlexField;

import java.io.Serializable;

/**
 * This class is a derivative work of Fineline via Tommy Odom.
 * The code herein cannot be distributed without first establishing prior written consent
 * from tommy.odom@gmail.com
 */
@FlexClass(classType= FlexClass.FlexClassType.RemoteObject)
public interface IdentifiableEntity extends Serializable
{
    @FlexField(fieldType = FlexField.FlexFieldType.Excluded)
    public Long getEntityId();
}
