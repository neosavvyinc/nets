package flex.messaging.io;

import java.beans.BeanInfo;
import java.beans.IntrospectionException;
import java.beans.Introspector;
import java.beans.PropertyDescriptor;
import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import mx.rpc.remoting.JavaObject;
import flex.messaging.annotations.FlexClass;
import flex.messaging.annotations.FlexField;
import flex.messaging.annotations.FlexClass.FlexClassType;
import flex.messaging.annotations.FlexField.FlexFieldType;
import flex.messaging.util.Base64;

/**
 * This class extends the standard bean proxy class by allowing the
 * user to place annotations on their remote objects to control whether BlazeDS
 * reads them.
 * @author Brian Telintelo 
 */
public class AnnotatedBeanProxy extends BeanProxy
{
    private static final long serialVersionUID = 1474503168845815055L;
    
    /**
     * Look at each bean property and see if a transient or exclude 
     * annotation is present, if one or both are present, add
     * the bean properties to the static map appropriatly.
     * @author Brian Telintelo
     */
    @SuppressWarnings("unchecked")
    @Override
    protected Map getBeanProperties(Object instance)
    {
        if(!isAnnotatedClass(instance))
            return super.getBeanProperties(instance);
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

            if (readMethod != null && isPublicAccessor(readMethod.getModifiers()))
            {
                FlexField flexField = readMethod.getAnnotation(FlexField.class);
                
                FlexFieldType fieldType = flexField!=null?flexField.fieldType():FlexFieldType.ReadWrite;
                
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

        // Then add public fields to list if property does not alreay exist
        // TODO BT - not sure if this code should be removed, but it is in the super
        // class BeanProxy, so I have left it.  
        Field[] fields = instance.getClass().getFields();
        for (int i = 0; i < fields.length; i++)
        {
            Field field = fields[i];
            String propertyName = field.getName();
            int modifiers = field.getModifiers();
            if (isPublicField(modifiers) && !props.containsKey(propertyName))
            {
                if (excludes != null && excludes.contains(propertyName))
                    continue;

                if (isPropertyIgnored(c, propertyName))
                    continue;

                props.put(propertyName,
                        new BeanProperty(propertyName, field.getType(), null, null, field));
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

    /**
     * This method gets called right after AMFInput.  Any fields
     * marked with annotations of type CreateOnly or ReadOnly will
     * be compared against the decoded object's key to determine if they
     * have been modified improperly by the client
     * @author Brian Telintelo
     */
    @Override
    public Object instanceComplete(Object instance)
    {
        if(!isAnnotatedClass(instance) || !(instance instanceof JavaObject))
        {
            //The class isn't annotated nor is it an instance of JavaObject,
            //we need both of these to proceed with processing.
            return instance;
        }
        Map<String, String> decodedValues = new HashMap<String, String>();
        Base64.Decoder dec = new Base64.Decoder();
        String encKey = ((JavaObject) instance).getObjKey();
        if(encKey!=null)
        {
            dec.decode(encKey);
            String key = new String(dec.drain());
            String[] valArr = key.split(",");
            for(int a=0; a<valArr.length ; a++)
            {   
                String[] nvPair = valArr[a].split("=");
                decodedValues.put(nvPair[0], nvPair[1]);
            }
        }
        PropertyDescriptor [] pd =  getPropertyDescriptors(instance.getClass());
        for(int x=0; x<pd.length; x++)
        {
            Method m = pd[x].getReadMethod();
            if(m!=null)
            {
                FlexField flexField = m.getAnnotation(FlexField.class);
                FlexFieldType fieldType = flexField!=null?flexField.fieldType():FlexFieldType.ReadWrite;

                Object result = null;
                if(fieldType == FlexFieldType.ReadOnly || fieldType == FlexFieldType.CreateOnly)
                {
                    try
                    {
                        result = m.invoke(instance, (Object[])null);
                    }
                    catch (Throwable t)
                    { 
                        t.printStackTrace();
                    }
                    String newValue = decodedValues.get(m.getName());                       
                    
                    if(fieldType == FlexFieldType.CreateOnly && newValue!=null)
                    {  
                        if(result==null || !newValue.equals(result.toString()))
                        {
                            //The field is create only and the value passed is different that the 
                            //value we think should live here, so throw a CreateOnlyException
                            throw new CreateOnlyException("Cannot modify the field[" + m.getName() + "], " +
                                    "previous value=" + newValue + ", new value=" + result);
                        }
                    }
                    else if(fieldType == FlexFieldType.ReadOnly && newValue!=null 
                            && !newValue.equals(result.toString()) && result!=null)
                    {
                        //The field is read only and the value passed is not equal, 
                        //so throw a ReadOnlyException
                        throw new ReadOnlyException("Cannot modify the field[" + m.getName() + "], " +
                                "previous value=" + newValue + ", new value=" + result);
                    }                         

                }                
                
            }
        }    
        return instance;
    }

    /**
     * This method gets called right before AMFOutput.  Any fields
     * marked with annotations of type CreateOnly or ReadOnly are used to make
     * up an object's key value. 
     * @author Brian Telintelo
     */
    @Override
    public Object getInstanceToSerialize(Object instance)
    {
        if(!isAnnotatedClass(instance) || !(instance instanceof JavaObject))
        {
            //The class isn't annotated nor is it an instance of JavaObject,
            //we need both of these to proceed with processing.
            return instance;
        }
        PropertyDescriptor [] pd =  getPropertyDescriptors(instance.getClass());
        String keyString = "";
        for(int x=0; x<pd.length; x++)
        {
            Method m = pd[x].getReadMethod();
            if(m!=null)
            {
                FlexField flexField = m.getAnnotation(FlexField.class);
                FlexFieldType fieldType = flexField!=null?flexField.fieldType():FlexFieldType.ReadWrite;
                if(fieldType == FlexFieldType.ReadOnly || fieldType == FlexFieldType.CreateOnly)
                {
                    Object newValue = null;
                    try
                    {
                        newValue = m.invoke(instance, (Object[])null);
                    }
                    catch (Throwable t)
                    {
                        t.printStackTrace();
                    }
                    if(newValue!=null)
                    {
                        //Put the method name and value in a pair
                        keyString += m.getName() + "=" + newValue + ",";
                    }        
                }
            }
        }    

        if(keyString!=null && keyString.length() > 0)
        {
            Base64.Encoder enc = new Base64.Encoder(keyString.getBytes().length);
            enc.encode(keyString.getBytes());        
            ((JavaObject) instance).setObjKey(enc.flush());
        }

        return instance;
    }
    
    /**
     * Checks to make sure the instance class is properly annotated before
     * doing any of the work of checking method level annotations.
     * @author Brian Telintelo
     * @param instance
     * @return
     */
    private boolean isAnnotatedClass(Object instance)
    {
        if(!(instance.getClass().isAnnotationPresent(FlexClass.class)))
        {
            return false;
        }
        if(instance.getClass().getAnnotation(FlexClass.class).classType()!=FlexClassType.RemoteObject)
        {
            return false;
        }
            
        return true;
    }
    
   /**
    * Brian Telintelo 
    * This method is deleted when code is added to BlazeDS code base.  
    * Same Method needs to be marked protected in BeanProxy.java
    */
    @SuppressWarnings("unchecked")
	protected PropertyDescriptor [] getPropertyDescriptors(Class c)
    {
        PropertyDescriptorCacheEntry pce = getPropertyDescriptorCacheEntry(c);
        if (pce == null)
            return null;
        return pce.propertyDescriptors;
    }

    /**
     * Brian Telintelo 
     * This method is deleted when code is added to BlazeDS code base.
     */
    @SuppressWarnings("unchecked")
	private PropertyDescriptorCacheEntry getPropertyDescriptorCacheEntry(Class c)
    {
        PropertyDescriptorCacheEntry pce = (PropertyDescriptorCacheEntry) propertyDescriptorCache.get(c);

        try
        {
            if (pce == null)
            {
                BeanInfo beanInfo = Introspector.getBeanInfo(c, stopClass);
                pce = new PropertyDescriptorCacheEntry();
                pce.propertyDescriptors = beanInfo.getPropertyDescriptors();
                pce.propertiesByName = createPropertiesByNameMap(pce.propertyDescriptors, c.getFields());
                if (cachePropertiesDescriptors)
                {
                    synchronized(propertyDescriptorCache)
                    {
                        PropertyDescriptorCacheEntry pce2 = (PropertyDescriptorCacheEntry) propertyDescriptorCache.get(c);
                        if (pce2 == null)
                            propertyDescriptorCache.put(c, pce);
                        else
                            pce = pce2;
                    }
                }
            }
        }
        catch (IntrospectionException ex)
        {
            return null;
        }
        return pce;
    }

    /**
     * Brian Telintelo 
     * This method is deleted when code is added to BlazeDS code base.
     */
    @SuppressWarnings("unchecked")
	private Map createPropertiesByNameMap(PropertyDescriptor [] pds, Field [] fields)
    {
        Map m = new HashMap(pds.length);
        for (int i = 0; i < pds.length; i++)
        {
            PropertyDescriptor pd = pds[i];
            Method readMethod = pd.getReadMethod();
            if (readMethod != null && isPublicAccessor(readMethod.getModifiers()) &&
                (includeReadOnly || pd.getWriteMethod() != null))
                m.put(pd.getName(), pd);
        }
        for (int i = 0; i < fields.length; i++)
        {
            Field field = fields[i];

            if (isPublicField(field.getModifiers()) && !m.containsKey(field.getName()))
                m.put(field.getName(), field);
        }
        return m;
    }
}
