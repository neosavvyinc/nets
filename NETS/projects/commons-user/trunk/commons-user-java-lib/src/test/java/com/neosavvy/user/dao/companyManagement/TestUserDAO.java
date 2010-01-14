package com.neosavvy.user.dao.companyManagement;

import com.neosavvy.user.dao.BaseSpringAwareDAOTestCase;
import com.neosavvy.user.dto.companyManagement.UserDTO;
import com.neosavvy.user.dto.companyManagement.CompanyDTO;
import com.neosavvy.user.dto.companyManagement.RoleDTO;
import com.neosavvy.user.dto.companyManagement.UserCompanyRoleDTO;
import com.neosavvy.user.util.ProjectTestUtil;
import org.junit.Assert;
import org.junit.Test;

import javax.persistence.PersistenceException;
import java.util.List;
import java.util.HashSet;

public class TestUserDAO extends BaseSpringAwareDAOTestCase {



	@Test
	public void testSaveUser() {
        cleanupTables();
        UserDTO user = ProjectTestUtil.createTestUser();
		
		userDAO.saveUser(user);
		Assert.assertTrue(user.getId() > 0);
	}

    @Test
    public void testDeleteUser() {
        cleanupTables();
        int numRows = countRowsInTable("USERS");
        Assert.assertEquals(numRows, 0);

        UserDTO user = ProjectTestUtil.createTestUser();
        userDAO.saveUser(user);

        numRows = countRowsInTable("USERS");
        Assert.assertEquals(numRows, 1);

        userDAO.deleteUser(user);

        numRows = countRowsInTable("USERS");
        Assert.assertEquals(0,numRows);
    }

    @Test
    public void testFindUserById() {
        cleanupTables();

        UserDTO user = ProjectTestUtil.createTestUser();
        userDAO.saveUser(user);

        int numRows = countRowsInTable("USERS");

        Assert.assertEquals("Num of rows is not equal to 1", 1, numRows);

        UserDTO userFound = userDAO.findUserById(user.getId());

        Assert.assertNotNull("User object was not found by id " + user.getId(), userFound);
    }

    @Test
    public void testFindByFirstName() {
        setupCriteriaBasedSearchTest();

        UserDTO searchCriteria = new UserDTO();
        searchCriteria.setFirstName("William");

        List<UserDTO> usersFound = userDAO.findUsers(searchCriteria);

        assertSearchCriteriaResults(usersFound,1);

    }

    @Test
    public void testFindByMiddleName() {
        setupCriteriaBasedSearchTest();

        UserDTO searchCriteria = new UserDTO();
        searchCriteria.setMiddleName("Adam");

        List<UserDTO> usersFounds = userDAO.findUsers(searchCriteria);

        assertSearchCriteriaResults(usersFounds,1);
    }

    @Test
    public void testFindByLastName() {
        setupCriteriaBasedSearchTest();

        UserDTO searchCriteria = new UserDTO();
        searchCriteria.setLastName("Parrish");

        List<UserDTO> usersFounds = userDAO.findUsers(searchCriteria);

        assertSearchCriteriaResults(usersFounds,1);
    }

    @Test
    public void testFindByUserName() {
        setupCriteriaBasedSearchTest();

        UserDTO searchCriteria = new UserDTO();
        searchCriteria.setUsername("aparrish");

        List<UserDTO> usersFounds = userDAO.findUsers(searchCriteria);

        assertSearchCriteriaResults(usersFounds,1);
    }

    @Test
    public void testFindByPassword() {
        setupCriteriaBasedSearchTest();

        UserDTO searchCriteria = new UserDTO();
        searchCriteria.setPassword("testPassword");

        List<UserDTO> usersFounds = userDAO.findUsers(searchCriteria);

        assertSearchCriteriaResults(usersFounds,2);        
    }

    @Test(expected = PersistenceException.class)
    public void testSaveTwoUsersSameUserName() {
        cleanupTables();
        userDAO.saveUser(ProjectTestUtil.createTestUser());
        Assert.assertEquals("Should be a row in the table for the user",  1,  countRowsInTable("USER"));
        userDAO.saveUser(ProjectTestUtil.createTestUser());
        Assert.fail("No data access exception was thrown when saving a user by the same id");
    }

    private void setupCriteriaBasedSearchTest() {
        cleanupTables();

        UserDTO user = ProjectTestUtil.createTestUser();
        UserDTO user2 = ProjectTestUtil.createAltTestUser();

        userDAO.saveUser(user);
        userDAO.saveUser(user2);

        int numRows = countRowsInTable("USERS");
        Assert.assertEquals("Num of rows is not equal to 2", 2, numRows);
    }

    @Test
    public void testUserCompanyRoles(){
        cleanupTables();

        UserCompanyRoleDTO userCompanyRole = createTestUserCompanyRole(null, null, null);
        userCompanyRoleDAO.saveUserCompanyRole(userCompanyRole);

        UserDTO user = ProjectTestUtil.createTestUser();
        HashSet<UserCompanyRoleDTO> userCompanySet = new HashSet();
        userCompanySet.add(userCompanyRole);
        user.setUserCompanyRoles(userCompanySet);
        userDAO.saveUser(user);

        UserDTO foundUser = userDAO.findUserById(user.getId());

        Assert.assertEquals("the userCompanyRole in the user we got back is the same one we stored",
                foundUser.getUserCompanyRoles().iterator().next().getId(),
                userCompanyRole.getId());
    }

    @Test
    public void testUserCompanyRolesRole(){
        cleanupTables();
        RoleDTO role = ProjectTestUtil.createTestRole();
        roleDAO.saveRole(role);

        UserCompanyRoleDTO userCompanyRole = createTestUserCompanyRole(role, null, null);
        userCompanyRoleDAO.saveUserCompanyRole(userCompanyRole);

        UserDTO user = ProjectTestUtil.createTestUser();
        HashSet<UserCompanyRoleDTO> userCompanySet = new HashSet();
        userCompanySet.add(userCompanyRole);
        user.setUserCompanyRoles(userCompanySet);
        userDAO.saveUser(user);

        UserDTO foundUser = userDAO.findUserById(user.getId());

        Assert.assertEquals("the userCompanyRole role in the user we got back is the same one we stored",
                foundUser.getUserCompanyRoles().iterator().next().getRole().getId(),
                role.getId());
    }

    @Test
    public void testUserCompanyRolesCompany(){
        cleanupTables();
        RoleDTO role = ProjectTestUtil.createTestRole();
        roleDAO.saveRole(role);
        CompanyDTO company = ProjectTestUtil.createTestCompany();
        companyDAO.saveCompany(company);

        UserCompanyRoleDTO userCompanyRole = createTestUserCompanyRole(null, company, null);
        userCompanyRoleDAO.saveUserCompanyRole(userCompanyRole);

        UserDTO user = ProjectTestUtil.createTestUser();
        HashSet<UserCompanyRoleDTO> userCompanySet = new HashSet();
        userCompanySet.add(userCompanyRole);
        user.setUserCompanyRoles(userCompanySet);
        userDAO.saveUser(user);

        UserDTO foundUser = userDAO.findUserById(user.getId());

        Assert.assertEquals("the userCompanyRole role in the user we got back is the same one we stored",
                foundUser.getUserCompanyRoles().iterator().next().getCompany().getId(),
                company.getId());
    }
}
