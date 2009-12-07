package com.neosavvy.user.service;

import org.junit.Before;
import org.junit.Test;
import org.springframework.mail.MailSender;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.security.context.SecurityContextHolder;
import org.springframework.security.providers.UsernamePasswordAuthenticationToken;
import org.easymock.EasyMock;
import junit.framework.Assert;
import com.neosavvy.user.dto.UserDTO;

/**
 * @author lgleason
 */
public class TestUserService extends BaseSpringAwareServiceTestCase {

    @Test
    public void testGetUsers() throws Exception{
        cleanDatabase();
        Assert.assertTrue(userService.getUsers().isEmpty());
        userDAO.saveUser(createTestUser());
        Assert.assertFalse(userService.getUsers().isEmpty());
    }

    @Test
    public void testSaveUser() throws Exception{
        cleanDatabase();
        MailSender mailSender = EasyMock.createMock(MailSender.class);
        userService.setMailSender(mailSender);

        mailSender.send((SimpleMailMessage) EasyMock.anyObject());
        EasyMock.replay(mailSender);

        userService.saveUser(createTestUser());
        Assert.assertFalse(userService.getUsers().isEmpty());
    }

    @Test
    public void testConfirmUser() throws Exception{
        cleanDatabase();
        MailSender mailSender = EasyMock.createMock(MailSender.class);
        userService.setMailSender(mailSender);

        mailSender.send((SimpleMailMessage) EasyMock.anyObject());
        EasyMock.replay(mailSender);


        UserDTO  testUser = createTestUser();
        userService.saveUser(testUser);
        Assert.assertFalse(userService.getUsers().isEmpty());

        Assert.assertTrue(userService.confirmUser(testUser.getUsername(), testUser.getRegistrationToken()));
    }

    @Test
    public void testFindUserById() throws Exception{
        cleanDatabase();
        UserDTO  testUser = createTestUser();
        userDAO.saveUser(testUser);
        Assert.assertFalse(userService.getUsers().isEmpty());
        Assert.assertNotNull("findUserById should return the user that we just added when we search by the id for it",
                userService.findUserById(testUser.getId()));
    }

}
