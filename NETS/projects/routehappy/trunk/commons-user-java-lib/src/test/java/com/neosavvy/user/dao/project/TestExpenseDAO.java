package com.neosavvy.user.dao.project;

import com.neosavvy.user.dto.base.AttributeType;
import com.neosavvy.user.dto.companyManagement.CompanyDTO;
import com.neosavvy.user.dto.companyManagement.UserDTO;
import com.neosavvy.user.dto.project.*;
import com.neosavvy.user.util.ProjectTestUtil;
import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.annotation.Rollback;

import javax.persistence.Query;
import java.math.BigDecimal;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

public class TestExpenseDAO extends BaseProjectManagementDAOTest {
    @Autowired
    private ExpenseDAO expenseDAO;

    private ExpenseItemType testExpenseItemType;
    private PaymentMethod testPaymentMethod;
    private ProjectType testProjectType;
    private Project testProject;
    private UserDTO testUser;
    private ExpenseReport testReport;
    private ExpenseItemDescriptor testStringItemDescriptor;
    private ExpenseItemDescriptor testBooleanItemDescriptor;

    @Before
    public void setupExpense() {
        CompanyDTO testCompany = ProjectTestUtil.createTestCompany();
        ClientCompany testClientCompany = ProjectTestUtil.createTestClientCompany();
        ClientUserContact testClientContact = ProjectTestUtil.createTestClientContact();

        companyDAO.saveCompany(testCompany);
        clientUserContactDAO.saveUser(testClientContact);
        testClientCompany.setClientContact(testClientContact);
        testClientCompany.setParentCompany(testCompany);
        clientCompanyDAO.saveCompany(testClientCompany);

        testUser = ProjectTestUtil.createEmployee1User();
        userDAO.saveUser(testUser);

        testProject = ProjectTestUtil.createTestProject1(testCompany, testClientCompany);
        projectDAO.save(testProject);

        testExpenseItemType = expenseDAO.getStandardExpenseItemTypes().get(0);
        testPaymentMethod = expenseDAO.getStandardPaymentMethods().get(0);
        testProjectType = expenseDAO.getProjectTypes().get(0);

        testStringItemDescriptor = new ExpenseItemDescriptor();
        testStringItemDescriptor.setExpenseItemType(testExpenseItemType);
        testStringItemDescriptor.setDescription("Test Descriptor");
        testStringItemDescriptor.setName("String Test");
        testStringItemDescriptor.setValueType(AttributeType.STRING);
        entityManager.persist(testStringItemDescriptor);

        testBooleanItemDescriptor = new ExpenseItemDescriptor();
        testBooleanItemDescriptor.setExpenseItemType(testExpenseItemType);
        testBooleanItemDescriptor.setDescription("Test Descriptor");
        testBooleanItemDescriptor.setName("Boolean Test");
        testBooleanItemDescriptor.setValueType(AttributeType.BOOLEAN);
        entityManager.persist(testBooleanItemDescriptor);
        entityManager.flush();
    }

    @Test
    public void createNewExpenseReport() {
        ExpenseReport report = ProjectTestUtil.createTextExpenseReport1(testUser, testProject);
        ExpenseItem item1 = ProjectTestUtil.createTextExpenseItem1(10.50, testExpenseItemType, testPaymentMethod, testProjectType);

        ExpenseItemValue value1 = new ExpenseItemValue();
        value1.setDescriptor(testStringItemDescriptor);
        value1.setExpenseItem(item1);
        value1.setStringValue("value1");
        value1.setPartitionDate(new Date());
        item1.getExpenseItemValues().add(value1);

        ExpenseItemValue value2 = new ExpenseItemValue();
        value2.setDescriptor(testBooleanItemDescriptor);
        value2.setExpenseItem(item1);
        value2.setStringValue("true");
        value2.setPartitionDate(new Date());
        item1.getExpenseItemValues().add(value2);

        ExpenseItem item2 = ProjectTestUtil.createTextExpenseItem1(1.50, testExpenseItemType, testPaymentMethod, testProjectType);
        ExpenseItemValue item2Value1 = new ExpenseItemValue();
        item2Value1.setDescriptor(testStringItemDescriptor);
        item2Value1.setExpenseItem(item2);
        item2Value1.setStringValue("value1");
        item2Value1.setPartitionDate(new Date());
        item2.getExpenseItemValues().add(item2Value1);

        ExpenseItemValue item2Value2 = new ExpenseItemValue();
        item2Value2.setDescriptor(testBooleanItemDescriptor);
        item2Value2.setExpenseItem(item2);
        item2Value2.setStringValue("true");
        item2Value2.setPartitionDate(new Date());
        item2.getExpenseItemValues().add(item2Value2);

        report.getExpenseItems().add(item1);
        report.getExpenseItems().add(item2);
        
        testReport = expenseDAO.save(report);
        Assert.assertNotNull("Saved entity should have an id", testReport.getId());
        Assert.assertEquals("Should be 1 expense report", 1, entityManager.createQuery("SELECT r FROM ExpenseReport r").getResultList().size());
        Assert.assertEquals("Should be 2 expense items", 2, entityManager.createQuery("SELECT i FROM ExpenseItem i").getResultList().size());
        Assert.assertEquals("Should be 4 expense item values", 4, entityManager.createQuery("SELECT v FROM ExpenseItemValue v").getResultList().size());

        Query query = entityManager.createQuery("SELECT sum(i.amount) FROM ExpenseItem i WHERE i.expenseReport = :report");
        query.setParameter("report", testReport);
        Assert.assertEquals("Expense items sum should be $12", BigDecimal.valueOf(12).setScale(2, BigDecimal.ROUND_HALF_UP),
                ((BigDecimal)query.getSingleResult()).setScale(2, BigDecimal.ROUND_HALF_UP));
    }

    @Test
    public void updateExpenseReport() {
        createNewExpenseReport();
        testReport.setEndDate(new Date());
        expenseDAO.save(testReport);
        ExpenseReport report = expenseDAO.findExpenseReportById(testReport.getId());
        Assert.assertEquals("Should be 1 expense report", 1, entityManager.createQuery("SELECT r FROM ExpenseReport r").getResultList().size());
        Assert.assertEquals("Should be 2 expense items", 2, entityManager.createQuery("SELECT i FROM ExpenseItem i").getResultList().size());
        Assert.assertNotNull("Updated end date should not be null", report.getEndDate());
    }

    @Test
    public void addExpenseItem() {
        createNewExpenseReport();
        ExpenseItem item1 = ProjectTestUtil.createTextExpenseItem1(20.55, testExpenseItemType, testPaymentMethod, testProjectType);

        ExpenseItemValue value1 = new ExpenseItemValue();
        value1.setDescriptor(testStringItemDescriptor);
        value1.setExpenseItem(item1);
        value1.setStringValue("value1");
        value1.setPartitionDate(new Date());
        item1.getExpenseItemValues().add(value1);
        testReport.getExpenseItems().add(item1);

        expenseDAO.save(testReport);

        Query query = entityManager.createQuery("SELECT sum(i.amount) FROM ExpenseItem i WHERE i.expenseReport = :report");
        query.setParameter("report", testReport);
        Assert.assertEquals("Should be 3 expense items", 3, entityManager.createQuery("SELECT i FROM ExpenseItem i").getResultList().size());
        Assert.assertEquals("Expense items sum should be $32.55", BigDecimal.valueOf(32.55).setScale(2, BigDecimal.ROUND_HALF_UP),
                ((BigDecimal)query.getSingleResult()).setScale(2, BigDecimal.ROUND_HALF_UP));
    }

    @Test
    public void removeExpenseItem() {
        createNewExpenseReport();
        testReport.getExpenseItems().remove(0);
        expenseDAO.save(testReport);
        Assert.assertEquals("Should be 1 expense items", 1, entityManager.createQuery("SELECT i FROM ExpenseItem i").getResultList().size());
    }

    @Test
    public void addAndRemoveExpenseItem() {
        createNewExpenseReport();
        testReport.getExpenseItems().remove(0);
        ExpenseItem item1 = ProjectTestUtil.createTextExpenseItem1(49, testExpenseItemType, testPaymentMethod, testProjectType);
        testReport.getExpenseItems().add(item1);
        expenseDAO.save(testReport);

        Query query = entityManager.createQuery("SELECT sum(i.amount) FROM ExpenseItem i WHERE i.expenseReport = :report");
        query.setParameter("report", testReport);
        Assert.assertEquals("Should be 2 expense items", 2, entityManager.createQuery("SELECT i FROM ExpenseItem i").getResultList().size());
        Assert.assertTrue("Expense items sum should exceed $50", BigDecimal.valueOf(50).compareTo(((BigDecimal)query.getSingleResult())) == -1);
    }

    @Test
    public void updateExpenseItemValue() {
        createNewExpenseReport();
        Assert.assertEquals("Should be 2 boolean expense item values", 2, entityManager.createQuery("SELECT v FROM ExpenseItemValue v WHERE v.descriptor.valueType = com.neosavvy.user.dto.base.AttributeType.BOOLEAN AND v.stringValue = \"true\"").getResultList().size());

        for (ExpenseItem item : testReport.getExpenseItems()) {
            for (ExpenseItemValue value : item.getExpenseItemValues()) {
                if (value.getDescriptor().getValueType() == AttributeType.BOOLEAN) {
                    value.setStringValue("false");
                }
            }
        }

        expenseDAO.save(testReport);
        
        Assert.assertEquals("Should be 4 expense item values", 4, entityManager.createQuery("SELECT v FROM ExpenseItemValue v").getResultList().size());
        Assert.assertEquals("Should be 0 boolean true expense item values", 0, entityManager.createQuery("SELECT v FROM ExpenseItemValue v WHERE v.descriptor.valueType = com.neosavvy.user.dto.base.AttributeType.BOOLEAN AND v.stringValue = \"true\"").getResultList().size());
        Assert.assertEquals("Should be 2 boolean true expense item values", 2, entityManager.createQuery("SELECT v FROM ExpenseItemValue v WHERE v.descriptor.valueType = com.neosavvy.user.dto.base.AttributeType.BOOLEAN AND v.stringValue = \"false\"").getResultList().size());
    }

    @Test
    public void removeExpenseItemValue() {
        createNewExpenseReport();
        List<ExpenseItem> items = expenseDAO.findExpenseItemsForReport(testReport.getId());
        Assert.assertEquals("Should be 4 expense item values", 4, entityManager.createQuery("SELECT v FROM ExpenseItemValue v").getResultList().size());
        ExpenseItem item = items.get(0);

        // we have to actually refresh the item so that its value hashset is reloaded
        // because the value items changed hash codes since they have ids after persist
        entityManager.refresh(item);
        ExpenseItemValue value = item.getExpenseItemValues().iterator().next();
        Set<ExpenseItemValue> values = item.getExpenseItemValues();
        values.remove(value);

        testReport.setExpenseItems(items);
        expenseDAO.save(testReport);

        Assert.assertEquals("Should be 2 expense items", 2, entityManager.createQuery("SELECT i FROM ExpenseItem i").getResultList().size());
        Assert.assertEquals("Should be 3 expense item values", 3, entityManager.createQuery("SELECT v FROM ExpenseItemValue v").getResultList().size());
    }

    @Test
    public void addExpenseItemValue() {
        createNewExpenseReport();
        List<ExpenseItem> items = expenseDAO.findExpenseItemsForReport(testReport.getId());
        Assert.assertEquals("Should be 4 expense item values", 4, entityManager.createQuery("SELECT v FROM ExpenseItemValue v").getResultList().size());
        ExpenseItem item = items.get(0);

        // we have to actually refresh the item so that its value hashset is reloaded
        // because the value items changed hash codes since they have ids after persist
        entityManager.refresh(item);

        ExpenseItemValue value1 = new ExpenseItemValue();
        value1.setDescriptor(testStringItemDescriptor);
        value1.setExpenseItem(item);
        value1.setStringValue("new value");
        value1.setPartitionDate(new Date());
        item.getExpenseItemValues().add(value1);
        
        testReport.setExpenseItems(items);
        expenseDAO.save(testReport);

        Assert.assertEquals("Should be 2 expense items", 2, entityManager.createQuery("SELECT i FROM ExpenseItem i").getResultList().size());
        Assert.assertEquals("Should be 5 expense item values", 5, entityManager.createQuery("SELECT v FROM ExpenseItemValue v").getResultList().size());

    }

    @Test
    public void addAndRemoveExpenseItemValue() {
        createNewExpenseReport();
        List<ExpenseItem> items = expenseDAO.findExpenseItemsForReport(testReport.getId());
        Assert.assertEquals("Should be 4 expense item values", 4, entityManager.createQuery("SELECT v FROM ExpenseItemValue v").getResultList().size());
        ExpenseItem item = items.get(0);

        // we have to actually refresh the item so that its value hashset is reloaded
        // because the value items changed hash codes since they have ids after persist
        entityManager.refresh(item);
        ExpenseItemValue value = item.getExpenseItemValues().iterator().next();
        Set<ExpenseItemValue> values = item.getExpenseItemValues();
        values.remove(value);

        ExpenseItemValue value1 = new ExpenseItemValue();
        value1.setDescriptor(testStringItemDescriptor);
        value1.setExpenseItem(item);
        value1.setStringValue("new value");
        value1.setPartitionDate(new Date());
        item.getExpenseItemValues().add(value1);

        testReport.setExpenseItems(items);
        expenseDAO.save(testReport);

        Assert.assertEquals("Should be 2 expense items", 2, entityManager.createQuery("SELECT i FROM ExpenseItem i").getResultList().size());
        Assert.assertEquals("Should be 4 expense item values", 4, entityManager.createQuery("SELECT v FROM ExpenseItemValue v").getResultList().size());
        Assert.assertNotNull("New expense item value exists", entityManager.createQuery("SELECT v FROM ExpenseItemValue v WHERE v.stringValue = \"new value\"").getSingleResult());
    }

    @Test
    public void findExpenseItems() {
        createNewExpenseReport();
        Assert.assertEquals("Should be 2 expense items for report", 2, expenseDAO.findExpenseItemsForReport(testReport.getId()).size());
    }

    @Test
    public void findExpenseReportById() {
        createNewExpenseReport();
        Assert.assertNotNull("New report should exist", expenseDAO.findExpenseReportById(testReport.getId()));
    }

    @Test
    public void deleteReport() {
        createNewExpenseReport();
        expenseDAO.delete(testReport);
        Assert.assertEquals("Should be 0 expense reports", 0, entityManager.createQuery("SELECT r FROM ExpenseReport r").getResultList().size());
        Assert.assertEquals("Should be 0 expense items", 0, entityManager.createQuery("SELECT i FROM ExpenseItem i").getResultList().size());
        Assert.assertEquals("Should be 0 expense item values", 0, entityManager.createQuery("SELECT v FROM ExpenseItemValue v").getResultList().size());
    }

    @Test
    public void findExpenseReportSearchCriteria() {
        createNewExpenseReport();

        ExpenseReport filter = new ExpenseReport();
        filter.setStartDate(testReport.getStartDate());
        Assert.assertEquals("Start date query should return results", 1, expenseDAO.findExpenseReports(filter).size());

        filter = new ExpenseReport();
        filter.setEndDate(testReport.getEndDate());
        Assert.assertEquals("End date query should return results", 1, expenseDAO.findExpenseReports(filter).size());

        filter = new ExpenseReport();
        filter.setPurpose(testReport.getPurpose());
        Assert.assertEquals("Purpose query should return results", 1, expenseDAO.findExpenseReports(filter).size());

        filter = new ExpenseReport();
        filter.setOwner(testReport.getOwner());
        Assert.assertEquals("Owner query should return results", 1, expenseDAO.findExpenseReports(filter).size());

        filter = new ExpenseReport();
        filter.setLocation(testReport.getLocation());
        Assert.assertEquals("Location query should return results", 1, expenseDAO.findExpenseReports(filter).size());

        filter = new ExpenseReport();
        filter.setProject(testReport.getProject());
        Assert.assertEquals("Project query should return results", 1, expenseDAO.findExpenseReports(filter).size());

        filter = new ExpenseReport();
        filter.setStartDate(testReport.getStartDate());
        filter.setEndDate(testReport.getEndDate());
        Assert.assertEquals("Start & End date query should return results", 1, expenseDAO.findExpenseReports(filter).size());

        filter = new ExpenseReport();
        filter.setOwner(testReport.getOwner());
        filter.setLocation(testReport.getLocation());
        Assert.assertEquals("Owner & Location date query should return results", 1, expenseDAO.findExpenseReports(filter).size());

        filter = new ExpenseReport();
        filter.setStartDate(testReport.getStartDate());
        filter.setEndDate(testReport.getEndDate());
        filter.setOwner(testReport.getOwner());
        filter.setLocation(testReport.getLocation());
        Assert.assertEquals("Start & End date & Owner & Location date query should return results", 1, expenseDAO.findExpenseReports(filter).size());

        filter = new ExpenseReport();
        filter.setLocation("Invalid");
        Assert.assertEquals("Invalid Location date query should return no results", 0, expenseDAO.findExpenseReports(filter).size());
    }
}
