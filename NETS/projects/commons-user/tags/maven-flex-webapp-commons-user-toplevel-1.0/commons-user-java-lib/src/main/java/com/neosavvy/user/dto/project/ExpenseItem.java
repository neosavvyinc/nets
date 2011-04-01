package com.neosavvy.user.dto.project;

import com.neosavvy.security.SecuredObject;
import com.neosavvy.user.dto.base.BaseDTO;
import fineline.focal.common.types.v1.EntityListenerManager;
import fineline.focal.common.types.v1.FileRef;

import javax.persistence.*;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;
import java.math.BigDecimal;
import java.util.Date;
import java.util.Set;

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
@EntityListeners(EntityListenerManager.class)
@XmlRootElement(namespace = "urn:com:neosavvy:user:dto:mobile")
public class ExpenseItem extends BaseDTO implements SecuredObject<ExpenseItem> {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "expense_report_item_id_seq")
    @SequenceGenerator(name = "expense_report_item_id_seq", sequenceName = "expense_report_item_id_seq", allocationSize=1)
	@Column(name="ID")
	private Long id;

    /**
     * Depending on the type of expense there will be
     * different fields that should be saved
     * these are the common ones.
     */
    @Column(name = "EXPENSE_DATE")
    @Temporal(TemporalType.DATE)
    private Date expenseDate;

    @Column(name = "AMOUNT")
    private BigDecimal amount;

    @ManyToOne
    @JoinColumn(name = "PAYMENT_METHOD_FK")
    private PaymentMethod paymentMethod;

    @ManyToOne
    @JoinColumn(name = "PROJECT_TYPE_FK")
    private ProjectType projectType;

    @ManyToOne
    @JoinColumn(name = "EXPENSE_ITEM_TYPE_FK")
    private ExpenseItemType expenseItemType;

    @OneToMany(mappedBy="expenseItem", fetch=FetchType.EAGER, cascade=CascadeType.ALL, orphanRemoval=true)
    private Set<ExpenseItemValue> expenseItemValues;

    @ManyToOne
    @JoinColumn(name="EXPENSE_REPORT_FK", nullable=false, updatable=false)
    private ExpenseReport expenseReport;

    @Column(name = "COMMENT")
    private String comment;

    @ManyToOne
    @JoinColumn(name="RECEIPT_FILE_REF_FK", nullable=true)
    private FileRef receiptFileRef;

    @XmlElement(required = true)
    public BigDecimal getAmount() {
        return amount;
    }

    public void setAmount(BigDecimal amount) {
        this.amount = amount;
    }

    @XmlElement(required = true)
    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    @XmlElement(required = true)
    public Date getExpenseDate() {
        return expenseDate;
    }

    public void setExpenseDate(Date expenseDate) {
        this.expenseDate = expenseDate;
    }

    @XmlTransient
    public ExpenseItemType getExpenseItemType() {
        return expenseItemType;
    }

    public void setExpenseItemType(ExpenseItemType expenseItemType) {
        this.expenseItemType = expenseItemType;
    }

    @XmlTransient
    public Set<ExpenseItemValue> getExpenseItemValues() {
        return expenseItemValues;
    }

    public void setExpenseItemValues(Set<ExpenseItemValue> expenseItemValues) {
        this.expenseItemValues = expenseItemValues;
    }

    @XmlElement(required = true)
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    @XmlTransient
    public PaymentMethod getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(PaymentMethod paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    @XmlTransient
    public ProjectType getProjectType() {
        return projectType;
    }

    public void setProjectType(ProjectType projectType) {
        this.projectType = projectType;
    }

    @XmlTransient
    public ExpenseReport getExpenseReport() {
        return expenseReport;
    }

    public void setExpenseReport(ExpenseReport expenseReport) {
        this.expenseReport = expenseReport;
    }

    @XmlTransient
    public SecuredObject getAclParentObject() {
        return expenseReport;
    }

    @XmlTransient
    public FileRef getReceiptFileRef() {
        return receiptFileRef;
    }

    public void setReceiptFileRef(FileRef receiptFileRef) {
        this.receiptFileRef = receiptFileRef;
    }

    @XmlTransient
    public Class getAclParentClass() {
        return ExpenseReport.class;
    }

    @XmlTransient
    public Class<ExpenseItem> getAclClass() {
        return ExpenseItem.class;
    }

    @XmlTransient
    public String getOwnerUsername() {
        return null;
    }
}
