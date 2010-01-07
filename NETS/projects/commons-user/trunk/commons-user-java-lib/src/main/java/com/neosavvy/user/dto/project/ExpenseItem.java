package com.neosavvy.user.dto.project;

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
 * Date: Jan 2, 2010
 * Time: 11:16:12 AM
 */
@Entity
@Table(
    name="EXPENSE_REPORT_ITEM" ,
    uniqueConstraints = {
            @UniqueConstraint(columnNames = {"ID"})
    }
)
public class ExpenseItem {

    @Id
    @GeneratedValue
	@Column(name="ID")
	private int id;
    /**
     * Depending on the type of expense there will be
     * different fields that should be saved
     * these are the common ones.
     */

    @Column(name = "EXPENSE_DATE")
    @Temporal(TemporalType.DATE)
    private Date expenseDate;

    @Column(name = "AMOUNT")
    private Double amount;

//    @OneToOne
//    @JoinColumn(name = "PAYMENT_METHOD_FK")
//    private PaymentMethod paymentMethod;

    @OneToOne
    @JoinColumn(name = "PROJECT_TYPE_FK")
    private ProjectType projectType;

    public Double getAmount() {
        return amount;
    }

    public void setAmount(Double amount) {
        this.amount = amount;
    }

    public Date getExpenseDate() {
        return expenseDate;
    }

    public void setExpenseDate(Date expenseDate) {
        this.expenseDate = expenseDate;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

//    public PaymentMethod getPaymentMethod() {
//        return paymentMethod;
//    }
//
//    public void setPaymentMethod(PaymentMethod paymentMethod) {
//        this.paymentMethod = paymentMethod;
//    }

    public ProjectType getProjectType() {
        return projectType;
    }

    public void setProjectType(ProjectType projectType) {
        this.projectType = projectType;
    }
}
