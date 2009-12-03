package com.neosavvy.user.service;

import org.junit.Test;
import org.springframework.mail.MailSender;
import org.springframework.mail.SimpleMailMessage;
import org.jmock.Expectations;
import junit.framework.Assert;

/**
 * Created by IntelliJ IDEA.
 * User: lgleason
 * Date: Nov 29, 2009
 * Time: 9:10:37 PM
 * To change this template use File | Settings | File Templates.
 */
public class TestUserService extends BaseSpringAwareServiceTestCase {
    private void cleanDatabase() {
        deleteFromTables("USER_ROLE");
        deleteFromTables("USER_COMPANY");
        deleteFromTables("USER");
        deleteFromTables("ROLE");
    }

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
        final MailSender mailSender = mock_context.mock(MailSender.class);
        userService.setMailSender(mailSender);

        mock_context.checking(new Expectations() {{
            oneOf (mailSender).send(with(any(SimpleMailMessage.class)));
        }});
        userService.saveUser(createTestUser());
        Assert.assertFalse(userService.getUsers().isEmpty());
    }
}
