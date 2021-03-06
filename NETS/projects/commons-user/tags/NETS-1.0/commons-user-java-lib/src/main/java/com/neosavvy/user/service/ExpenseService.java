package com.neosavvy.user.service;

import com.neosavvy.user.dto.companyManagement.UserDTO;
import com.neosavvy.user.dto.project.*;
import com.neosavvy.user.service.exception.ExpenseServiceException;
import fineline.focal.common.types.v1.StorageServiceFileRef;
import org.eclipse.persistence.annotations.Cache;
import org.springframework.security.access.annotation.Secured;

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

    @Secured({"ROLE_EMPLOYEE", "ACL_OBJECT_WRITE", "AFTER_ACL_READ"})
    public ExpenseReport saveReceiptToExpenseReport( ExpenseReport report, StorageServiceFileRef fileRef ) throws ExpenseServiceException;
    
    @Secured({"ROLE_EMPLOYEE", "ACL_OBJECT_WRITE", "AFTER_ACL_READ"})
    public ExpenseReport saveExpenseReport(ExpenseReport report, List<ExpenseItem> expenseItems) throws ExpenseServiceException;

    @Secured({"ROLE_EMPLOYEE", "ACL_OBJECT_WRITE"})
    public void deleteExpenseReport(ExpenseReport report);

    @Secured({"ROLE_EMPLOYEE", "AFTER_ACL_READ"})
    public ExpenseReport findExpenseReportById(Long id);

    @Secured({"ROLE_EMPLOYEE", "AFTER_ACL_COLLECTION_READ"})
    public List<ExpenseItem> getExpenseItems(long expenseReportId);

    @Secured({"ROLE_EMPLOYEE"})
    public List<PaymentMethod> findPaymentMethods();

    @Secured({"ROLE_EMPLOYEE"})
    public List<ExpenseItemType> findExpenseItemTypes();

    @Secured({"ROLE_EMPLOYEE"})
    public List<ProjectType> findProjectTypes();

    @Secured({"ROLE_EMPLOYEE", "AFTER_ACL_COLLECTION_READ"})
    public List<ExpenseReport> findExpenseReportsByStatus(UserDTO user, ExpenseReportStatus status);

    @Secured({"ROLE_EMPLOYEE", "AFTER_ACL_COLLECTION_READ"})
    public List<ExpenseReport> findExpenseReportsByStatuses(UserDTO user, List<ExpenseReportStatus> statuses);

    @Secured({"ROLE_EMPLOYEE", "ACL_OBJECT_WRITE"})
    public ExpenseReport submitExpenseReportForApproval(ExpenseReport report, String comment);

    @Secured({"ROLE_EMPLOYEE", "ACL_OBJECT_WRITE"})
    public ExpenseReport reopenExpenseReportForApproval(ExpenseReport report, String comment);

    @Secured({"ROLE_ADMIN", "ACL_OBJECT_WRITE"})
    public ExpenseReport approveExpenseReport(ExpenseReport report, String comment);

    @Secured({"ROLE_ADMIN", "ACL_OBJECT_WRITE"})
    public ExpenseReport declineExpenseReport(ExpenseReport report, String comment);
}
