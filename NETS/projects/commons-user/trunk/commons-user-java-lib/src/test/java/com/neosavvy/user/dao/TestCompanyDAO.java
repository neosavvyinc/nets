package com.neosavvy.user.dao;

import org.junit.Test;
import org.junit.Assert;

import java.util.List;

import com.neosavvy.user.dto.CompanyDTO;
import com.neosavvy.user.dto.UserDTO;
import com.neosavvy.user.dto.NumEmployeesRangeDTO;

/**
 * @author lgleason
 */
public class TestCompanyDAO extends BaseSpringAwareDAOTestCase {
    
    @Test
    public void testFindCompanyById() {
        cleanupTables();
        CompanyDTO company = createTestCompany();
        companyDAO.saveCompany(company);

        int numRows = countRowsInTable("COMPANY");

        Assert.assertEquals("Num of rows is equal to 1", 1, numRows);

        CompanyDTO companyFound = companyDAO.findCompanyById(company.getId());

        Assert.assertNotNull("Company object was not found by id " + company.getId(), companyFound);
    }

    private void setupCriteriaBasedSearchTest() {
        cleanupTables();

        CompanyDTO company = createTestCompany();
        CompanyDTO company2 = createAltTestCompany();

        companyDAO.saveCompany(company);
        companyDAO.saveCompany(company2);

        int numRows = countRowsInTable("COMPANY");
        Assert.assertEquals("Num of rows is not equal to 2", 2, numRows);
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

    protected CompanyDTO createTestCompanyWithUser(UserDTO user) {
        CompanyDTO company = new CompanyDTO();
        company.setCompanyName("Big Enterprises");
        company.setAddressOne("address one one");
        company.setAddressTwo("address two two");
        company.setCity("Toronto");
        company.setState("CA");
        company.setPostalCode("14895");
        company.setCountry("Canada");
        company.addUser(user);
        return company;
    }    

    @Test
    public void testFindCompanyWithUser() {
        cleanupTables();
        UserDTO user = createTestUser();
        userDAO.saveUser(user);
        CompanyDTO company = createTestCompanyWithUser(user);
        companyDAO.saveCompany(company);


        int numRows = countRowsInTable("COMPANY");

        Assert.assertEquals("Num of rows is equal to 1", 1, numRows);

        CompanyDTO companyFound = companyDAO.findCompanyById(company.getId());

        Assert.assertNotNull("Company object was not found by id " + company.getId(), companyFound);

        Assert.assertEquals("Company has one user", 1, companyFound.getUsers().size());
    }

    @Test
    public void testFindCompanyWithMultipleUsers() {
        cleanupTables();
        UserDTO user = createTestUser();
        userDAO.saveUser(user);
        UserDTO altUser = createAltTestUser();
        userDAO.saveUser(altUser);
        CompanyDTO company = createTestCompanyWithUser(user);
        company.addUser(altUser);
        companyDAO.saveCompany(company);


        int numRows = countRowsInTable("COMPANY");

        Assert.assertEquals("Num of rows is equal to 1", 1, numRows);

        CompanyDTO companyFound = companyDAO.findCompanyById(company.getId());

        Assert.assertNotNull("Company object was not found by id " + company.getId(), companyFound);

        Assert.assertEquals("Company has two users", 2, companyFound.getUsers().size());
    }

    @Test
    public void testAddNumEmployeesRangeToCompany() {
        cleanupTables();
        NumEmployeesRangeDTO testNumEmployeesRange = createTestRange();
        numEmployeesRangeDAO.saveRange(testNumEmployeesRange);
        CompanyDTO company = createTestCompany();
        company.setNumEmployeesRange(testNumEmployeesRange);
        companyDAO.saveCompany(company);

        CompanyDTO foundCompany = companyDAO.findCompanyById(company.getId());

        Assert.assertEquals("Found company has the num employees range we just set",
                company.getNumEmployeesRange().getRangeDescription(),
                foundCompany.getNumEmployeesRange().getRangeDescription());
    }

}
