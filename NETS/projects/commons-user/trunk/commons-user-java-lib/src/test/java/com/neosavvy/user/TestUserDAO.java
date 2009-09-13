package com.neosavvy.user;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.Assert;

import com.neosavvy.user.dao.UserDAO;
import com.neosavvy.user.dto.UserDTO;

public class TestUserDAO extends BaseSpringAwareTestCase {

	@Autowired
	protected UserDAO userDAO;
	
	@Test
	public void testSaveUser() {
		UserDTO user = new UserDTO();
		user.setFirstName("William");
		user.setMiddleName("Adam");
		user.setLastName("Parrish");
		user.setPassword("testPassword");
		user.setEmailAddress("aparrish@neosavvy.com");
		
		Integer fromHibernate = userDAO.saveUser(user);
		
		Assert.notNull(fromHibernate,"UserDAO should return the persistent object");
	}
}
