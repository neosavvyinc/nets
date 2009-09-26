package com.neosavvy.user;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.neosavvy.user.dao.UserDAO;
import com.neosavvy.user.dto.UserDTO;

import org.junit.Assert;

public class TestUserDAO extends BaseSpringAwareTestCase {

	@Autowired
	protected UserDAO userDAO;
	
	@Test
	public void testSaveUser() {
        deleteFromTables("USER");
        UserDTO user = createTestUser();
		
		userDAO.saveUser(user);
		
		Assert.assertEquals((int)user.getId(),(int)1);
	}

    private UserDTO createTestUser() {
        UserDTO user = new UserDTO();
        user.setFirstName("William");
        user.setMiddleName("Adam");
        user.setLastName("Parrish");
        user.setPassword("testPassword");
        user.setEmailAddress("aparrish@neosavvy.com");
        return user;
    }

    @Test
    public void testDeleteUser() {
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
        deleteFromTables("USER");

        UserDTO user = createTestUser();
        userDAO.saveUser(user);

        int numRows = countRowsInTable("USER");

        UserDTO userFound = userDAO.findUserById(user.getId());

        Assert.assertNotNull("User object was not found by id " + user.getId(), userFound);
    }
}
