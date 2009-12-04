package com.neosavvy.user.service;

import org.springframework.test.context.junit4.AbstractTransactionalJUnit4SpringContextTests;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.beans.factory.annotation.Autowired;
import com.neosavvy.user.dao.UserDAO;
import com.neosavvy.user.dto.UserDTO;

/**
 * Created by IntelliJ IDEA.
 * User: lgleason
 * Date: Nov 29, 2009
 * Time: 9:22:33 PM
 * To change this template use File | Settings | File Templates.
 */
@ContextConfiguration(locations = {
		"classpath:applicationContext.xml"
        })
public abstract class BaseSpringAwareServiceTestCase extends AbstractTransactionalJUnit4SpringContextTests {
    @Autowired
    protected UserService userService;
    @Autowired
    protected UserDAO userDAO;

    //Mockery mock_context = new Mockery();

    //todo:  refactor this to something common for dao and Service tests
    protected UserDTO createTestUser() {
        UserDTO user = new UserDTO();
        user.setFirstName("William");
        user.setMiddleName("Adam");
        user.setLastName("Parrish");
        user.setUsername("aparrish");
        user.setPassword("testPassword");
        user.setEmailAddress("aparrish@neosavvy.com");
        return user;
    }
}
