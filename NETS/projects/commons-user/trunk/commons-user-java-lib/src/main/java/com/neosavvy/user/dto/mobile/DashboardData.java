package com.neosavvy.user.dto.mobile;

import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;
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
 * Date: Apr 6, 2010
 * Time: 9:15:08 PM
 */
@XmlRootElement(namespace = "urn:com:neosavvy:user:dto:mobile")
public class DashboardData {

    private Integer numberExpenseReportsAwaitingApproval;

    private Integer numberExpenseReportsApproved;

    private Integer numberExpenseReportsDeclined;

    private Integer numberExpenseReportsOpened;

    private Integer numberExpenseReportsAwaitingReconciliation;

    private Integer numberExpenseReportsReconciled;

    @XmlElement(required = true)
    public Integer getNumberExpenseReportsApproved() {
        return numberExpenseReportsApproved;
    }

    public void setNumberExpenseReportsApproved(Integer numberExpenseReportsApproved) {
        this.numberExpenseReportsApproved = numberExpenseReportsApproved;
    }

    @XmlElement(required = true)
    public Integer getNumberExpenseReportsAwaitingApproval() {
        return numberExpenseReportsAwaitingApproval;
    }

    public void setNumberExpenseReportsAwaitingApproval(Integer numberExpenseReportsAwaitingApproval) {
        this.numberExpenseReportsAwaitingApproval = numberExpenseReportsAwaitingApproval;
    }

    @XmlElement(required = true)
    public Integer getNumberExpenseReportsAwaitingReconciliation() {
        return numberExpenseReportsAwaitingReconciliation;
    }

    public void setNumberExpenseReportsAwaitingReconciliation(Integer numberExpenseReportsAwaitingReconciliation) {
        this.numberExpenseReportsAwaitingReconciliation = numberExpenseReportsAwaitingReconciliation;
    }

    @XmlElement(required = true)
    public Integer getNumberExpenseReportsDeclined() {
        return numberExpenseReportsDeclined;
    }

    public void setNumberExpenseReportsDeclined(Integer numberExpenseReportsDeclined) {
        this.numberExpenseReportsDeclined = numberExpenseReportsDeclined;
    }

    @XmlElement(required = true)
    public Integer getNumberExpenseReportsOpened() {
        return numberExpenseReportsOpened;
    }

    public void setNumberExpenseReportsOpened(Integer numberExpenseReportsOpened) {
        this.numberExpenseReportsOpened = numberExpenseReportsOpened;
    }

    @XmlElement(required = true)
    public Integer getNumberExpenseReportsReconciled() {
        return numberExpenseReportsReconciled;
    }

    public void setNumberExpenseReportsReconciled(Integer numberExpenseReportsReconciled) {
        this.numberExpenseReportsReconciled = numberExpenseReportsReconciled;
    }
}
