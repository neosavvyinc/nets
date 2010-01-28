package com.neosavvy.user.service;

import com.neosavvy.user.dto.companyManagement.CompanyDTO;
import com.neosavvy.user.dto.companyManagement.UserDTO;
import com.neosavvy.user.util.ProjectTestUtil;
import org.junit.Before;
import org.junit.Test;
import junit.framework.Assert;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import java.util.List;

public class TestUserService extends BaseSpringAwareServiceTestCase {
    protected UserDTO adminUser;

    @Before
    public void setupAdministrator() {
        adminUser = setupAsAdminUser();
    }

    @Test
    public void testGetUsers() throws Exception{
        List<UserDTO> users = userService.findUsers(adminUser);
        Assert.assertFalse(users.isEmpty());
    }

    @Test
    public void testEmployeeUpdateUser() throws Exception{
        UserDTO user = setupAsEmployeeUser();
        user.setMiddleName(null);
        userService.updateUser(user);
        UserDTO foundUser = userDAO.findUserById(user.getId());
        Assert.assertNotNull(foundUser);
        Assert.assertNull(foundUser.getMiddleName());
    }

    @Test
    public void testAdminUpdateUser() throws Exception{
        adminUser.setMiddleName(null);
        userService.updateUser(adminUser);
        UserDTO foundUser = userDAO.findUserById(adminUser.getId());
        Assert.assertNotNull(foundUser);
        Assert.assertNull(foundUser.getMiddleName());
    }

    @Test
    public void testConfirmUser() throws Exception{
        Assert.assertFalse(findUsers().isEmpty());
        clearAuthentication();
        Assert.assertTrue(userService.confirmUser(adminUser.getUsername(), adminUser.getRegistrationToken()));
        loginAsUser(adminUser);

        UserDTO foundUser = userDAO.findUserById(adminUser.getId());
        Assert.assertTrue(foundUser.getActive());
        Assert.assertTrue(foundUser.getConfirmedRegistration());
    }

    @Test
    public void testFindUserById() throws Exception{

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
