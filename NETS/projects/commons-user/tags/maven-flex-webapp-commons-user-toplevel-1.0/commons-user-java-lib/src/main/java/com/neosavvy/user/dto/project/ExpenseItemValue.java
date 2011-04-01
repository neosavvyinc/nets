package com.neosavvy.user.dto.project;

import com.neosavvy.user.dto.base.Attribute;

import javax.persistence.*;
import java.util.Date;

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
 * Time: 10:50:45 PM
 */
@Entity
@Table(
    name="EXPENSE_ITEM_VALUE" ,
    uniqueConstraints = {
            @UniqueConstraint(columnNames = {"ID"})
    }
)
public class ExpenseItemValue extends Attribute {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "expense_item_value_id_seq")
    @SequenceGenerator(name = "expense_item_value_id_seq", sequenceName = "expense_item_value_id_seq", allocationSize=1)
	@Column(name="ID")
	private Long id;

    @ManyToOne
    @JoinColumn(name="EXPENSE_ITEM_FK")
    private ExpenseItem expenseItem;

    @Column( name = "PARTITION_DATE")
    @Temporal(TemporalType.DATE)
    private Date partitionDate;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public ExpenseItem getExpenseItem() {
        return expenseItem;
    }

    public void setExpenseItem(ExpenseItem expenseItem) {
        this.expenseItem = expenseItem;
    }

    public Date getPartitionDate() {
        return partitionDate;
    }

    public void setPartitionDate(Date partitionDate) {
        this.partitionDate = partitionDate;
    }
}
