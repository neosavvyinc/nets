package com.neosavvy.user.service;

import com.neosavvy.user.dto.CompanyDTO;
import com.neosavvy.user.dto.RoleDTO;
import com.neosavvy.user.dto.UserCompanyRoleDTO;
import com.neosavvy.user.dto.UserDTO;
import com.neosavvy.user.service.exception.CompanyServiceException;
import junit.framework.Assert;
import org.junit.Test;

/**
 * @author lgleason
 */
public class TestCompanyService extends BaseSpringAwareServiceTestCase {
    @Test
    public void testGetCompanies() throws Exception {
        cleanDatabase();
        companyService.saveCompany(createTestCompany());
        Assert.assertFalse(companyService.getCompanies().isEmpty());
    }

    @Test
    public void testFindCompanyById() throws Exception {
        cleanDatabase();
        CompanyDTO testCompany = createTestCompany();
        companyService.saveCompany(testCompany);
        Assert.assertFalse(companyService.getCompanies().isEmpty());

        Assert.assertNotNull("findCompanyById should return the company that we just added when we search by the id for it",
                companyService.findCompanyById(testCompany.getId()));
    }

    @Test
    public void testFindCompanies() {
        cleanDatabase();
        CompanyDTO testCompany = createTestCompany();
        companyService.saveCompany(testCompany);
        Assert.assertFalse(companyService.getCompanies().isEmpty());
        Assert.assertTrue(companyService.findCompanies(testCompany).contains(testCompany));
    }

    @Test
    public void testAddCompany() {
        cleanDatabase();
        CompanyDTO testCompany = createTestCompany();
        UserDTO testUser = createTestUser();
        RoleDTO testRole = createTestRole();

        roleDAO.saveRole(testRole);

        companyService.addCompany(testCompany, testUser);
        int numUserCompanyRoles = countRowsInTable("USER_COMPANY_ROLE");
        Assert.assertEquals("a row was added to the USER_COMPANY_ROLE table",
                1,
                numUserCompanyRoles);

        CompanyDTO foundCompany = companyService.findCompanyById(testCompany.getId());
        UserCompanyRoleDTO foundUserCompanyRole = (UserCompanyRoleDTO) foundCompany.getUserCompanyRoles().toArray()[0];
        Assert.assertEquals("role for found company is the same as what we saved",
                testRole.getId(),
                foundUserCompanyRole.getRole().getId());
        Assert.assertEquals("user for found company is the same as what we saved",
                testUser.getId(),
                foundUserCompanyRole.getUser().getId());
    }

    @Test(expected = CompanyServiceException.class)
    public void testAddUserToCompanyWithNullUser(){
        companyService.addUserToCompany(createTestCompany(), null);
    }

    @Test(expected = CompanyServiceException.class)
    public void testAddUserToCompanyWithNullCompany(){
        companyService.addUserToCompany(null, createTestUser());
    }

    @Test(expected = CompanyServiceException.class)
    public void testAddUserToCompanyThatDoesNotExistInDatabase() {
        cleanDatabase();
        CompanyDTO testCompany = createTestCompany();
        companyService.saveCompany(testCompany);
        companyService.addUserToCompany(testCompany, createTestUser());
    }

    @Test(expected = CompanyServiceException.class)
    public void testAddUserToCompanyWithCompanyThatDoesNotExistInDatabase() {
        cleanDatabase();
        UserDTO testUser = createTestUser();
        userDAO.saveUser(testUser);
        companyService.addUserToCompany(createTestCompany(), testUser);
    }

    @Test(expected = CompanyServiceException.class)
    public void testAddEmployeeToCompanyTwice() {
        cleanDatabase();
        CompanyDTO testCompany = createTestCompany();
        companyDAO.saveCompany(testCompany);
        UserDTO testUser = createTestUser();
        userDAO.saveUser(testUser);

        companyService.addCompany(testCompany, testUser);
    }

//    @Test(expected = CompanyServiceException.class)
//    public void testAddEmployeeToCompanyTwice() {
//        cleanDatabase();
//        CompanyDTO testCompany = createTestCompany();
//        UserDTO testUserDTO = createTestUser();
//        roleDAO.saveRole(createEmployeeTestRole());
//        roleDAO.saveRole(createTestRole());
//
//        companyService.addCompany(testCompany, testUserDTO);
//
//        int numUserCompanyRoles = countRowsInTable("USER_COMPANY_ROLE");
//        Assert.assertEquals("a row was added to the USER_COMPANY_ROLE table",
//                1,
//                numUserCompanyRoles);
//
//
//        companyService.addEmployeeToCompany(testCompany, testUserDTO);
//    }

//    @Test
//    public void testAddMoreEmployeeToCompany() {
//        cleanDatabase();
//        CompanyDTO testCompany = createTestCompany();
//        UserDTO testUserDTO = createTestUser();
//        roleDAO.saveRole(createEmployeeTestRole());
//        roleDAO.saveRole(createTestRole());
//
//        companyService.addCompany(testCompany, testUserDTO);
//
//        int numUserCompanyRoles = countRowsInTable("USER_COMPANY_ROLE");
//        Assert.assertEquals("a row was added to the USER_COMPANY_ROLE table",
//                1,
//                numUserCompanyRoles);
//
//
//        companyService.addEmployeeToCompany(testCompany, testUserDTO);
//        numUserCompanyRoles = countRowsInTable("USER_COMPANY_ROLE");
//        Assert.assertEquals("a row was added to the USER_COMPANY_ROLE table",
//                2,
//                numUserCompanyRoles);
//
//        CompanyDTO foundCompany = companyService.findCompanyById(testCompany.getId());
//        Assert.assertEquals("Number of Employees is the ");
//    }


    @Test(expected = CompanyServiceException.class)
    public void testAddCompanyException() {
        //this expects to throw an exception
        cleanDatabase();
        CompanyDTO testCompany = createTestCompany();
        UserDTO testUser = createTestUser();

        companyService.addCompany(testCompany, testUser);
    }
}
