package com.neosavvy.user.dto.project;

import com.neosavvy.security.SecuredObject;
import com.neosavvy.user.dto.base.BaseDTO;
import com.neosavvy.user.dto.companyManagement.UserDTO;
import fineline.focal.common.types.v1.EntityListenerManager;

import javax.persistence.*;
import java.util.Date;
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
 * Date: Jan 2, 2010
 * Time: 11:15:56 AM
 */
@Entity
@Table(
    name="EXPENSE_REPORT" ,
    uniqueConstraints = {
            @UniqueConstraint(columnNames = {"ID"})
    }
)
@EntityListeners(EntityListenerManager.class)
public class ExpenseReport extends BaseDTO implements SecuredObject<ExpenseReport> {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "expense_report_id_seq")
    @SequenceGenerator(name = "expense_report_id_seq", sequenceName = "expense_report_id_seq", allocationSize=1)
	@Column(name = "ID")
	private Long id; 

    @ManyToOne
    @JoinColumn(name = "OWNER_FK")
    private UserDTO owner;

    @ManyToOne
    @JoinColumn(name = "PROJECT_FK")
    private Project project;

    @Column(name = "STATE_DATE")
    @Temporal(TemporalType.DATE)
    private Date startDate;

    @Column(name = "END_DATE")
    @Temporal(TemporalType.DATE)
    private Date endDate;

    @Column(name = "PURPOSE")
    private String purpose;

    @Column(name = "LOCATION")
    private String location;

    @OneToMany(mappedBy = "expenseReport")
    private List<ExpenseItem> expenseItems;

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

    public List<ExpenseItem> getExpenseItems() {
        return expenseItems;
    }

    public void setExpenseItems(List<ExpenseItem> expenseItems) {
        this.expenseItems = expenseItems;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public Project getProject() {
        return project;
    }

    public void setProject(Project project) {
        this.project = project;
    }

    public String getPurpose() {
        return purpose;
    }

    public void setPurpose(String purpose) {
        this.purpose = purpose;
    }

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public UserDTO getOwner() {
        return owner;
    }

    public void setOwner(UserDTO owner) {
        this.owner = owner;
    }

    public SecuredObject getAclParentObject() {
        return project;
    }

    public Class getAclParentClass() {
        return Project.class;
    }

    public Class<ExpenseReport> getAclClass() {
        return ExpenseReport.class;
    }
    
    public String getOwnerUsername() {
        if (getOwner() != null) {
            return getOwner().getUsername();
        }

        return null;
    }
}
