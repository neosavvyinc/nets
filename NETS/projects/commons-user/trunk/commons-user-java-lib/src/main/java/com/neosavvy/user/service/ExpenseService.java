package com.neosavvy.user.service;

import com.neosavvy.user.dto.companyManagement.UserDTO;
import com.neosavvy.user.dto.project.*;

import java.util.ArrayList;
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
 * Date: Feb 6, 2010
 * Time: 9:55:58 AM
 */
public interface ExpenseService {
    
    public Long saveExpenseReport(Project p, ExpenseReport report, List<ExpenseItem> expenseItems);

    public void deleteExpenseReport(ExpenseReport report);

    public ExpenseReport findExpenseReportById(Long id);

    public List<PaymentMethod> findPaymentMethods();

    public List<ExpenseItemType> findExpenseItemTypes();

    public List<ProjectType> findProjectTypes();

    public List<ExpenseReport> findOpenExpenseReportsForUser(UserDTO user);

    public List<ExpenseReport> findSubmittedReportsForUser(UserDTO user);

    public List<ExpenseReport> findReimbursedReportsForUser(UserDTO user);

}
