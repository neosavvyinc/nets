package com.neosavvy.user;

import com.neosavvy.user.dao.UserDAO;
import com.neosavvy.user.dto.UserDTO;
import com.neosavvy.user.dto.CompanyDTO;
import org.hibernate.exception.ConstraintViolationException;
import org.junit.Assert;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;

import java.util.List;

public class TestUserDAO extends BaseSpringAwareTestCase {
	
	@Test
	public void testSaveUser() {
        deleteFromTables("USER_COMPANY");
        deleteFromTables("COMPANY");
        deleteFromTables("USER");
        UserDTO user = createTestUser();
		
		userDAO.saveUser(user);
		Assert.assertTrue((int)user.getId() > 0);
	}

    @Test
    public void testDeleteUser() {
        deleteFromTables("USER_COMPANY");
        deleteFromTables("COMPANY");
        deleteFromTables("USER");
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
        deleteFromTables("USER_COMPANY");
        deleteFromTables("COMPANY");
        deleteFromTables("USER");

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
        deleteFromTables("USER_COMPANY");
        deleteFromTables("COMPANY");
        deleteFromTables("USER");
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
        deleteFromTables("USER_COMPANY");
        deleteFromTables("COMPANY");
        deleteFromTables("USER");

        UserDTO user = createTestUser();
        UserDTO user2 = createAltTestUser();

        userDAO.saveUser(user);
        userDAO.saveUser(user2);

        int numRows = countRowsInTable("USER");
        Assert.assertEquals("Num of rows is not equal to 2", 2, numRows);
    }

    protected UserDTO createTestUserWithCompany(CompanyDTO company) {
        UserDTO user = new UserDTO();
        user.setFirstName("William");
        user.setMiddleName("Adam");
        user.setLastName("Parrish");
        user.setUsername("aparrish");
        user.setPassword("testPassword");
        user.setEmailAddress("aparrish@neosavvy.com");
        user.addCompany(company);
        return user;
    }

    @Test
    public void testFindUserWithCompany() {
        deleteFromTables("USER_COMPANY");
        deleteFromTables("COMPANY");
        deleteFromTables("USER");
        CompanyDTO company = createTestCompany();
        companyDAO.saveCompany(company);
        UserDTO user = createTestUserWithCompany(company);
        userDAO.saveUser(user);


        int numRows = countRowsInTable("USER");

        Assert.assertEquals("Num of rows is equal to 1", 1, numRows);

        UserDTO userFound = userDAO.findUserById(user.getId());

        Assert.assertNotNull("User object was not found by id " + user.getId(), userFound);

        Assert.assertEquals("User has one company", 1, userFound.getCompanies().size());
    }

    @Test
    public void testFindUserWithMultipleCompanies() {
        deleteFromTables("USER_COMPANY");
        deleteFromTables("COMPANY");
        deleteFromTables("USER");
        CompanyDTO company = createTestCompany();
        companyDAO.saveCompany(company);
        CompanyDTO altCompany = createAltTestCompany();
        companyDAO.saveCompany(altCompany);
        UserDTO user = createTestUserWithCompany(company);
        user.addCompany(altCompany);
        userDAO.saveUser(user);


        int numRows = countRowsInTable("USER");

        Assert.assertEquals("Num of rows is equal to 1", 1, numRows);

        UserDTO userFound = userDAO.findUserById(user.getId());

        Assert.assertNotNull("User object was not found by id " + user.getId(), userFound);

        Assert.assertEquals("User has 2 companies", 2, userFound.getCompanies().size());
    }


}
