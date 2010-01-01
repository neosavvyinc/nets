package com.neosavvy.user.util;

import flex.messaging.annotations.IAnnotatedProxy;
import flex.messaging.io.AnnotatedBeanProxy;
import flex.messaging.io.PropertyProxyRegistry;
import org.springframework.beans.factory.InitializingBean;

/**
 * Created by IntelliJ IDEA.
 * User: tommyodom
 * Date: Dec 27, 2009
 * Time: 5:32:02 PM
 * To change this template use File | Settings | File Templates.
 */
public class FlexInitializer implements InitializingBean {
    public void afterPropertiesSet () {
        PropertyProxyRegistry.getRegistry().register(IAnnotatedProxy.class, new AnnotatedBeanProxy());
    }
}
