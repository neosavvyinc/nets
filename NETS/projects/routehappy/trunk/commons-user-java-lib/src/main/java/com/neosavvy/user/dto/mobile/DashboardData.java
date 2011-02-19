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

    //Open - when an expense report is created it is in an open state
    private Integer numberOpenExpenses;

    //Submitted - once a user submits it to the workflow it is submitted
    private Integer numberSubmittedExpenses;

    //Declined - once any approver has found a problem it will be set to this state
    private Integer numberDeclinedExpenses;

    //Approving - once the first approver has touched the expense report it is in this state
    private Integer numberApprovingExpenses;

    //Approved - once the last approver has agreed that the expense report is valid it is in this state
    private Integer numberApprovedExpenses;

    //Reimbursement Sent - once the accounting personal has sent a check it is in this state
    private Integer numberReimbursmentSentExpenses;

    //REIMBURSEMENT_RECEIVED
    private Integer numberReimbursedmentReceivedExpenses;

    @XmlElement(required = true)
    public Integer getNumberApprovedExpenses() {
        return numberApprovedExpenses;
    }

    public void setNumberApprovedExpenses(Integer numberApprovedExpenses) {
        this.numberApprovedExpenses = numberApprovedExpenses;
    }

    @XmlElement(required = true)
    public Integer getNumberApprovingExpenses() {
        return numberApprovingExpenses;
    }

    public void setNumberApprovingExpenses(Integer numberApprovingExpenses) {
        this.numberApprovingExpenses = numberApprovingExpenses;
    }

    @XmlElement(required = true)
    public Integer getNumberDeclinedExpenses() {
        return numberDeclinedExpenses;
    }

    public void setNumberDeclinedExpenses(Integer numberDeclinedExpenses) {
        this.numberDeclinedExpenses = numberDeclinedExpenses;
    }

    @XmlElement(required = true)
    public Integer getNumberOpenExpenses() {
        return numberOpenExpenses;
    }

    public void setNumberOpenExpenses(Integer numberOpenExpenses) {
        this.numberOpenExpenses = numberOpenExpenses;
    }

    @XmlElement(required = true)
    public Integer getNumberReimbursedmentReceivedExpenses() {
        return numberReimbursedmentReceivedExpenses;
    }

    public void setNumberReimbursedmentReceivedExpenses(Integer numberReimbursedmentReceivedExpenses) {
        this.numberReimbursedmentReceivedExpenses = numberReimbursedmentReceivedExpenses;
    }

    @XmlElement(required = true)
    public Integer getNumberReimbursmentSentExpenses() {
        return numberReimbursmentSentExpenses;
    }

    public void setNumberReimbursmentSentExpenses(Integer numberReimbursmentSentExpenses) {
        this.numberReimbursmentSentExpenses = numberReimbursmentSentExpenses;
    }

    @XmlElement(required = true)
    public Integer getNumberSubmittedExpenses() {
        return numberSubmittedExpenses;
    }

    public void setNumberSubmittedExpenses(Integer numberSubmittedExpenses) {
        this.numberSubmittedExpenses = numberSubmittedExpenses;
    }

    @Override
    public String toString() {
        return "DashboardData{" +
                "numberApprovedExpenses=" + numberApprovedExpenses +
                ", numberOpenExpenses=" + numberOpenExpenses +
                ", numberSubmittedExpenses=" + numberSubmittedExpenses +
                ", numberDeclinedExpenses=" + numberDeclinedExpenses +
                ", numberApprovingExpenses=" + numberApprovingExpenses +
                ", numberReimbursmentSentExpenses=" + numberReimbursmentSentExpenses +
                ", numberReimbursedmentReceivedExpenses=" + numberReimbursedmentReceivedExpenses +
                '}';
    }
}
