package flex.messaging.annotations;

import static java.lang.annotation.ElementType.METHOD;
import static java.lang.annotation.RetentionPolicy.RUNTIME;

import java.lang.annotation.Inherited;
import java.lang.annotation.Retention;
import java.lang.annotation.Target;

/**
 * This annotation class defines getter/setter level indicators to place within
 * remote object classes.
 * 
 * @author Brian Telintelo
 */
@Target( { METHOD })
@Retention(RUNTIME)
@Inherited
public @interface FlexField
{
    /**
     * @param ReadWrite -
     *            Indicates you have a getter and setter and want both to be
     *            populated during amf in/out.  This is the default behavior.
     * @param ReadOnly -
     *            Indicates you have a getter and setter, but when a request
     *            comes in from amf, the value in the field is compared against
     *            the value in the object's key to see if it has been modified.
     *            If the value has been modified, a ReadOnlyException is thrown.
     * @param CreateOnly -
     *            Indicates you have a getter and setter, but when a request
     *            comes in from amf, the value in the field is compared against
     *            the value in the object's key to see if it has been modified.
     *            If the value has been modified but not created,
     *            a CreateOnlyException is thrown.
     * @param Transient -
     *            If you have a single getter method that you want serialized to
     *            flex(a read only method, such as a calculation), you can use
     *            property to indicate this without having a matching setter.
     * @param Excluded -
     *            Does not send the value of a field even if matching getters
     *            and setters exist.
     */
    public abstract FlexFieldType fieldType() default FlexFieldType.ReadWrite;
    public static enum FlexFieldType{ReadWrite, ReadOnly, CreateOnly, Transient, Excluded};
}
