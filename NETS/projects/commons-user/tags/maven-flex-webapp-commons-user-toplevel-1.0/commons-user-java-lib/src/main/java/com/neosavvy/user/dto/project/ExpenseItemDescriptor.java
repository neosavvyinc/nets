package com.neosavvy.user.dto.project;

import com.neosavvy.user.dto.base.AttributeDescriptor;

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
@Entity
@Table(name="EXPENSE_ITEM_DESCRIPTOR")
@DiscriminatorValue("EXPENSE_ITEM_DESCRIPTOR")
public class ExpenseItemDescriptor extends AttributeDescriptor {
    @ManyToOne
    @JoinColumn(name="EXPENSE_ITEM_TYPE_FK")
    private ExpenseItemType expenseItemType;

    public ExpenseItemType getExpenseItemType() {
        return expenseItemType;
    }

    public void setExpenseItemType(ExpenseItemType expenseItemType) {
        this.expenseItemType = expenseItemType;
    }
}
