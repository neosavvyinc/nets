package com.neosavvy.user.service;

import com.neosavvy.user.dao.project.ExpenseDAO;
import com.neosavvy.user.dto.companyManagement.UserDTO;
import com.neosavvy.user.dto.project.*;
import com.neosavvy.user.service.exception.ExpenseServiceException;
import org.springframework.transaction.annotation.Transactional;

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

@Transactional
public class ExpenseServiceImpl implements ExpenseService {
    private ExpenseDAO expenseDAO;

    public ExpenseReport saveExpenseReport(ExpenseReport report, List<ExpenseItem> expenseItems) throws ExpenseServiceException {
        if (report == null) {
            return null;
        }
        report.setExpenseItems(expenseItems);
        validateExpenseReport(report);
        return expenseDAO.save(report);
    }

    public void deleteExpenseReport(ExpenseReport report) {
        if (report != null) {
            expenseDAO.delete(report);
        }
    }

    public ExpenseReport findExpenseReportById(Long id) {
        if (id == null) {
            return null;
        }
        return expenseDAO.findExpenseReportById(id);
    }

    public List<ExpenseItem> getExpenseItems(long expenseReportId) {
        ExpenseReport report = expenseDAO.findExpenseReportById(expenseReportId);

        if (report == null) {
            return new ArrayList<ExpenseItem>();
        }

        return report.getExpenseItems();
    }

    public List<ExpenseReport> findExpenseReportsByStatus(UserDTO user, ExpenseReportStatus status) {
        if (user == null) {
            return new ArrayList<ExpenseReport>();
        }
        if (status == null) {
            return new ArrayList<ExpenseReport>();
        }

        ExpenseReport filter = new ExpenseReport();
        filter.setOwner(user);
        filter.setStatus(status);
        return expenseDAO.findExpenseReports(filter);
    }

    public List<ExpenseReport> findExpenseReportsByStatuses(UserDTO user, List<ExpenseReportStatus> statuses) {

        List<ExpenseReport> expenseReports = new ArrayList<ExpenseReport>();

        for (ExpenseReportStatus status : statuses) {
            expenseReports.addAll( findExpenseReportsByStatus(user, status) );
        }

        return expenseReports;

    }

    public List<PaymentMethod> findPaymentMethods() {
        List<PaymentMethod> methods = new ArrayList<PaymentMethod>();
        methods.addAll(expenseDAO.getStandardPaymentMethods());
        return methods;
    }

    public List<ExpenseItemType> findExpenseItemTypes() {
        List<ExpenseItemType> types = new ArrayList<ExpenseItemType>();
        types.addAll(expenseDAO.getStandardExpenseItemTypes());

        for (ExpenseItemType type : types) {
            if (type.getDescriptors() != null) {
                for (ExpenseItemDescriptor descriptor : type.getDescriptors()) {
                    if (descriptor != null) {
                        
                    }
                }
            }
        }
        return types;
    }

    protected ExpenseReport getAttachedExpenseReport( ExpenseReport aReport ) {
        ExpenseReport report = expenseDAO.findExpenseReportById(aReport.getId());
        List<ExpenseItem> expenseItems = expenseDAO.findExpenseItemsForReport(aReport.getId());
        report.setExpenseItems(expenseItems);
        return report;
    }

    public ExpenseReport submitExpenseReportForApproval(ExpenseReport report, String comment) {

        report = getAttachedExpenseReport(report);
        report.setStatus(ExpenseReportStatus.SUBMITTED);
        expenseDAO.save(report);

        return new ExpenseReport();
    }

    public ExpenseReport reopenExpenseReportForApproval(ExpenseReport report, String comment) {

        report = getAttachedExpenseReport(report);
        report.setStatus(ExpenseReportStatus.OPEN);
        expenseDAO.save(report);

        return new ExpenseReport();
    }

    public ExpenseReport approveExpenseReport(ExpenseReport report, String comment) {

        report = getAttachedExpenseReport(report);
        report.setStatus(ExpenseReportStatus.APPROVED);
        expenseDAO.save(report);

        return report;
    }

    public ExpenseReport declineExpenseReport(ExpenseReport report, String comment) {

        report = getAttachedExpenseReport(report);
        report.setStatus(ExpenseReportStatus.DECLINED);
        expenseDAO.save(report);

        return report;
    }

    private void validateExpenseReport(ExpenseReport report) throws ExpenseServiceException {
        if (report.getOwner() == null) {
            throw new ExpenseServiceException("Expense reports owner is required.");
        }
    }
    
    public List<ProjectType> findProjectTypes() {
        return expenseDAO.getProjectTypes();
    }

    public ExpenseDAO getExpenseDAO() {
        return expenseDAO;
    }

    public void setExpenseDAO(ExpenseDAO expenseDAO) {
        this.expenseDAO = expenseDAO;
    }

}
