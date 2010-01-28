package com.neosavvy.security;

import flex.messaging.annotations.FlexField;

/**
 * Created by IntelliJ IDEA.
 * User: tommyodom
 * Date: Jan 17, 2010
 * Time: 1:40:27 PM
 * To change this template use File | Settings | File Templates.
 */
public interface SecuredObject<T extends Object> {
    Long getId();
    String getOwnerUsername();
    @FlexField(fieldType = FlexField.FlexFieldType.Excluded)
    Class<T> getAclClass();
    SecuredObject getAclParentObject();
    @FlexField(fieldType = FlexField.FlexFieldType.Excluded)
    Class getAclParentClass();
}
