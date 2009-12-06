package com.neosavvy.user.dao;

import org.junit.Test;
import org.junit.Assert;
import org.hibernate.exception.ConstraintViolationException;
import com.neosavvy.user.dto.NumEmployeesRangeDTO;

import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: lgleason
 * Date: Dec 5, 2009
 * Time: 1:26:25 PM
 * To change this template use File | Settings | File Templates.
 */
public class TestNumEmployeesRangeDAO extends BaseSpringAwareDAOTestCase{

    private void cleanDatabase() {
        deleteFromTables("COMPANY");
        deleteFromTables("NUM_EMPLOYEES_RANGE");
    }

    private NumEmployeesRangeDTO createAltTestRange(){
        NumEmployeesRangeDTO test_range = new NumEmployeesRangeDTO();
        test_range.setRangeDescription("11-50");
        test_range.setRangeFrom(11);
        test_range.setRangeTo(50);
        return test_range;
    }


    @Test
    public void testSaveRange() {
        cleanDatabase();
        NumEmployeesRangeDTO range = createTestRange();
        numEmployeesRangeDAO.saveRange(range);
        Assert.assertTrue((int)range.getId() > 0);
    }

    @Test
    public void testDeleteRange() {
        cleanDatabase();
        int numRows = countRowsInTable("NUM_EMPLOYEES_RANGE");
        Assert.assertEquals(numRows, 0);

        NumEmployeesRangeDTO range = createTestRange();
        numEmployeesRangeDAO.saveRange(range);

        numRows = countRowsInTable("NUM_EMPLOYEES_RANGE");
        Assert.assertEquals(numRows, 1);

        numEmployeesRangeDAO.deleteRange(range);

        numRows = countRowsInTable("NUM_EMPLOYEES_RANGE");
        Assert.assertEquals(0,numRows);
    }

    @Test
    public void testFindRangeById() {
        cleanDatabase();
        NumEmployeesRangeDTO range = createTestRange();
        numEmployeesRangeDAO.saveRange(range);

        int numRows = countRowsInTable("NUM_EMPLOYEES_RANGE");

        Assert.assertEquals("Num of rows is not equal to 1", 1, numRows);

        NumEmployeesRangeDTO rangeFound = numEmployeesRangeDAO.findRangeById(range.getId());

        Assert.assertNotNull("User object was not found by id " + range.getId(), rangeFound);
    }

    @Test
    public void testFindRanges() {
        cleanDatabase();
        NumEmployeesRangeDTO range = createTestRange();
        numEmployeesRangeDAO.saveRange(range);

        int numRows = countRowsInTable("NUM_EMPLOYEES_RANGE");

        Assert.assertEquals("Num of rows is equal to 1", 1, numRows);

        List<NumEmployeesRangeDTO> rangesFound = numEmployeesRangeDAO.getRanges();

        Assert.assertEquals("One range was found ",  numRows, rangesFound.size());
    }

    private void setupCriteriaBasedSearchTest() {
        cleanDatabase();
        NumEmployeesRangeDTO range = createTestRange();
        NumEmployeesRangeDTO range2 = createAltTestRange();

        numEmployeesRangeDAO.saveRange(range);
        numEmployeesRangeDAO.saveRange(range2);

        int numRows = countRowsInTable("NUM_EMPLOYEES_RANGE");
        Assert.assertEquals("Num of rows is equal to 2", 2, numRows);
    }


    @Test
    public void testFindByRangeDescription() {
        setupCriteriaBasedSearchTest();

        NumEmployeesRangeDTO searchCriteria = new NumEmployeesRangeDTO();
        searchCriteria.setRangeDescription("1-10");

        List<NumEmployeesRangeDTO> rangesFound = numEmployeesRangeDAO.findRanges(searchCriteria);

        assertSearchCriteriaResults(rangesFound,1);
    }

    @Test
    public void testFindByRangeFrom() {
        setupCriteriaBasedSearchTest();

        NumEmployeesRangeDTO searchCriteria = new NumEmployeesRangeDTO();
        searchCriteria.setRangeFrom(1);

        List<NumEmployeesRangeDTO> rangesFound = numEmployeesRangeDAO.findRanges(searchCriteria);

        assertSearchCriteriaResults(rangesFound,1);
    }

    @Test
    public void testFindByRangeTo() {
        setupCriteriaBasedSearchTest();

        NumEmployeesRangeDTO searchCriteria = new NumEmployeesRangeDTO();
        searchCriteria.setRangeTo(10);

        List<NumEmployeesRangeDTO> rangesFound = numEmployeesRangeDAO.findRanges(searchCriteria);

        assertSearchCriteriaResults(rangesFound,1);
    }

    @Test
    public void testSaveTwoRangesSameDescription() {
        cleanDatabase();
        numEmployeesRangeDAO.saveRange(createTestRange());
        try {
            Assert.assertEquals("Should be a row in the table for the range",countRowsInTable("NUM_EMPLOYEES_RANGE"),1);
            numEmployeesRangeDAO.saveRange(createTestRange());
        } catch (ConstraintViolationException e) {
            return;
        }
        Assert.fail("No data access exception was thrown when saving a role by the same id");
    }

}
