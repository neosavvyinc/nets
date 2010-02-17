package com.neosavvy.user.dto.project;
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
 * Date: Feb 14, 2010
 * Time: 11:04:30 AM
 */
public enum ExpenseReportStatus {
    //"Open","Submitted","Approving","Approved","Reimbursement Sent","Reimbursement Recieved"
    OPEN                        //Open - when an expense report is created it is in an open state
    ,SUBMITTED                  //Submitted - once a user submits it to the workflow it is submitted
    ,APPROVING                  //Approving - once the first approver has touched the expense report it is in this state
    ,APPROVED                   //Approved - once the last approver has agreed that the expense report is valid it is in this state
    ,REIMBURSEMENT_SENT         //Reimbursement Sent - once the accounting personal has sent a check it is in this state
    ,REIMBURSEMENT_RECEIVED     //Reimbursement Received - once the expense report user who created the expense has recieved reimbursement
}
