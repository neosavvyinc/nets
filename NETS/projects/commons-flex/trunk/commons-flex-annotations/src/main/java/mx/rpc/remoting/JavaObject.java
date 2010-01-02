package mx.rpc.remoting;

import flex.messaging.annotations.IAnnotatedProxy;

/**
 * When using a ReadOnly or CreateOnly, the objKey is populated
 * @author Brian Telintelo
 */
public class JavaObject implements IAnnotatedProxy
{
    private String objKey;

    public String getObjKey()
    {
        return objKey;
    }

    public void setObjKey(String objKey)
    {
        this.objKey = objKey;
    }
}
