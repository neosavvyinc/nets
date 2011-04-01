package com.neosavvy.user.dto.project;

import com.neosavvy.security.SecuredObject;
import com.neosavvy.user.dto.base.BaseDTO;
import com.neosavvy.user.dto.companyManagement.UserDTO;
import fineline.focal.common.types.v1.EntityListenerManager;
import flex.messaging.annotations.FlexClass;
import flex.messaging.annotations.IAnnotatedProxy;

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
 * Date: Mar 21, 2010
 * Time: 12:06:43 PM
 */
@Entity
@Table(
    name="EXPENSE_REPORT_AUDIT_HISTORY" ,
    uniqueConstraints = {
            @UniqueConstraint(columnNames = {"ID"})
    }
)
@EntityListeners(EntityListenerManager.class)
@FlexClass(classType = FlexClass.FlexClassType.RemoteObject)
public class ExpenseReportAuditHistory extends BaseDTO implements IAnnotatedProxy, SecuredObject<ExpenseReportAuditHistory> {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "expense_report_audit_hist_seq")
    @SequenceGenerator(name = "expense_report_audit_hist_seq", sequenceName = "expense_report_audit_hist_seq", allocationSize=1)
	@Column(name = "ID")
    private Long id;

    @Column(name = "COMMENT")
    private String comment;

    @Column(name = "ACTIVITY_DATE")
    @Temporal(TemporalType.DATE)
    private Date activityDate;

    @ManyToOne
    @JoinColumn(name = "USER_FK")
    private UserDTO user;

    @ManyToOne
    @JoinColumn(name = "OWNER_FK")
    private UserDTO owner;

    @ManyToOne
    @JoinColumn(name="EXPENSE_REPORT_FK", nullable=false, updatable=false)
    private ExpenseReport expenseReport;

    public Date getActivityDate() {
        return activityDate;
    }

    public void setActivityDate(Date activityDate) {
        this.activityDate = activityDate;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public UserDTO getUser() {
        return user;
    }

    public void setUser(UserDTO user) {
        this.user = user;
    }

    public Class<ExpenseReportAuditHistory> getAclClass() {
        return ExpenseReportAuditHistory.class;
    }

    public UserDTO getOwner() {
        return owner;
    }

    public void setOwner(UserDTO owner) {
        this.owner = owner;
    }

    @Override
    public Long getId() {
        return id;
    }

    public String getOwnerUsername() {
        if (getOwner() != null) {
            return getOwner().getUsername();
        }

        return null;
    }

    public SecuredObject getAclParentObject() {
        return expenseReport;
    }

    public Class getAclParentClass() {
        return ExpenseReportAuditHistory.class;
    }
}
