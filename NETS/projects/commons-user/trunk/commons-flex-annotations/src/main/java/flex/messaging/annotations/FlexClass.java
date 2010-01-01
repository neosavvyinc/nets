package flex.messaging.annotations;

import static java.lang.annotation.RetentionPolicy.RUNTIME;

import java.lang.annotation.Inherited;
import java.lang.annotation.Retention;

@Retention(RUNTIME)
@Inherited
public @interface FlexClass
{
    public abstract FlexClassType classType();
    public static enum FlexClassType {RemoteService, RemoteObject};
}
