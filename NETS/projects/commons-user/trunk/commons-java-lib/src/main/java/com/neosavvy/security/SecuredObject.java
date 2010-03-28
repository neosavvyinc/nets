package com.neosavvy.security;

import flex.messaging.annotations.FlexClass;
import flex.messaging.annotations.FlexField;

public interface SecuredObject<T extends Object> {
    Long getId();
    String getOwnerUsername();
    Class<T> getAclClass();
    SecuredObject getAclParentObject();
    Class getAclParentClass();
}
