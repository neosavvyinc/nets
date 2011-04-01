package com.neosavvy.user.dto.project;

import com.neosavvy.security.SecuredObject;
import com.neosavvy.user.dto.base.BaseDTO;
import com.neosavvy.user.dto.companyManagement.CompanyDTO;
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
 * Time: 11:15:16 AM
 */
@Entity
@Table(
    name="PROJECT" ,
    uniqueConstraints = {
            @UniqueConstraint(columnNames = {"ID"})
    }
)
@EntityListeners(EntityListenerManager.class)
public class Project extends BaseDTO implements SecuredObject<Project> {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "project_id_seq")
    @SequenceGenerator(name = "project_id_seq", sequenceName = "project_id_seq", allocationSize=1)
	@Column(name="ID")
	private Long id;
    /**
     * This is the owning company of the project - for whom the project should be billed from
     */
    @ManyToOne
    @JoinColumn(name="PARENT_COMPANY_FK")
    private CompanyDTO company;

    /**
     * This is the client who will receive invoices for these expenses
     */
    @ManyToOne
    @JoinColumn(name="CLIENT_COMPANY_FK")
    private ClientCompany client;

    /**
     * These are the people who enter expenses
     */
    @ManyToMany
    @JoinTable(
        name="PROJECT_PARTICIPANTS",
        joinColumns=
            @JoinColumn(name="PROJECT_ID", referencedColumnName="ID"),
        inverseJoinColumns=
            @JoinColumn(name="USER_ID", referencedColumnName="ID")
    )
    private List<UserDTO> participants;

    /**
     * These are the users who can approve expenses - this may need to change to be hierarchical
     */
    @ManyToMany
    @JoinTable(
        name="PROJECT_APPROVERS",
        joinColumns=
            @JoinColumn(name="PROJECT_ID", referencedColumnName="ID"),
        inverseJoinColumns=
            @JoinColumn(name="USER_ID", referencedColumnName="ID")
    )
    private List<UserDTO> approvers;

    /**
     * Simple name of the project
     */
    @Column(name="PROJECT_NAME")
    private String name;

    /**
     * Simple short 3 letter code for the project
     */
    @Column(name="CODE")
    private String code;

    /**
     * Start date when expense can be billed
     */
    @Column(name="START_DATE")
    @Temporal(TemporalType.DATE)
    private Date startDate;

    /**
     * End date when no more expense can be billed
     */
    @Column(name="END_DATE" , nullable = true)
    @Temporal(TemporalType.DATE)
    private Date endDate;

    /**
     * A collection of all the expense reports
     */
    @OneToMany(mappedBy="project", cascade = CascadeType.ALL)
    private List<ExpenseReport> expenseReports;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public CompanyDTO getCompany() {
        return company;
    }

    public void setCompany(CompanyDTO company) {
        this.company = company;
    }

    public List<UserDTO> getApprovers() {
        return approvers;
    }

    public void setApprovers(List<UserDTO> approvers) {
        this.approvers = approvers;
    }

    public List<UserDTO> getParticipants() {
        return participants;
    }

    public void setParticipants(List<UserDTO> participants) {
        this.participants = participants;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

    public List<ExpenseReport> getExpenseReports() {
        return expenseReports;
    }

    public void setExpenseReports(List<ExpenseReport> expenseReports) {
        this.expenseReports = expenseReports;
    }

    public ClientCompany getClient() {
        return client;
    }

    public void setClient(ClientCompany client) {
        this.client = client;
    }

    public SecuredObject getAclParentObject() {
        return company;
    }

    public Class getAclParentClass() {
        return CompanyDTO.class;
    }

    public Class<Project> getAclClass() {
        return Project.class;
    }

    public String getOwnerUsername() {
        return getCompany().getOwnerUsername();
    }


}
