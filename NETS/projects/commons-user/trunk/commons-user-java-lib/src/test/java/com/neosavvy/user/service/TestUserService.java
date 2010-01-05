package com.neosavvy.user.service;

import com.neosavvy.user.dto.companyManagement.UserDTO;
import org.hibernate.exception.ConstraintViolationException;
import org.junit.Test;
import org.springframework.mail.MailSender;
import org.springframework.mail.SimpleMailMessage;
import org.easymock.EasyMock;
import junit.framework.Assert;

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
    public void testCreateAdminUser() throws Exception{
        cleanDatabase();
        Assert.assertTrue(userService.getUsers().isEmpty());
        MailSender mailSender = EasyMock.createMock(MailSender.class);
        userService.setMailSender(mailSender);

        mailSender.send((SimpleMailMessage) EasyMock.anyObject());
        EasyMock.replay(mailSender);

        userService.createAdminUser(createTestUser());
        Assert.assertFalse(userService.getUsers().isEmpty());
    }

    @Test
    public void testSaveUser() throws Exception{
        cleanDatabase();
        Assert.assertTrue(userService.getUsers().isEmpty());

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
        testUser.setConfirmedRegistration(false);
        testUser.setActive(false);
        userService.createAdminUser(testUser);
        Assert.assertFalse(userService.getUsers().isEmpty());

        Assert.assertTrue(userService.confirmUser(testUser.getUsername(), testUser.getRegistrationToken()));

        UserDTO foundUser = userDAO.findUserById(testUser.getId());
        Assert.assertTrue(foundUser.getActive());
        Assert.assertTrue(foundUser.getConfirmedRegistration());
    }

    @Test(expected = ConstraintViolationException.class)
    public void testCreateDuplicateAdminUser() throws Exception{
        cleanDatabase();
        MailSender mailSender = EasyMock.createMock(MailSender.class);
        userService.setMailSender(mailSender);

        mailSender.send((SimpleMailMessage) EasyMock.anyObject());
        EasyMock.replay(mailSender);

        userDAO.saveUser(createTestUser());
        userService.createAdminUser(createTestUser());

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
