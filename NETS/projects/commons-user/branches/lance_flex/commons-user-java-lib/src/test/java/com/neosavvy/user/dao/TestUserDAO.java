package com.neosavvy.user.dao;

import com.neosavvy.user.dto.UserDTO;
import com.neosavvy.user.dto.CompanyDTO;
import com.neosavvy.user.dto.RoleDTO;
import com.neosavvy.user.dto.UserCompanyRoleDTO;
import org.hibernate.exception.ConstraintViolationException;
import org.junit.Assert;
import org.junit.Test;

import java.util.List;
import java.util.HashSet;

public class TestUserDAO extends BaseSpringAwareDAOTestCase {



	@Test
	public void testSaveUser() {
        cleanupTables();
        UserDTO user = createTestUser();
		
		userDAO.saveUser(user);
		Assert.assertTrue((int)user.getId() > 0);
	}

    @Test
    public void testDeleteUser() {
        cleanupTables();
        int numRows = countRowsInTable("USER");
        Assert.assertEquals(numRows, 0);

        UserDTO user = createTestUser();
        userDAO.saveUser(user);

        numRows = countRowsInTable("USER");
        Assert.assertEquals(numRows, 1);

        userDAO.deleteUser(user);

        numRows = countRowsInTable("USER");
        Assert.assertEquals(0,numRows);
    }

    @Test
    public void testFindUserById() {
        cleanupTables();

        UserDTO user = createTestUser();
        userDAO.saveUser(user);

        int numRows = countRowsInTable("USER");

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

    @Test
    public void testSaveTwoUsersSameUserName() {
        cleanupTables();
        userDAO.saveUser(createTestUser());
        try {
            Assert.assertEquals("Should be a row in the table for the user",countRowsInTable("USER"),1);
            userDAO.saveUser(createTestUser());
        } catch (ConstraintViolationException e) {
            return;
        }
        Assert.fail("No data access exception was thrown when saving a user by the same id");
    }

    private void setupCriteriaBasedSearchTest() {
        cleanupTables();

        UserDTO user = createTestUser();
        UserDTO user2 = createAltTestUser();

        userDAO.saveUser(user);
        userDAO.saveUser(user2);

        int numRows = countRowsInTable("USER");
        Assert.assertEquals("Num of rows is not equal to 2", 2, numRows);
    }

    @Test
    public void testUserCompanyRoles(){
        cleanupTables();

        UserCompanyRoleDTO userCompanyRole = createTestUserCompanyRole(null, null, null);
        userCompanyRoleDAO.saveUserCompanyRole(userCompanyRole);

        UserDTO user = createTestUser();
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
        RoleDTO role = createTestRole();
        roleDAO.saveRole(role);

        UserCompanyRoleDTO userCompanyRole = createTestUserCompanyRole(role, null, null);
        userCompanyRoleDAO.saveUserCompanyRole(userCompanyRole);

        UserDTO user = createTestUser();
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
        RoleDTO role = createTestRole();
        roleDAO.saveRole(role);
        CompanyDTO company = createTestCompany();
        companyDAO.saveCompany(company);

        UserCompanyRoleDTO userCompanyRole = createTestUserCompanyRole(null, company, null);
        userCompanyRoleDAO.saveUserCompanyRole(userCompanyRole);

        UserDTO user = createTestUser();
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
