package com.neosavvy.user.dto.base;

import javax.persistence.*;
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
 * User: adamparrish
 * Date: Jan 7, 2010
 * Time: 10:22:53 PM
 */
@Entity
@Table(
    name="ATTRIBUTE_DESCRIPTOR" ,
    uniqueConstraints = {
            @UniqueConstraint(columnNames = {"ID"})
    }
)
@Inheritance(strategy = InheritanceType.JOINED)
@DiscriminatorColumn( name = "TYPE", length = 50)
public class AttributeDescriptor extends BaseDTO {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "attribute_descriptor_id_seq")
    @SequenceGenerator(name = "attribute_descriptor_id_seq", sequenceName = "attribute_descriptor_id_seq", allocationSize=1)
    @Column(name="ID")
    private Long id;

    @Column(name="NAME")
    private String name;

    @Column(name="DESCRIPTION")
    private String description;

    @Column(name="SORT_ORDER")
    private int sortOrder;

    @Enumerated( value = EnumType.STRING )
    private AttributeType valueType;

    /**
     * If the AttributeType is "ENUMERATED"
     * it should have a list of possible values 
     */
    @OneToMany(mappedBy="descriptor")
    @OrderBy(value = "sortOrder")
    private List<AttributeEnumValue> possibleValues;

    /**
     * If the AttributeType is FLOAT then
     * it should read the precision to display how
     * many decimal places of precision to display
     */
    @Column(name="PRECISION")
    private int precision = 2;

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public List<AttributeEnumValue> getPossibleValues() {
        return possibleValues;
    }

    public void setPossibleValues(List<AttributeEnumValue> possibleValues) {
        this.possibleValues = possibleValues;
    }

    public int getPrecision() {
        return precision;
    }

    public void setPrecision(int precision) {
        this.precision = precision;
    }

    public int getSortOrder() {
        return sortOrder;
    }

    public void setSortOrder(int sortOrder) {
        this.sortOrder = sortOrder;
    }

    public AttributeType getValueType() {
        return valueType;
    }

    public void setValueType(AttributeType valueType) {
        this.valueType = valueType;
    }
}
