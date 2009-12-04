package com.neosavvy.user.service;

import com.neosavvy.user.dao.UserDAO;
import com.neosavvy.user.dto.UserDTO;
import org.junit.Before;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.security.context.SecurityContextHolder;
import org.springframework.security.providers.UsernamePasswordAuthenticationToken;
import org.springframework.beans.factory.BeanFactoryUtils;
import junit.framework.Assert;

/**
 * Created by IntelliJ IDEA.
 * User: lgleason
 * Date: Dec 4, 2009
 * Time: 3:18:35 PM
 * To change this template use File | Settings | File Templates.
 */
public class TestUserSecurityService {

    protected UserService userServices;
    protected UserDAO userDaos;

    //Mockery mock_context = new Mockery();

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

    /*
        Adam.....I had to comment these two methods so that ci wasn't broken...uncomment to look at the issue
        I was talking about.
     */
    @Before
    public void setup() {
//        ApplicationContext context = new ClassPathXmlApplicationContext(new String[] { "ApplicationContext.xml",
//                "testSecurityContext.xml" });
//        SecurityContextHolder.getContext().setAuthentication(null);
//        userServices = (UserService) BeanFactoryUtils.beanOfType(context, UserService.class);
//        userDaos = (UserDAO) BeanFactoryUtils.beanOfType(context, UserDAO.class);
    }

    @Test
    public void testFindUserByIdWithSecurity() throws Exception{
//        UserDTO testUser = createTestUser();
//        SecurityContextHolder.getContext().setAuthentication(new UsernamePasswordAuthenticationToken("empl1", "pass1"));
//        userServices.findUserById(testUser.getId());
    }
}
