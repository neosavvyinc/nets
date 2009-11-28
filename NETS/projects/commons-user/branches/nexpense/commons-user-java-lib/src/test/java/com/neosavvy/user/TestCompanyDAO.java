package com.neosavvy.user;

import org.springframework.beans.factory.annotation.Autowired;
import org.junit.Test;
import org.junit.Assert;
import org.hibernate.exception.ConstraintViolationException;

import java.util.List;

import com.neosavvy.user.dao.CompanyDAO;
import com.neosavvy.user.dao.UserDAO;
import com.neosavvy.user.dto.CompanyDTO;
import com.neosavvy.user.dto.UserDTO;

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
    @Autowired
    protected UserDAO userDAO;


    private UserDTO createTestUser(){
        UserDTO user = new UserDTO();
        user.setFirstName("William");
        user.setMiddleName("Adam");
        user.setLastName("Parrish");
        user.setUsername("aparrish");
        user.setPassword("testPassword");
        user.setEmailAddress("aparrish@neosavvy.com");
        return user;
    }

    private UserDTO createAltTestUser(){
        UserDTO user = new UserDTO();
        user.setFirstName("Lance");
        user.setMiddleName("B");
        user.setLastName("Gleason");
        user.setUsername("lgleason");
        user.setPassword("testPassword");
        user.setEmailAddress("lg@neosavvy.com");
        return user;
    }

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

    private CompanyDTO createTestCompanyWithUser(UserDTO user) {
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
    public void testFindCompanyById() {
        deleteFromTables("COMPANY");
        deleteFromTables("USER");

        CompanyDTO company = createTestCompany();
        companyDAO.saveCompany(company);

        int numRows = countRowsInTable("COMPANY");

        Assert.assertEquals("Num of rows is equal to 1", 1, numRows);

        CompanyDTO companyFound = companyDAO.findCompanyById(company.getId());

        Assert.assertNotNull("Company object was not found by id " + company.getId(), companyFound);
    }

    private void setupCriteriaBasedSearchTest() {
        deleteFromTables("COMPANY");
        deleteFromTables("USER");

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

    @Test
    public void testFindCompanyWithUser() {
        deleteFromTables("USER_COMPANY");
        deleteFromTables("COMPANY");
        deleteFromTables("USER");
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
        deleteFromTables("USER_COMPANY");
        deleteFromTables("COMPANY");
        deleteFromTables("USER");
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

        Assert.assertEquals("Company has one user", 2, companyFound.getUsers().size());
    }

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
