package com.neosavvy.user.service;

import com.neosavvy.user.dto.companyManagement.UserDTO;
import com.neosavvy.user.dto.project.*;
import com.neosavvy.user.util.EnumProxy;
import flex.messaging.io.PropertyProxyRegistry;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.*;
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
 * Time: 9:57:38 AM
 */
public class MockExpenseServiceImpl implements ExpenseService {

    private static final Logger logger = LoggerFactory.getLogger(MockExpenseServiceImpl.class);

    private HashMap<Long,ExpenseReport> expenseReports = new HashMap<Long,ExpenseReport>();

    private Long idSequence = 0L;

    private static List<ExpenseItemType> expenseItemTypes = new ArrayList<ExpenseItemType>();
    static {
        expenseItemTypes.add(new StandardExpenseItemType("Advance", "Cash Advances made by the employee for cash related purchases"));
        expenseItemTypes.add(new StandardExpenseItemType("Air & Rail", "Air and Rail travel expenses"));
        expenseItemTypes.add(new StandardExpenseItemType("Air & Rail Unused", "Unused airline and railline travel"));
        expenseItemTypes.add(new StandardExpenseItemType("Auto Parking","Parking related expenses for garage, street, or valet parking"));
        expenseItemTypes.add(new StandardExpenseItemType("Auto Rental","Car rentals for business travel"));
        expenseItemTypes.add(new StandardExpenseItemType("Auto tolls","Toll fees"));
        expenseItemTypes.add(new StandardExpenseItemType("Cell Phone","Personal Cell phone expenses for business use"));
        expenseItemTypes.add(new StandardExpenseItemType("Computer Supplies",""));
        expenseItemTypes.add(new StandardExpenseItemType("Entertainment",""));
        expenseItemTypes.add(new StandardExpenseItemType("Home Office",""));
        expenseItemTypes.add(new StandardExpenseItemType("Incidentals",""));
        expenseItemTypes.add(new StandardExpenseItemType("Local Transportation",""));
        expenseItemTypes.add(new StandardExpenseItemType("Lodging",""));
        expenseItemTypes.add(new StandardExpenseItemType("Lodging Apartments",""));
        expenseItemTypes.add(new StandardExpenseItemType("Lodging Per Diem",""));
        expenseItemTypes.add(new StandardExpenseItemType("Meals (Actual)",""));
        expenseItemTypes.add(new StandardExpenseItemType("Meals (Per Diem)",""));
        expenseItemTypes.add(new StandardExpenseItemType("Mileage",""));
        expenseItemTypes.add(new StandardExpenseItemType("Office Supplies",""));
        expenseItemTypes.add(new StandardExpenseItemType("Paid on behalf of others",""));
        expenseItemTypes.add(new StandardExpenseItemType("Breakfast",""));
        expenseItemTypes.add(new StandardExpenseItemType("Lunch (Per Diem)",""));
        expenseItemTypes.add(new StandardExpenseItemType("Dinner (Per Diem)",""));
        expenseItemTypes.add(new StandardExpenseItemType("Postage Delivery",""));
        expenseItemTypes.add(new StandardExpenseItemType("Printing Copying",""));
        expenseItemTypes.add(new StandardExpenseItemType("Marketing",""));
        expenseItemTypes.add(new StandardExpenseItemType("Teleconference",""));
        expenseItemTypes.add(new StandardExpenseItemType("Telephone",""));
        expenseItemTypes.add(new StandardExpenseItemType("Education",""));
        expenseItemTypes.add(new StandardExpenseItemType("Miscellaneous",""));
    }

    private static List<ProjectType> projectTypes = new ArrayList();
    static {
        projectTypes.add(new ProjectType("Administrative"));
        projectTypes.add(new ProjectType("Non-Billable"));
        projectTypes.add(new ProjectType("Billable"));
    }

    private static List<PaymentMethod> paymentMethods = new ArrayList<PaymentMethod>();
    static {
        paymentMethods.add(new StandardPaymentMethod(1L,"Employee Paid","Expense to be reimbursed to employee"));
        paymentMethods.add(new StandardPaymentMethod(2L,"Company Paid","Expense will not be reimbursed to employee"));
        paymentMethods.add(new StandardPaymentMethod(3L,"Corp Card","Expense was on the corporate card and will not be reimbursed"));
    }

    public ExpenseReport saveExpenseReport(ExpenseReport report, List<ExpenseItem> expenseItems) {

        Project p = report.getProject();
        
        logger.debug("Project info===========");
        logger.debug(p.getName());
        logger.debug(p.getCode());
        logger.debug(p.getOwnerUsername());
        logger.debug("Report info===========");
        logger.debug(report.getLocation());
        logger.debug(report.getOwnerUsername());
        logger.debug(report.getPurpose());

        if ( report.getId() == null){
            report.setId(++idSequence);
        }
        
        report.setExpenseItems(expenseItems);

        if ( expenseReports.containsKey( report.getId() ) ) {
            expenseReports.remove(report.getId());
        }

        return report;
    }

    public void deleteExpenseReport(ExpenseReport report) {

        expenseReports.remove(report.getId());

    }

    public ExpenseReport findExpenseReportById(Long id) {
        return expenseReports.get(id);
    }

    public List<ExpenseReport> findOpenExpenseReportsForUser(UserDTO user) {
        return findExpenseReportForUserAndStatus(user, ExpenseReportStatus.OPEN);
    }

    public List<ExpenseReport> findSubmittedReportsForUser(UserDTO user) {
        return findExpenseReportForUserAndStatus(user, ExpenseReportStatus.SUBMITTED);
    }

    public List<ExpenseReport> findReimbursedReportsForUser(UserDTO user) {
        return findExpenseReportForUserAndStatus(user, ExpenseReportStatus.REIMBURSEMENT_SENT);
    }

    private List<ExpenseReport> findExpenseReportForUserAndStatus(UserDTO user, ExpenseReportStatus status) {
        ArrayList<ExpenseReport> arrayList = new ArrayList<ExpenseReport>();
        Set<Map.Entry<Long,ExpenseReport>> entries = expenseReports.entrySet();
        for (Map.Entry<Long, ExpenseReport> entry : entries) {
            if ( entry.getValue().getStatus() == status ) {
                arrayList.add(entry.getValue());
            }
        }
        return arrayList;
    }

    public List<ExpenseItemType> findExpenseItemTypes() {
        return MockExpenseServiceImpl.expenseItemTypes;
    }

    public List<PaymentMethod> findPaymentMethods() {
        return MockExpenseServiceImpl.paymentMethods;
    }

    public List<ProjectType> findProjectTypes() {
        return MockExpenseServiceImpl.projectTypes;
    }

    public List<ExpenseItem> getExpenseItems(long expenseReportId) {
        return findExpenseReportById(expenseReportId).getExpenseItems();
    }
}
