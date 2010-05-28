package com.neosavvy.user.dto.mobile;

import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;
import java.math.BigDecimal;
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
 * Date: May 11, 2010
 * Time: 3:32:56 PM
 */
@XmlRootElement(namespace = "urn:com:neosavvy:user:dto:mobile")
public class StatusDashboardData {

    private String expenseReportName;
    private String expenseReportLocation;
    private BigDecimal expenseReportTotal;

    private String projectName;
    private String projectApprover;

    private Date expenseReportStartDate;
    private Date expenseReportEndDate;
    private Date expenseReportLastActivityDate;
    private Long expenseReportId;

    @XmlElement(required = true)
    public Date getExpenseReportEndDate() {
        return expenseReportEndDate;
    }

    public void setExpenseReportEndDate(Date expenseReportEndDate) {
        this.expenseReportEndDate = expenseReportEndDate;
    }

    @XmlElement(required = true)
    public Date getExpenseReportLastActivityDate() {
        return expenseReportLastActivityDate;
    }

    public void setExpenseReportLastActivityDate(Date expenseReportLastActivityDate) {
        this.expenseReportLastActivityDate = expenseReportLastActivityDate;
    }

    @XmlElement(required = true)
    public String getExpenseReportLocation() {
        return expenseReportLocation;
    }

    public void setExpenseReportLocation(String expenseReportLocation) {
        this.expenseReportLocation = expenseReportLocation;
    }

    @XmlElement(required = true)
    public String getExpenseReportName() {
        return expenseReportName;
    }

    public void setExpenseReportName(String expenseReportName) {
        this.expenseReportName = expenseReportName;
    }

    @XmlElement(required = true)
    public Date getExpenseReportStartDate() {
        return expenseReportStartDate;
    }

    public void setExpenseReportStartDate(Date expenseReportStartDate) {
        this.expenseReportStartDate = expenseReportStartDate;
    }

    @XmlElement(required = true)
    public BigDecimal getExpenseReportTotal() {
        return expenseReportTotal;
    }

    public void setExpenseReportTotal(BigDecimal expenseReportTotal) {
        this.expenseReportTotal = expenseReportTotal;
    }

    @XmlElement(required = true)
    public String getProjectApprover() {
        return projectApprover;
    }

    public void setProjectApprover(String projectApprover) {
        this.projectApprover = projectApprover;
    }

    @XmlElement(required = true)
    public String getProjectName() {
        return projectName;
    }

    public void setProjectName(String projectName) {
        this.projectName = projectName;
    }

    public void setExpenseReportId(Long id) {
        this.expenseReportId = id;
    }

    @XmlElement(required = true)
    public Long getExpenseReportId() {
        return expenseReportId;
    }
}
