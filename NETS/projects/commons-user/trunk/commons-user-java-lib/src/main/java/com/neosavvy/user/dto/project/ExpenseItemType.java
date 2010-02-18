package com.neosavvy.user.dto.project;

import com.neosavvy.user.dto.base.AttributeDescriptor;

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
 * Time: 10:16:34 PM
 */
@Entity
@Table(
    name="EXPENSE_ITEM_TYPE" ,
    uniqueConstraints = {
            @UniqueConstraint(columnNames = {"ID"})
    }
)
@DiscriminatorColumn(name="type")
public abstract class ExpenseItemType {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "expense_item_type_id_seq")
    @SequenceGenerator(name = "expense_item_type_id_seq", sequenceName = "expense_item_type_id_seq", allocationSize=1)
    @Column(name="ID")
    private Long id;

    @Column(name="NAME")
    private String name;

    @Column(name="DESCRIPTION")
    private String description;

    @Column(name="SORT_ORDER")
    private int sortOrder;

    @OneToMany(mappedBy="expenseItemType")
    @OrderBy("sortOrder ASC")
    private List<ExpenseItemDescriptor> descriptors;

    public ExpenseItemType(){}

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

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getSortOrder() {
        return sortOrder;
    }

    public void setSortOrder(int sortOrder) {
        this.sortOrder = sortOrder;
    }
}
