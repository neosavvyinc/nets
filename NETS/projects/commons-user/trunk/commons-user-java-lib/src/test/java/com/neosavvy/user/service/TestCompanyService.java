package com.neosavvy.user.service;

import com.neosavvy.user.dto.*;
import com.neosavvy.user.service.exception.CompanyServiceException;
import com.neosavvy.user.dao.UserInviteDAO;
import junit.framework.Assert;
import org.junit.Test;
import org.springframework.jdbc.core.simple.ParameterizedRowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

/**
 * @author lgleason
 */
public class TestCompanyService extends BaseSpringAwareServiceTestCase {

    protected UserInviteDTO createTestUserInvite(){
        UserInviteDTO userInvite = new UserInviteDTO();
        userInvite.setFirstName("William");
        userInvite.setMiddleName("Adam");
        userInvite.setLastName("Parrish");
        userInvite.setEmailAddress("aparrish1@neosavvy.com");
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
//    public void testAddEmployeeToDifferentCompanies() {
//        cleanDatabase();
//        CompanyDTO testCompany = createTestCompany();
//        companyDAO.saveCompany(testCompany);
//        UserDTO testUser = createTestUser();
//        userDAO.saveUser(testUser);
//
//        companyService.addCompany(testCompany, testUser);
//    }

    

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

    @Test
    public void testAddMoreEmployeeToCompany() {
        cleanDatabase();
        CompanyDTO testCompany = createTestCompany();
        UserDTO testUserDTO = createTestUser();
        UserDTO altTestUserDTO = createAltTestUser();
        roleDAO.saveRole(createEmployeeTestRole());
        roleDAO.saveRole(createTestRole());
        userDAO.saveUser(testUserDTO);
        userDAO.saveUser(altTestUserDTO);

        companyService.addCompany(testCompany, testUserDTO);

        int numUserCompanyRoles = countRowsInTable("USER_COMPANY_ROLE");
        Assert.assertEquals("a row was added to the USER_COMPANY_ROLE table",
                1,
                numUserCompanyRoles);


        companyService.addUserToCompany(testCompany, altTestUserDTO);
        numUserCompanyRoles = countRowsInTable("USER_COMPANY_ROLE");
        Assert.assertEquals("a row was added to the USER_COMPANY_ROLE table",
                2,
                numUserCompanyRoles);

        UserCompanyRoleDTO userCompanyRoleToFind = new UserCompanyRoleDTO();
        userCompanyRoleToFind.setCompany(testCompany);
        
        List<UserCompanyRoleDTO> userCompanyRolesFound = userCompanyRoleDao.findUserCompanyRoles(userCompanyRoleToFind);
        Assert.assertEquals("Number of Employees is 2", 2,
            userCompanyRolesFound.size());
    }

    @Test(expected = CompanyServiceException.class)
    public void testReAddEmployeeToCompany() {
        cleanDatabase();
        CompanyDTO testCompany = createTestCompany();
        UserDTO testUserDTO = createTestUser();
        roleDAO.saveRole(createEmployeeTestRole());
        roleDAO.saveRole(createTestRole());
        userDAO.saveUser(testUserDTO);
        companyDAO.saveCompany(testCompany);

        companyService.addCompany(testCompany, testUserDTO);

        int numUserCompanyRoles = countRowsInTable("USER_COMPANY_ROLE");
        Assert.assertEquals("a row was added to the USER_COMPANY_ROLE table",
                1,
                numUserCompanyRoles);

        companyService.addUserToCompany(testCompany, testUserDTO);
        companyService.addUserToCompany(testCompany, testUserDTO);
    }

    @Test(expected = CompanyServiceException.class)
    public void testInviteUsersNoUsers(){
        cleanDatabase();
        companyService.inviteUsers(createTestCompany(), null);
    }

    @Test(expected = CompanyServiceException.class)
    public void testInviteUsersNoCompany(){
        cleanDatabase();
        companyService.inviteUsers(null, createTestUserInvite());
    }

    @Test(expected = CompanyServiceException.class)
    public void testInviteUsersNoPersistedCompany(){
        cleanDatabase();
        companyService.inviteUsers(createTestCompany(), createTestUserInvite());
    }

    @Test
    public void testInviteUsersPersistsOneUser(){
        cleanDatabase();
        UserInviteDTO testUserInvite = createTestUserInvite();
        CompanyDTO company = createTestCompany();
        companyDAO.saveCompany(company);
        companyService.inviteUsers(company, testUserInvite);
        UserInviteDTO userInviteToFind = new UserInviteDTO();
        userInviteToFind.setCompany(company);
        List<UserInviteDTO> userInvitesFound = userInviteDao.findUserInvites(userInviteToFind);
        Assert.assertEquals("Persisted User invite is the one we created",
                testUserInvite.getId(),
                userInvitesFound.get(0).getId());
    }

    @Test
    public void testInviteUsersPersistsTwoUsers(){
        cleanDatabase();
        UserInviteDTO testUserInvite = createTestUserInvite();
        UserInviteDTO altTestUserInvite = createAltTestUserInvite();

        CompanyDTO company = createTestCompany();
        companyDAO.saveCompany(company);
        companyService.inviteUsers(company, testUserInvite);
        companyService.inviteUsers(company, altTestUserInvite);
        UserInviteDTO userInviteToFind = new UserInviteDTO();
        userInviteToFind.setCompany(company);

        List<UserInviteDTO> userInvitesFound = userInviteDao.findUserInvites(userInviteToFind);
        List<String> userInviteEmails = new ArrayList();

        for(UserInviteDTO invite: userInvitesFound){
            userInviteEmails.add(invite.getEmailAddress());
        }
        Assert.assertTrue("Persisted User invite contains the ones we created",
                userInviteEmails.contains(altTestUserInvite.getEmailAddress()));
    }

    @Test(expected = CompanyServiceException.class)
    public void testInviteSameUserWithSameCompany(){
        cleanDatabase();
        UserInviteDTO testUserInvite = createTestUserInvite();

        CompanyDTO company = createTestCompany();
        companyDAO.saveCompany(company);
        companyService.inviteUsers(company, testUserInvite);
        companyService.inviteUsers(company, testUserInvite);
    }


//    @Test
//    public void testInviteUsersPersistPersistedUser(){
//        cleanDatabase();
//        List<UserInviteDTO> userInvites = new ArrayList();
//        userInvites.add(createTestUserInvite());
//        CompanyDTO company = createTestCompany();
//        roleDAO.saveRole(createTestRole());
//        companyService.addCompany(company, createTestUser());
//        List<UserInviteDTO> problemInvites = companyService.inviteUsers(company, userInvites);
//        Assert.assertEquals("Item is returned as a problem invite because a registered user with same e-mail exists",
//                userInvites.iterator().next().getEmailAddress(),
//                problemInvites.get(0).getEmailAddress());
//        CompanyDTO foundCompany = companyService.findCompanyById(company.getId());
//        Assert.assertFalse(foundCompany.getUserInvites().contains(problemInvites.get(0)));
//    }

    @Test(expected = CompanyServiceException.class)
    public void testGetUserInvitesNullCompany(){
        companyService.getInvitedUsers(null);
    }

    @Test(expected = CompanyServiceException.class)
    public void testGetUserInvitesUnpersistedCompany(){
        companyService.getInvitedUsers(createTestCompany());
    }

//    @Test
//    public void testGetUserInvites(){
//        cleanDatabase();
//        List<UserInviteDTO> userInvites = new ArrayList();
//        userInvites.add(createTestUserInvite());
//        CompanyDTO company = createTestCompany();
//        companyDAO.saveCompany(company);
//        companyService.inviteUsers(company, userInvites);
//        List<UserInviteDTO> foundUserInvites = companyService.getInvitedUsers(company);
//        Assert.assertEquals("Persisted User invite is the one we created",
//                userInvites.iterator().next().getId(),
//                foundUserInvites.iterator().next().getId());
//    }

    @Test(expected = CompanyServiceException.class)
    public void testAddCompanyException() {
        //this expects to throw an exception
        cleanDatabase();
        CompanyDTO testCompany = createTestCompany();
        UserDTO testUser = createTestUser();

        companyService.addCompany(testCompany, testUser);
    }


    @Test
    public void testAddEmployeeToCompany() {
        cleanDatabase();

        // Register a new company
        CompanyDTO testCompany = createTestCompany();
        UserDTO testUser = createAltTestUser();
        RoleDTO testRole = createTestRole();
        RoleDTO testEmployeeRole = createEmployeeTestRole();

        roleDAO.saveRole(testRole);
        roleDAO.saveRole(testEmployeeRole);

        companyService.addCompany(testCompany, testUser);

        // Invite a user to that company
        UserInviteDTO userToInvite = createTestInvite();
        companyService.inviteUsers(testCompany,userToInvite);

        // Look up that users confirmation - this would occur by the user and would be emailed to them
        // since there is only one user - can just query for all and use the first one
        UserInviteDTO userInvitesFromDatabase =  simpleJdbcTemplate.queryForObject("SELECT * FROM USER_INVITE", new ParameterizedRowMapper<UserInviteDTO>(){
            public UserInviteDTO mapRow(ResultSet rs, int rowNum) throws SQLException {
                UserInviteDTO userInvite = new UserInviteDTO();

                userInvite.setRegistrationToken( rs.getString("REGISTRATION_TOKEN"));

                return userInvite;
            }
        });

        // Populate a user with the confirmation token and call addEmployeToCompany
        UserDTO user = createTestUser();
        user.setRegistrationToken(userInvitesFromDatabase.getRegistrationToken());

        companyService.addEmployeeToCompany(user);


        // Assert that when looking up the list of employee's that the new employee is there
        int numberEmployeesInCompany = countRowsInTable("USER_COMPANY_ROLE");
        Assert.assertEquals("Number of employees was expected to be 2 but was not", 2,numberEmployeesInCompany);

    }
}
