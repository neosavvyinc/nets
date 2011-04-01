package com.neosavvy.user.dao.project;

import com.neosavvy.user.dto.companyManagement.CompanyDTO;
import com.neosavvy.user.dto.project.*;

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
public interface ExpenseDAO {
    List<? extends PaymentMethod> getStandardPaymentMethods();
    List<? extends PaymentMethod> getCompanyPaymentMethods(CompanyDTO company);
    List<? extends ExpenseItemType> getStandardExpenseItemTypes();
    List<? extends ExpenseItemType> getCompanyExpenseItemTypes(CompanyDTO company);
    List<ProjectType> getProjectTypes();

    ExpenseReport save(ExpenseReport report);
    void delete(ExpenseReport report);

    ExpenseItem save(ExpenseItem item);
    ExpenseItemValue save(ExpenseItemValue value);
    
    ExpenseReport findExpenseReportById(long id);
    List<ExpenseReport> findExpenseReports(ExpenseReport filter);
    List<ExpenseItem> findExpenseItemsForReport(long reportId);
}
