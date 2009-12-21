package com.neosavvy.user.service;

import com.neosavvy.user.dto.*;
import com.neosavvy.user.service.exception.CompanyServiceException;
import junit.framework.Assert;
import org.junit.Test;

import java.util.List;
import java.util.ArrayList;
import java.util.Set;
import java.util.HashSet;

/**
 * @author lgleason
 */
public class TestCompanyService extends BaseSpringAwareServiceTestCase {

    protected UserInviteDTO createTestUserInvite(){
        UserInviteDTO userInvite = new UserInviteDTO();
        userInvite.setFirstName("William");
        userInvite.setMiddleName("Adam");
        userInvite.setLastName("Parrish");
        userInvite.setEmailAddress("aparrish@neosavvy.com");
        return userInvite;
    }

    protected UserInviteDTO createAltTestUserInvite(){
        UserInviteDTO userInvite = new UserInviteDTO();
        userInvite.setFirstName("Lance");
        userInvite.setMiddleName("B");
        userInvite.setLastName("Gleason");
        userInvite.setEmailAddress("lg@neosavvy.com");
        return userInvite;
    }

    protected UserInviteDTO createAnotherTestUserInvite(){
        UserInviteDTO userInvite = new UserInviteDTO();
        userInvite.setFirstName("Ted");
        userInvite.setMiddleName("B");
        userInvite.setLastName("Bundy");
        userInvite.setEmailAddress("tb@neosavvy.com");
        return userInvite;
    }

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
    public void testInviteUsersNoUsers(){
        cleanDatabase();
        companyService.inviteUsers(createTestCompany(), null);
    }

    @Test(expected = CompanyServiceException.class)
    public void testInviteUsersNoCompany(){
        cleanDatabase();
        List<UserInviteDTO> userInvites = new ArrayList();
        userInvites.add(createTestUserInvite());
        companyService.inviteUsers(null, userInvites);
    }

    @Test(expected = CompanyServiceException.class)
    public void testInviteUsersNoPersistedCompany(){
        cleanDatabase();
        List<UserInviteDTO> userInvites = new ArrayList();
        userInvites.add(createTestUserInvite());
        companyService.inviteUsers(createTestCompany(), userInvites);
    }

    @Test
    public void testInviteUsersPersistsOneUser(){
        cleanDatabase();
        List<UserInviteDTO> userInvites = new ArrayList();
        userInvites.add(createTestUserInvite());
        CompanyDTO company = createTestCompany();
        companyDAO.saveCompany(company);
        companyService.inviteUsers(company, userInvites);
        CompanyDTO foundCompany = companyService.findCompanyById(company.getId());
        Assert.assertEquals("Persisted User invite is the one we created",
                userInvites.iterator().next().getId(),
                foundCompany.getUserInvites().iterator().next().getId());
    }

    @Test
    public void testInviteUsersPersistsTwoUsers(){
        cleanDatabase();
        List<UserInviteDTO> userInvites = new ArrayList();
        UserInviteDTO testUserInvite = createTestUserInvite();
        UserInviteDTO altTestUserInvite = createAltTestUserInvite();
        userInvites.add(testUserInvite);
        userInvites.add(altTestUserInvite);
        CompanyDTO company = createTestCompany();
        companyDAO.saveCompany(company);
        companyService.inviteUsers(company, userInvites);
        CompanyDTO foundCompany = companyService.findCompanyById(company.getId());
        Assert.assertTrue("Persisted User invite contains the ones we created",
                userInvites.contains(altTestUserInvite));
    }

    @Test
    public void testInviteUsersPersistsLastSaved(){
        cleanDatabase();
        List<UserInviteDTO> userInvites = new ArrayList();
        userInvites.add(createTestUserInvite());
        CompanyDTO company = createTestCompany();
        companyDAO.saveCompany(company);
        companyService.inviteUsers(company, userInvites);
        CompanyDTO foundCompany = companyService.findCompanyById(company.getId());
        Assert.assertEquals("Persisted User invite is the one we created",
                userInvites.iterator().next().getId(),
                foundCompany.getUserInvites().iterator().next().getId());
        userInvites = new ArrayList();
        userInvites.add(createAltTestUserInvite());
        companyService.inviteUsers(company, userInvites);
        foundCompany = companyService.findCompanyById(company.getId());
        Assert.assertEquals("Persisted User invite is the one we created",
                userInvites.iterator().next().getId(),
                foundCompany.getUserInvites().iterator().next().getId());
    }

    @Test(expected = CompanyServiceException.class)
    public void testGetUserInvitesNullCompany(){
        companyService.getInvitedUsers(null);
    }

    @Test(expected = CompanyServiceException.class)
    public void testGetUserInvitesUnpersistedCompany(){
        companyService.getInvitedUsers(createTestCompany());
    }

    @Test
    public void testGetUserInvites(){
        cleanDatabase();
        List<UserInviteDTO> userInvites = new ArrayList();
        userInvites.add(createTestUserInvite());
        CompanyDTO company = createTestCompany();
        companyDAO.saveCompany(company);
        companyService.inviteUsers(company, userInvites);
        List<UserInviteDTO> foundUserInvites = companyService.getInvitedUsers(company);
        Assert.assertEquals("Persisted User invite is the one we created",
                userInvites.iterator().next().getId(),
                foundUserInvites.iterator().next().getId());
    }

    @Test(expected = CompanyServiceException.class)
    public void testAddCompanyException() {
        //this expects to throw an exception
        cleanDatabase();
        CompanyDTO testCompany = createTestCompany();
        UserDTO testUser = createTestUser();

        companyService.addCompany(testCompany, testUser);
    }
}
