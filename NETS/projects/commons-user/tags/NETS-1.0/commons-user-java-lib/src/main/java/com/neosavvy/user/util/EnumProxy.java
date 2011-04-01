package com.neosavvy.user.util;

import flex.messaging.io.AbstractProxy;
import flex.messaging.io.BeanProxy;

import java.util.Collections;
import java.util.List;
/*************************************************************************
 *
 * NEOSAVVY CONFIDENTIAL
 * __________________
 *
 *  Copyright 2008 - 2009 Neosavvy Incorporated
 *  All Rights Reserved.
 *
 * NOTICE:  All information contained herein is, and remains
 * the property of Neosavvy Incorporated and its suppliers,
 * if any.  The intellectual and technical concepts contained
 * herein are proprietary to Neosavvy Incorporated
 * and its suppliers and may be covered by U.S. and Foreign Patents,
 * patents in process, and are protected by trade secret or copyright law.
 * Dissemination of this information or reproduction of this material
 * is strictly forbidden unless prior written permission is obtained
 * from Neosavvy Incorporated.
 **************************************************************************/

/**
 * User: tommyodom
 * Date: Feb 14, 2010
 * Time: 1:20:06 PM
 */
public class EnumProxy extends BeanProxy {
    static final String ACTION_SCRIPT_VALUE_NAME = "value";
    static List propertyNames =
            Collections.singletonList(ACTION_SCRIPT_VALUE_NAME);

    public Object createInstance(String className) {
        Class cl = AbstractProxy.getClassFromClassName(className);

        if (cl.isEnum()) {
            return new EnumStub(cl);
        } else
            throw new IllegalArgumentException("**** samples.EnumProxy registered for a class which is not an enum: " + cl.getName());
    }

    public Object getValue(Object instance, String propertyName) {
        if (propertyName.equals(ACTION_SCRIPT_VALUE_NAME))
            return instance.toString();

        throw new IllegalArgumentException("No property named: " +
                propertyName + " on enum type");
    }

    public void setValue(Object instance, String propertyName, Object
            value) {
        EnumStub es = (EnumStub) instance;
        if (propertyName.equals(ACTION_SCRIPT_VALUE_NAME))
            es.value = (String) value;
        else
            throw new IllegalArgumentException("no EnumStub property:" + propertyName);
    }

    public Object instanceComplete(Object instance) {
        EnumStub es = (EnumStub) instance;
        return Enum.valueOf(es.cl, es.value);
    }

    public List getPropertyNames(Object instance) {
        if (!(instance instanceof Enum))
            throw new IllegalArgumentException("getPropertyNames called with non Enum object");
        return propertyNames;
    }

    class EnumStub {
        EnumStub(Class c) {
            cl = c;
        }

        Class cl;
        String value;
    }

}