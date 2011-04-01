package flex.messaging.io;

import java.beans.PropertyDescriptor;
import java.lang.reflect.Method;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import flex.messaging.annotations.FlexField;
import flex.messaging.annotations.FlexField.FlexFieldType;
import flex.messaging.io.BeanProxy.BeanProperty;
import flex.messaging.util.Base64;

public class ExceptionBeanProxy extends BeanProxy
{
    private static final long serialVersionUID = 1L;
    
    /**
     * Exceptions we only want to allow the message and explicity flexfield annotated properties 
     * to be serialized to avoid the side effects of calling getter methods on beans contained
     * within the exception.  We had a problem with EclipseLink database exceptions
     * containing descriptor objects and calling getInheritancePolicy() causes 
     * the descriptor to get modified incorrectly.
     */
    @SuppressWarnings("unchecked")
    @Override
    protected Map getBeanProperties(Object instance)
    {
        if(!(instance instanceof Exception)) {
            return super.getBeanProperties(instance);
        }
        Class c = instance.getClass();
        Map props;
        if (descriptor == null)
        {
            props = (Map)beanPropertyCache.get(c);
            if (props != null)
            {
                return props;
            }
        }

        props = new HashMap();
        PropertyDescriptor[] pds = getPropertyDescriptors(c);
        if (pds == null)
            return null;

        List excludes = null;
        if (descriptor != null)
        {
            excludes = descriptor.getExcludesForInstance(instance);
            if (excludes == null) // For compatibility with older implementations
                excludes = descriptor.getExcludes();
        }

        // Add standard bean properties first
        for (int i = 0; i < pds.length; i++)
        {
            PropertyDescriptor pd = pds[i];
            String propertyName = pd.getName();
            Method readMethod = pd.getReadMethod();
            Method writeMethod = pd.getWriteMethod();

            if (propertyName.equals("message"))
            {
                props.put(propertyName, new BeanProperty(propertyName, pd.getPropertyType(),
                        readMethod, writeMethod, null));
            }
            else if (readMethod != null && isPublicAccessor(readMethod.getModifiers()))
            {
                FlexField flexField = readMethod.getAnnotation(FlexField.class);
                
                FlexFieldType fieldType = flexField!=null?flexField.fieldType():FlexFieldType.ReadWrite;
                
                // If there is no FlexField definition then skip the property
                if (flexField == null) {
                    continue;
                }
                
                //There is no write method, but there is a read method and it is marked
                //as transient, so we still want to add it to the property cache.
                //Field will not be written when amf input occurs
                if (writeMethod == null && !(fieldType == FlexFieldType.Transient))
                    continue;

                //A Read and write method exist, but the exclude annotation
                //tells us to ignore this field.
                if (fieldType == FlexFieldType.Excluded)
                    continue;

                props.put(propertyName, new BeanProperty(propertyName, pd.getPropertyType(),
                        readMethod, writeMethod, null));
            }
        }


        if (descriptor == null && cacheProperties)
        {
            synchronized(beanPropertyCache)
            {
                Map props2 = (Map)beanPropertyCache.get(c);
                if (props2 == null)
                    beanPropertyCache.put(c, props);
                else
                    props = props2;
            }
        }

        return props;
    }

}
