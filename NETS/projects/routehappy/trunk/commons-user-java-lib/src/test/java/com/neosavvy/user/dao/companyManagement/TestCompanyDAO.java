package com.neosavvy.user.dao.companyManagement;

import com.neosavvy.user.dao.BaseSpringAwareDAOTestCase;
import com.neosavvy.user.dto.companyManagement.*;
import com.neosavvy.user.util.ProjectTestUtil;
import org.junit.Before;
import org.junit.Test;
import org.junit.Assert;

import java.util.List;
import java.util.HashSet;

/**
 * @author lgleason
 */
public class TestCompanyDAO extends BaseSpringAwareDAOTestCase {

    @Test
    public void testFindCompanyById() {
        cleanupTables();
        CompanyDTO company = ProjectTestUtil.createTestCompany();
        companyDAO.saveCompany(company);

        int numRows = countRowsInTable("COMPANY");

        Assert.assertEquals("Num of rows is equal to 1", 1, numRows);

        CompanyDTO companyFound = companyDAO.findCompanyById(company.getId());

        Assert.assertNotNull("Company object was not found by id " + company.getId(), companyFound);
    }

    @Test
    public void testUpdateCompanies() {
        cleanupTables();
        CompanyDTO company = ProjectTestUtil.createTestCompany();
        companyDAO.saveCompany(company);

        company.setAddressOne("666 Satin blvd");
        companyDAO.saveCompany(company);

        int numRows = countRowsInTable("COMPANY");

        Assert.assertEquals("Num of rows is equal to 1", 1, numRows);
    }    

    private void setupCriteriaBasedSearchTest() {
        cleanupTables();

        CompanyDTO company = ProjectTestUtil.createTestCompany();
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

    @Test
    public void testUserCompanyRoles(){
        cleanupTables();


        CompanyDTO company = ProjectTestUtil.createTestCompany();
        company = companyDAO.saveCompany(company);

        UserDTO employee = ProjectTestUtil.createEmployee1User();
        userDAO.saveUser(employee);

        UserCompanyRoleDTO userCompanyRole = createTestUserCompanyRole(employeeRole, company, employee);
        userCompanyRoleDAO.saveUserCompanyRole(userCompanyRole);

        CompanyDTO foundCompany = companyDAO.findCompanyById(company.getId());
        UserCompanyRoleDTO filter = new UserCompanyRoleDTO();
        filter.setCompany(foundCompany);
        List<UserCompanyRoleDTO> companyRoles = userCompanyRoleDAO.findUserCompanyRoles(filter);
        Assert.assertEquals("the userCompanyRole in the company we got back is the same one we stored",
                companyRoles.get(0).getId(),
                userCompanyRole.getId());
    }

    @Test
    public void testUserInvite(){
        cleanupTables();

        CompanyDTO company = ProjectTestUtil.createTestCompany();
        company = companyDAO.saveCompany(company);

        UserInviteDTO userInvite = createTestUserInvite();
        userInvite.setCompany(company);
        userInviteDAO.saveUserInvite(userInvite);

        CompanyDTO foundCompany = companyDAO.findCompanyById(company.getId());
        UserInviteDTO filter = new UserInviteDTO();
        filter.setCompany(foundCompany);
        List<UserInviteDTO> invites = userInviteDAO.findUserInvites(filter);

        Assert.assertEquals("We got the same userInvite id back that we just stored",
                invites.get(0).getId(),
                userInvite.getId());
        Assert.assertEquals("We got the same userInvite email address back that we just stored",
                invites.get(0).getEmailAddress(),
                userInvite.getEmailAddress());
    }
}
