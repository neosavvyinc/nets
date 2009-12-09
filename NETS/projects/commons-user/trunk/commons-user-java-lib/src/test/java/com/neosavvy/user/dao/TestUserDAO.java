package com.neosavvy.user.dao;

import com.neosavvy.user.dto.UserDTO;
import com.neosavvy.user.dto.CompanyDTO;
import com.neosavvy.user.dto.RoleDTO;
import org.hibernate.exception.ConstraintViolationException;
import org.junit.Assert;
import org.junit.Test;

import java.util.List;

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

}
