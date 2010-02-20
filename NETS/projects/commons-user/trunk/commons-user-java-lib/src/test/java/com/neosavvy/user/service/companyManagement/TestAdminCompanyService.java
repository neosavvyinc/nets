package com.neosavvy.user.service.companyManagement;

import com.neosavvy.user.dto.companyManagement.CompanyDTO;
import com.neosavvy.user.dto.companyManagement.UserCompanyRoleDTO;
import com.neosavvy.user.dto.companyManagement.UserDTO;
import com.neosavvy.user.dto.companyManagement.UserInviteDTO;
import com.neosavvy.user.service.exception.CompanyServiceException;
import com.neosavvy.user.util.ProjectTestUtil;
import junit.framework.Assert;
import org.junit.Before;
import org.junit.Test;
import org.springframework.jdbc.core.simple.ParameterizedRowMapper;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.test.annotation.Rollback;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: tommyodom
 * Date: Jan 19, 2010
 * Time: 7:03:22 PM
 * To change this template use File | Settings | File Templates.
 */
public class TestAdminCompanyService extends TestCompanyService {
    @Before
    public void setupAdministrator() {
        setupAsAdminUser();
    }

    @Test
    public void testUpdateCompany() throws Exception {
        Assert.assertFalse(findCompanies().isEmpty());
        adminCompany.setAddressOne("123 Main Street");
        Assert.assertNotNull(companyService.saveCompany(adminCompany));
    }

    @Test
    public void testFindCompanyById() throws Exception {
        Assert.assertFalse(findCompanies().isEmpty());

        Assert.assertNotNull("findCompanyById should return the company that we just added when we search by the id for it",
                companyService.findCompanyById(adminCompany.getId()));
    }

    @Test
    public void testFindCompanies() {
        Assert.assertFalse(findCompanies().isEmpty());
        List<CompanyDTO> companies = companyService.findCompanies(adminCompany);
        Assert.assertTrue(companies.contains(adminCompany));
    }

    @Test(expected = IllegalArgumentException.class)
    public void testAddUserToCompanyWithNullUser(){
        companyService.addUserToCompany(ProjectTestUtil.createTestCompany(), null);
    }

    @Test(expected = CompanyServiceException.class)
    public void testAddUserToCompanyWithNullCompany(){
        companyService.addUserToCompany(null, ProjectTestUtil.createTestUser());
    }

    @Test(expected = CompanyServiceException.class)
    public void testAddUserToCompanyThatDoesNotExistInDatabase() {
        companyService.addUserToCompany(adminCompany, ProjectTestUtil.createTestUser());
    }

    @Test(expected = IllegalArgumentException.class)
    public void testAddUserToCompanyWithCompanyThatDoesNotExistInDatabase() {
        UserDTO testUser = ProjectTestUtil.createTestUser();
        userDAO.saveUser(testUser);
        companyService.addUserToCompany(ProjectTestUtil.createAltTestCompany(), testUser);
    }

    @Test(expected = CompanyServiceException.class)
    public void testAddUserToCompanyTwice() {
        UserDTO testUser = ProjectTestUtil.createTestUser();
        userDAO.saveUser(testUser);
        companyService.addUserToCompany(adminCompany, testUser);
        companyService.addUserToCompany(adminCompany, testUser);
    }

    @Test
    public void testAddMoreEmployeeToCompany() {
        UserDTO testUserDTO = ProjectTestUtil.createTestUser();
        UserDTO altTestUserDTO = ProjectTestUtil.createAltTestUser();
        userDAO.saveUser(testUserDTO);
        userDAO.saveUser(altTestUserDTO);

        int numUserCompanyRoles = countRowsInTable("USER_COMPANY_ROLE");
        Assert.assertEquals("a row was added to the USER_COMPANY_ROLE table",
                1,
                numUserCompanyRoles);


        companyService.addUserToCompany(adminCompany, testUserDTO);
        companyService.addUserToCompany(adminCompany, altTestUserDTO);
        numUserCompanyRoles = countRowsInTable("USER_COMPANY_ROLE");
        Assert.assertEquals("a row was added to the USER_COMPANY_ROLE table",
                3,
                numUserCompanyRoles);

        UserCompanyRoleDTO userCompanyRoleToFind = new UserCompanyRoleDTO();
        userCompanyRoleToFind.setCompany(adminCompany);
        userCompanyRoleToFind.setRole(employeeRole);

        List<UserCompanyRoleDTO> userCompanyRolesFound = userCompanyRoleDAO.findUserCompanyRoles(userCompanyRoleToFind);
        Assert.assertEquals("Number of Employees is 2", 2,
            userCompanyRolesFound.size());
    }


    @Test(expected = CompanyServiceException.class)
    public void testInviteUsersNoUsers(){
        companyService.inviteUsers(adminCompany, null);
    }

    @Test(expected = CompanyServiceException.class)
    public void testInviteUsersNoCompany(){
        companyService.inviteUsers(null, ProjectTestUtil.createTestUserInvite());
    }

    @Test(expected = IllegalArgumentException.class)
    public void testInviteUsersNoPersistedCompany(){
        companyService.inviteUsers(ProjectTestUtil.createParentCompany(), ProjectTestUtil.createTestUserInvite());
    }

    @Test
    public void testInviteUsersPersistsOneUser(){
        UserInviteDTO testUserInvite = ProjectTestUtil.createTestUserInvite();
        companyService.inviteUsers(adminCompany, testUserInvite);
        UserInviteDTO userInviteToFind = new UserInviteDTO();
        userInviteToFind.setCompany(adminCompany);
        List<UserInviteDTO> userInvitesFound = userInviteDAO.findUserInvites(userInviteToFind);
        Assert.assertEquals("Persisted User invite is the one we created",
                testUserInvite.getId(),
                userInvitesFound.get(0).getId());
    }

    @Test
    public void testInviteUsersPersistsTwoUsers(){
        UserInviteDTO testUserInvite = ProjectTestUtil.createTestUserInvite();
        UserInviteDTO altTestUserInvite = ProjectTestUtil.createAltTestUserInvite();

        companyService.inviteUsers(adminCompany, testUserInvite);
        companyService.inviteUsers(adminCompany, altTestUserInvite);
        UserInviteDTO userInviteToFind = new UserInviteDTO();
        userInviteToFind.setCompany(adminCompany);

        List<UserInviteDTO> userInvitesFound = userInviteDAO.findUserInvites(userInviteToFind);
        List<String> userInviteEmails = new ArrayList();

        for(UserInviteDTO invite: userInvitesFound){
            userInviteEmails.add(invite.getEmailAddress());
        }
        Assert.assertTrue("Persisted User invite contains the ones we created",
                userInviteEmails.contains(altTestUserInvite.getEmailAddress()));
    }

    @Test(expected = CompanyServiceException.class)
    public void testInviteSameUserWithSameCompany(){
        UserInviteDTO testUserInvite = ProjectTestUtil.createTestUserInvite();

        companyService.inviteUsers(adminCompany, testUserInvite);
        companyService.inviteUsers(adminCompany, testUserInvite);
    }

    @Test(expected = CompanyServiceException.class)
    public void testGetUserInvitesNullCompany(){
        companyService.getInvitedUsers(null);
    }

    @Test(expected = CompanyServiceException.class)
    public void testGetUserInvitesUnpersistedCompany(){
        companyService.getInvitedUsers(ProjectTestUtil.createTestCompany());
    }

    @Test
    public void testAddEmployeeToCompany() {
        // Invite a user to that company
        UserInviteDTO userToInvite = ProjectTestUtil.createTestInvite();
        companyService.inviteUsers(adminCompany,userToInvite);

        // Look up that users confirmation - this would occur by the user and would be emailed to them
        // since there is only one user - can just query for all and use the first one
        UserInviteDTO userInvitesFromDatabase =  simpleJdbcTemplate.queryForObject("SELECT * FROM USER_INVITE", new ParameterizedRowMapper<UserInviteDTO>(){
            public UserInviteDTO mapRow(ResultSet rs, int rowNum) throws SQLException {
                UserInviteDTO userInvite = new UserInviteDTO();

                userInvite.setRegistrationToken( rs.getString("REGISTRATION_TOKEN"));

                return userInvite;
            }
        });

        clearAuthentication();

        // Populate a user with the confirmation token and call addEmployeToCompany
        UserDTO user = ProjectTestUtil.createTestUser();
        user.setRegistrationToken(userInvitesFromDatabase.getRegistrationToken());

        companyService.addEmployeeToCompany(user);


        // Assert that when looking up the list of employee's that the new employee is there
        int numberEmployeesInCompany = countRowsInTable("USER_COMPANY_ROLE");
        Assert.assertEquals("Number of employees was expected to be 2 but was not", 2,numberEmployeesInCompany);

    }

    @Test
    public void testGetAllEmployeesFromCompany() {
        setupCompanyTestUsers(adminCompany);

        List<UserDTO> allUsers = companyService.findUsersForCompany(adminCompany);
        List<UserDTO> activeUsers = companyService.findActiveUsersForCompany(adminCompany);
        List<UserDTO> inactiveUsers = companyService.findInactiveUsersForCompany(adminCompany);

        Assert.assertNotNull(allUsers);
        Assert.assertNotNull(activeUsers);
        Assert.assertNotNull(inactiveUsers);

        Assert.assertEquals("Should be 4 users for the company", 4,allUsers.size());
        Assert.assertEquals("Should be 3 active users for the company", 3,activeUsers.size());
        Assert.assertEquals("Should be 1 inactive user for the company", 1,inactiveUsers.size());
    }

    @Test
    public void testUnauthorizedReadCompanyUsers() {
        setupAdmin2User();

        List<UserDTO> allUsers = companyService.findUsersForCompany(adminCompany);
        List<UserDTO> activeUsers = companyService.findActiveUsersForCompany(adminCompany);
        List<UserDTO> inactiveUsers = companyService.findInactiveUsersForCompany(adminCompany);

        Assert.assertEquals("Verify can't read other companies users", 0, allUsers.size());
        Assert.assertEquals("Verify can't read other companies active users", 0, activeUsers.size());
        Assert.assertEquals("Verify can't read other companies inactive users", 0, inactiveUsers.size());
    }

    @Test(expected = AccessDeniedException.class)
    public void testUnauthorizedSaveCompany() {
        setupAdmin2User();
        companyService.saveCompany(adminCompany);
    }

    private void setupAdmin2User() {
        CompanyDTO testCompany2 = findOrCreateCompany(ProjectTestUtil.createAltTestCompany());
        UserDTO adminUser2 = ProjectTestUtil.createAdmin2User();
        companyService.addCompany(testCompany2, adminUser2);
        loginAsUser(adminUser2);
    }

    protected void setupCompanyTestUsers(CompanyDTO company) {
        UserDTO user1 = ProjectTestUtil.createTestUser();
        UserInviteDTO invite1 = new UserInviteDTO(user1);
        companyService.inviteUsers(company, invite1);
        user1.setRegistrationToken(invite1.getRegistrationToken());
        companyService.addEmployeeToCompany(user1);

        UserDTO user2 = ProjectTestUtil.createAltTestUser();
        UserInviteDTO invite2 = new UserInviteDTO(user2);
        companyService.inviteUsers(company, invite2);
        user2.setRegistrationToken(invite2.getRegistrationToken());
        companyService.addEmployeeToCompany(user2);

        UserDTO user3 = ProjectTestUtil.createTestUser3();
        UserInviteDTO invite3 = new UserInviteDTO(user3);
        companyService.inviteUsers(company, invite3);
        user3.setRegistrationToken(invite3.getRegistrationToken());
        companyService.addEmployeeToCompany(user3);

        List<UserDTO> users = userService.findUsers(user3);
        Assert.assertEquals("Validate we can find the user we just added.", 1, users.size());
        users.get(0).setActive(false);
        userService.updateUser(users.get(0));
        
        int numUsers = countRowsInTable("USERS");
        Assert.assertEquals("Validate number of users", 4, numUsers);

        int numUsersMappedToCompany1 = countRowsInTable("USER_COMPANY_ROLE");
        Assert.assertEquals("Validate number of users mapped to company",4, numUsersMappedToCompany1);

    }
}
