package com.neosavvy.user.service;

import com.neosavvy.user.dto.companyManagement.CompanyDTO;
import com.neosavvy.user.dto.companyManagement.UserDTO;
import com.neosavvy.user.util.ProjectTestUtil;
import org.junit.Test;
import org.springframework.mail.MailSender;
import org.springframework.mail.SimpleMailMessage;
import org.easymock.EasyMock;
import junit.framework.Assert;

import javax.persistence.PersistenceException;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import java.util.List;

/**
 * @author lgleason
 */
public class TestUserService extends BaseSpringAwareServiceTestCase {

    @Test
    public void testGetUsers() throws Exception{
        cleanupTables();
        Assert.assertTrue(findUsers().isEmpty());
        userDAO.saveUser(ProjectTestUtil.createTestUser());
        Assert.assertFalse(findUsers().isEmpty());
    }

    @Test
    public void testCreateAdminUser() throws Exception{
        cleanupTables();
        Assert.assertTrue(findUsers().isEmpty());
        MailSender mailSender = EasyMock.createMock(MailSender.class);
        userService.setMailSender(mailSender);

        mailSender.send((SimpleMailMessage) EasyMock.anyObject());
        EasyMock.replay(mailSender);

        userService.createAdminUser(ProjectTestUtil.createTestUser());
        Assert.assertFalse(findUsers().isEmpty());
    }

    @Test
    public void testSaveUser() throws Exception{
        cleanupTables();
        Assert.assertTrue(findUsers().isEmpty());

        userService.saveUser(ProjectTestUtil.createTestUser());
        Assert.assertFalse(findUsers().isEmpty());
    }

    @Test
    public void testConfirmUser() throws Exception{
        cleanupTables();
        MailSender mailSender = EasyMock.createMock(MailSender.class);
        userService.setMailSender(mailSender);

        mailSender.send((SimpleMailMessage) EasyMock.anyObject());
        EasyMock.replay(mailSender);


        UserDTO  testUser = ProjectTestUtil.createTestUser();
        testUser.setConfirmedRegistration(false);
        testUser.setActive(false);
        userService.createAdminUser(testUser);
        Assert.assertFalse(findUsers().isEmpty());

        Assert.assertTrue(userService.confirmUser(testUser.getUsername(), testUser.getRegistrationToken()));

        UserDTO foundUser = userDAO.findUserById(testUser.getId());
        Assert.assertTrue(foundUser.getActive());
        Assert.assertTrue(foundUser.getConfirmedRegistration());
    }

    @Test(expected = PersistenceException.class)
    public void testCreateDuplicateAdminUser() throws Exception{
        cleanupTables();
        MailSender mailSender = EasyMock.createMock(MailSender.class);
        userService.setMailSender(mailSender);

        mailSender.send((SimpleMailMessage) EasyMock.anyObject());
        EasyMock.replay(mailSender);

        userDAO.saveUser(ProjectTestUtil.createTestUser());
        userService.createAdminUser(ProjectTestUtil.createTestUser());

    }

    @Test
    public void testFindUserById() throws Exception{
        cleanupTables();
        UserDTO  testUser = ProjectTestUtil.createTestUser();
        userDAO.saveUser(testUser);
        Assert.assertFalse(findUsers().isEmpty());
        Assert.assertNotNull("findUserById should return the user that we just added when we search by the id for it",
                userService.findUserById(testUser.getId()));
    }

    private List<UserDTO> findUsers() {
        CriteriaBuilder builder = getEntityManager().getCriteriaBuilder();
        CriteriaQuery query = builder.createQuery(UserDTO.class);
        query.from(UserDTO.class);
        return getEntityManager().createQuery(query).getResultList();
    }

}
