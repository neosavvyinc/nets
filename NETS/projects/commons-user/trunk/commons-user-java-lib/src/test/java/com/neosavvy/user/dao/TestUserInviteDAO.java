package com.neosavvy.user.dao;

import org.junit.Test;
import org.junit.Assert;
import org.hibernate.exception.ConstraintViolationException;

import java.util.List;
import java.util.HashSet;

import com.neosavvy.user.dto.UserInviteDTO;

/**
 * Created by IntelliJ IDEA.
 * User: lgleason
 * Date: Dec 19, 2009
 * Time: 11:41:13 PM
 * To change this template use File | Settings | File Templates.
 */
public class TestUserInviteDAO extends BaseSpringAwareDAOTestCase{
    @Test
	public void testSaveUser() {
        cleanupTables();
        UserInviteDTO userInvite = createTestUserInvite();

		userInviteDAO.saveUserInvite(userInvite);
		Assert.assertTrue(userInvite.getId() > 0);
	}

    @Test
    public void testDeleteUser() {
        cleanupTables();
        int numRows = countRowsInTable("USER_INVITE");
        Assert.assertEquals("The table should be empty", 0, numRows);

        UserInviteDTO userInvite = createTestUserInvite();
        userInviteDAO.saveUserInvite(userInvite);

        numRows = countRowsInTable("USER_INVITE");
        Assert.assertEquals(numRows, 1);

        userInviteDAO.deleteUserInvite(userInvite);

        numRows = countRowsInTable("USER_INVITE");
        Assert.assertEquals(0,numRows);
    }

    @Test
    public void testFindUserById() {
        cleanupTables();

        UserInviteDTO userInvite = createTestUserInvite();
        userInviteDAO.saveUserInvite(userInvite);

        int numRows = countRowsInTable("USER_INVITE");

        Assert.assertEquals("Num of rows is not equal to 1", 1, numRows);

        UserInviteDTO userInviteFound = userInviteDAO.findUserInviteById(userInvite.getId());

        Assert.assertNotNull("User object was not found by id " + userInvite.getId(), userInviteFound);
    }

    @Test
    public void testFindByFirstName() {
        setupCriteriaBasedSearchTest();

        UserInviteDTO searchCriteria = new UserInviteDTO();
        searchCriteria.setFirstName("William");

        List<UserInviteDTO> usersFound = userInviteDAO.findUserInvites(searchCriteria);

        assertSearchCriteriaResults(usersFound,1);
    }

    @Test
    public void testFindByMiddleName() {
        setupCriteriaBasedSearchTest();

        UserInviteDTO searchCriteria = new UserInviteDTO();
        searchCriteria.setMiddleName("Adam");

        List<UserInviteDTO> userInvitesFounds = userInviteDAO.findUserInvites(searchCriteria);

        assertSearchCriteriaResults(userInvitesFounds,1);
    }

    @Test
    public void testFindByLastName() {
        setupCriteriaBasedSearchTest();

        UserInviteDTO searchCriteria = new UserInviteDTO();
        searchCriteria.setLastName("Parrish");

        List<UserInviteDTO> userInvitesFounds = userInviteDAO.findUserInvites(searchCriteria);

        assertSearchCriteriaResults(userInvitesFounds,1);
    }



    private void setupCriteriaBasedSearchTest() {
        cleanupTables();

        UserInviteDTO userInvite = createTestUserInvite();
        UserInviteDTO userInvite2 = createAltTestUserInvite();

        userInviteDAO.saveUserInvite(userInvite);
        userInviteDAO.saveUserInvite(userInvite2);

        int numRows = countRowsInTable("USER_INVITE");
        Assert.assertEquals("Num of rows is not equal to 2", 2, numRows);
    }

//    @Test
//    public void testUserCompanyRoles(){
//        cleanupTables();
//
//        UserCompanyRoleDTO userCompanyRole = createTestUserCompanyRole(null, null, null);
//        userCompanyRoleDAO.saveUserCompanyRole(userCompanyRole);
//
//        UserDTO user = createTestUser();
//        HashSet<UserCompanyRoleDTO> userCompanySet = new HashSet();
//        userCompanySet.add(userCompanyRole);
//        user.setUserCompanyRoles(userCompanySet);
//        userDAO.saveUser(user);
//
//        UserDTO foundUser = userDAO.findUserById(user.getId());
//
//        Assert.assertEquals("the userCompanyRole in the user we got back is the same one we stored",
//                foundUser.getUserCompanyRoles().iterator().next().getId(),
//                userCompanyRole.getId());
//    }
//
//    @Test
//    public void testUserCompanyRolesRole(){
//        cleanupTables();
//        RoleDTO role = createTestRole();
//        roleDAO.saveRole(role);
//
//        UserCompanyRoleDTO userCompanyRole = createTestUserCompanyRole(role, null, null);
//        userCompanyRoleDAO.saveUserCompanyRole(userCompanyRole);
//
//        UserDTO user = createTestUser();
//        HashSet<UserCompanyRoleDTO> userCompanySet = new HashSet();
//        userCompanySet.add(userCompanyRole);
//        user.setUserCompanyRoles(userCompanySet);
//        userDAO.saveUser(user);
//
//        UserDTO foundUser = userDAO.findUserById(user.getId());
//
//        Assert.assertEquals("the userCompanyRole role in the user we got back is the same one we stored",
//                foundUser.getUserCompanyRoles().iterator().next().getRole().getId(),
//                role.getId());
//    }
//
//    @Test
//    public void testUserCompanyRolesCompany(){
//        cleanupTables();
//        RoleDTO role = createTestRole();
//        roleDAO.saveRole(role);
//        CompanyDTO company = createTestCompany();
//        companyDAO.saveCompany(company);
//
//        UserCompanyRoleDTO userCompanyRole = createTestUserCompanyRole(null, company, null);
//        userCompanyRoleDAO.saveUserCompanyRole(userCompanyRole);
//
//        UserDTO user = createTestUser();
//        HashSet<UserCompanyRoleDTO> userCompanySet = new HashSet();
//        userCompanySet.add(userCompanyRole);
//        user.setUserCompanyRoles(userCompanySet);
//        userDAO.saveUser(user);
//
//        UserDTO foundUser = userDAO.findUserById(user.getId());
//
//        Assert.assertEquals("the userCompanyRole role in the user we got back is the same one we stored",
//                foundUser.getUserCompanyRoles().iterator().next().getCompany().getId(),
//                company.getId());
//    }
}
