package com.neosavvy.user.dto.project;

import com.neosavvy.user.dto.companyManagement.CompanyDTO;
import com.neosavvy.user.dto.companyManagement.UserDTO;

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
public class Project {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "project_id_seq")
    @SequenceGenerator(name = "project_id_seq", sequenceName = "project_id_seq", allocationSize=1)
	@Column(name="ID")
	private Long id;
    /**
     * This is the owning company of the project - for whom the project should be billed from
     */
    @OneToOne
    @JoinColumn(name="PARENT_COMPANY_FK")
    private CompanyDTO company;

    /**
     * This is the client who will receive invoices for these expenses
     */
    @OneToOne
    @JoinColumn(name="CLIENT_COMPANY_FK")
    private ClientCompany client;

    /**
     * These are the people who enter expenses
     */
    @OneToMany
    @JoinColumn(name="PARTICIPANTS_FK")
    private List<UserDTO> participants;

    /**
     * These are the users who can approve expenses - this may need to change to be hierarchical
     */
    @OneToMany
    @JoinColumn(name="APPROVERS_FK")
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
    @OneToMany
    @JoinColumn(name="EXPENSE_REPORTS_FK")
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

    public List<UserDTO> getParticipants() {
        return participants;
    }

    public void setParticipants(List<UserDTO> participants) {
        this.participants = participants;
    }

    public List<UserDTO> getApprovers() {
        return approvers;
    }

    public void setApprovers(List<UserDTO> approvers) {
        this.approvers = approvers;
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
}
