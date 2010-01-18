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

public class TestUserService extends BaseSpringAwareServiceTestCase {

    @Test
    public void testGetUsers() throws Exception{
        cleanupTables();
        Assert.assertTrue(findUsers().isEmpty());
        userDAO.saveUser(ProjectTestUtil.createTestUser());
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
