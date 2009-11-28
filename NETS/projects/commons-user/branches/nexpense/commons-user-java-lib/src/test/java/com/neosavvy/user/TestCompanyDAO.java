package com.neosavvy.user;

import org.springframework.beans.factory.annotation.Autowired;
import org.junit.Test;
import org.junit.Assert;
import org.hibernate.exception.ConstraintViolationException;

import java.util.List;

import com.neosavvy.user.dao.CompanyDAO;
import com.neosavvy.user.dto.CompanyDTO;

/**
 * Created by IntelliJ IDEA.
 * User: lgleason
 * Date: Nov 27, 2009
 * Time: 3:23:00 PM
 * To change this template use File | Settings | File Templates.
 */
public class TestCompanyDAO extends BaseSpringAwareTestCase{
    @Autowired
	protected CompanyDAO companyDAO;



    private CompanyDTO createTestCompany() {
        CompanyDTO company = new CompanyDTO();
        company.setCompanyName("BFD Enterprises");
        company.setAddressOne("address one");
        company.setAddressTwo("address two");
        company.setCity("Atlanta");
        company.setState("GA");
        company.setPostalCode("30312");
        company.setCountry("USA");
        return company;
    }

    private CompanyDTO createAltTestCompany() {
        CompanyDTO company = new CompanyDTO();
        company.setCompanyName("Zymol Enterprises");
        company.setAddressOne("address one one");
        company.setAddressTwo("address two two");
        company.setCity("Wellsville");
        company.setState("NY");
        company.setPostalCode("14895");
        company.setCountry("USA");
        return company;
    }
    
    @Test
    public void testFindCompanyById() {
        deleteFromTables("COMPANY");

        CompanyDTO company = createTestCompany();
        companyDAO.saveCompany(company);

        int numRows = countRowsInTable("COMPANY");

        Assert.assertEquals("Num of rows is equal to 1", 1, numRows);

        CompanyDTO companyFound = companyDAO.findCompanyById(company.getId());

        Assert.assertNotNull("Company object was not found by id " + company.getId(), companyFound);
    }

    private void setupCriteriaBasedSearchTest() {
        deleteFromTables("COMPANY");

        CompanyDTO company = createTestCompany();
        CompanyDTO company2 = createAltTestCompany();

        companyDAO.saveCompany(company);
        companyDAO.saveCompany(company2);

        int numRows = countRowsInTable("COMPANY");
        Assert.assertEquals("Num of rows is not equal to 2", 2, numRows);
    }

    private void assertSearchCriteriaResults(List<CompanyDTO> companiesFound,int numRows) {
        Assert.assertNotNull("Search results were null", companiesFound);
        Assert.assertEquals("Size of returned results should have been " + numRows, numRows,companiesFound.size());
    }

    @Test
    public void testFindByCompanyName() {
        setupCriteriaBasedSearchTest();

        CompanyDTO searchCriteria = new CompanyDTO();
        searchCriteria.setCompanyName("BFD Enterprises");

        List<CompanyDTO> companiesFound = companyDAO.findCompanies(searchCriteria);

        assertSearchCriteriaResults(companiesFound,1);

    }

    @Test
    public void testFindByCity() {
        setupCriteriaBasedSearchTest();

        CompanyDTO searchCriteria = new CompanyDTO();
        searchCriteria.setCity("Atlanta");

        List<CompanyDTO> companiesFound = companyDAO.findCompanies(searchCriteria);

        assertSearchCriteriaResults(companiesFound,1);
    }

    @Test
    public void testFindByState() {
        setupCriteriaBasedSearchTest();

        CompanyDTO searchCriteria = new CompanyDTO();
        searchCriteria.setState("GA");

        List<CompanyDTO> companiesFound = companyDAO.findCompanies(searchCriteria);

        assertSearchCriteriaResults(companiesFound,1);
    }

    @Test
    public void testFindByPostalCode() {
        setupCriteriaBasedSearchTest();

        CompanyDTO searchCriteria = new CompanyDTO();
        searchCriteria.setPostalCode("30312");

        List<CompanyDTO> companiesFound = companyDAO.findCompanies(searchCriteria);

        assertSearchCriteriaResults(companiesFound,1);
    }

    @Test
    public void testFindByPostalCodeNotFound() {
        setupCriteriaBasedSearchTest();

        CompanyDTO searchCriteria = new CompanyDTO();
        searchCriteria.setPostalCode("30316");

        List<CompanyDTO> companiesFound = companyDAO.findCompanies(searchCriteria);

        assertSearchCriteriaResults(companiesFound,0);
    }
//
//    @Test
//    public void testFindByPassword() {
//        setupCriteriaBasedSearchTest();
//
//        CompanyDTO searchCriteria = new CompanyDTO();
//        searchCriteria.setPassword("testPassword");
//
//        List<CompanyDTO> companiesFound = companyDAO.findUsers(searchCriteria);
//
//        assertSearchCriteriaResults(companiesFound,2);
//    }
//
//    @Test
//    public void testSaveTwoUsersSameUserName() {
//        deleteFromTables("USER");
//        companyDAO.saveUser(createTestUser());
//        try {
//            Assert.assertEquals("Should be a row in the table for the user",countRowsInTable("USER"),1);
//            companyDAO.saveUser(createTestUser());
//        } catch (ConstraintViolationException e) {
//            return;
//        }
//        Assert.fail("No data access exception was thrown when saving a user by the same id");
//    }
//

//
//

}
