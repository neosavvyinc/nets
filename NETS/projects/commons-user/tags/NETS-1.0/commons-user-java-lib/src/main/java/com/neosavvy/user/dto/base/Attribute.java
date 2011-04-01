package com.neosavvy.user.dto.base;

import javax.persistence.*;
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
 * User: adamparrish
 * Date: Jan 7, 2010
 * Time: 10:31:32 PM
 */
@MappedSuperclass
public abstract class Attribute extends BaseDTO {

    @ManyToOne
    @JoinColumn(name="DESCRIPTOR_ID")
    private AttributeDescriptor descriptor;

    @ManyToOne
    @JoinColumn(name="ENUMERATED_VALUE_ID")
    private AttributeEnumValue enumValue;

    @Column(name="STRING_VALUE", nullable = true)
    private String stringValue;

    public abstract Long getId();
    
    public AttributeDescriptor getDescriptor() {
        return descriptor;
    }

    public void setDescriptor(AttributeDescriptor descriptor) {
        this.descriptor = descriptor;
    }

    public AttributeEnumValue getEnumValue() {
        return enumValue;
    }

    public void setEnumValue(AttributeEnumValue enumValue) {
        this.enumValue = enumValue;
    }

    public String getStringValue() {
        return stringValue;
    }

    public void setStringValue(String stringValue) {
        this.stringValue = stringValue;
    }
}
