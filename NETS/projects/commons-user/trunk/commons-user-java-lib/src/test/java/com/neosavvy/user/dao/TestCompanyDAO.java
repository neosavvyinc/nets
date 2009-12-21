package com.neosavvy.user.dao;

import org.junit.Test;
import org.junit.Assert;

import java.util.List;
import java.util.HashSet;
import java.util.Set;

import com.neosavvy.user.dto.*;

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

    @Test
    public void testUpdateCompanies() {
        cleanupTables();
        CompanyDTO company = createTestCompany();
        companyDAO.saveCompany(company);

        company.setAddressOne("666 Satin blvd");
        companyDAO.updateCompany(company);

        int numRows = countRowsInTable("COMPANY");

        Assert.assertEquals("Num of rows is equal to 1", 1, numRows);
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

    @Test
    public void testUserCompanyRoles(){
        cleanupTables();

        UserCompanyRoleDTO userCompanyRole = createTestUserCompanyRole(null, null, null);
        userCompanyRoleDAO.saveUserCompanyRole(userCompanyRole);

        CompanyDTO company = createTestCompany();
        HashSet<UserCompanyRoleDTO> userCompanySet = new HashSet();
        userCompanySet.add(userCompanyRole);
        company.setUserCompanyRoles(userCompanySet);
        companyDAO.saveCompany(company);

        CompanyDTO foundCompany = companyDAO.findCompanyById(company.getId());

        Assert.assertEquals("the userCompanyRole in the company we got back is the same one we stored",
                foundCompany.getUserCompanyRoles().iterator().next().getId(),
                userCompanyRole.getId());
    }

    @Test
    public void testUserCompanyRolesRole(){
        cleanupTables();
        RoleDTO role = createTestRole();
        roleDAO.saveRole(role);

        UserCompanyRoleDTO userCompanyRole = createTestUserCompanyRole(role, null, null);
        userCompanyRoleDAO.saveUserCompanyRole(userCompanyRole);

        CompanyDTO company = createTestCompany();
        HashSet<UserCompanyRoleDTO> userCompanySet = new HashSet();
        userCompanySet.add(userCompanyRole);
        company.setUserCompanyRoles(userCompanySet);
        companyDAO.saveCompany(company);

        CompanyDTO foundCompany = companyDAO.findCompanyById(company.getId());

        Assert.assertEquals("the userCompanyRole in the company we got back is the same one we stored",
                foundCompany.getUserCompanyRoles().iterator().next().getId(),
                userCompanyRole.getId());
        Assert.assertEquals("the userCompanyRole role in the company we got back is the same one we stored",
                foundCompany.getUserCompanyRoles().iterator().next().getRole().getId(),
                role.getId());
    }

    @Test
    public void testUserCompanyRolesUser(){
        cleanupTables();
        UserDTO user = createTestUser();
        userDAO.saveUser(user);

        UserCompanyRoleDTO userCompanyRole = createTestUserCompanyRole(null, null, user);
        userCompanyRoleDAO.saveUserCompanyRole(userCompanyRole);

        CompanyDTO company = createTestCompany();
        HashSet<UserCompanyRoleDTO> userCompanySet = new HashSet();
        userCompanySet.add(userCompanyRole);
        company.setUserCompanyRoles(userCompanySet);
        companyDAO.saveCompany(company);

        CompanyDTO foundCompany = companyDAO.findCompanyById(company.getId());

        Assert.assertEquals("the userCompanyRole in the company we got back is the same one we stored",
                foundCompany.getUserCompanyRoles().iterator().next().getId(),
                userCompanyRole.getId());
        Assert.assertEquals("the userCompanyRole role in the company we got back is the same one we stored",
                foundCompany.getUserCompanyRoles().iterator().next().getUser().getId(),
                user.getId());
    }

    @Test
    public void testUserInvite(){
        cleanupTables();
        UserInviteDTO userInvite = createTestUserInvite();
        userInviteDAO.saveUserInvite(userInvite);

        CompanyDTO company = createTestCompany();
        HashSet<UserInviteDTO> userInviteSet = new HashSet();
        userInviteSet.add(userInvite);
        company.setUserInvites(userInviteSet);
        companyDAO.saveCompany(company);

        CompanyDTO foundCompany = companyDAO.findCompanyById(company.getId());

        Assert.assertEquals("We got the same userInvite id back that we just stored",
                foundCompany.getUserInvites().iterator().next().getId(),
                userInvite.getId());
        Assert.assertEquals("We got the same userInvite email address back that we just stored",
                foundCompany.getUserInvites().iterator().next().getEmailAddress(),
                userInvite.getEmailAddress());
    }
}
