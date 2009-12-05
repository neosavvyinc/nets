package com.neosavvy.user.service;

import org.junit.Test;
import junit.framework.Assert;
import com.neosavvy.user.dto.RoleDTO;

/**
 * Created by IntelliJ IDEA.
 * User: lgleason
 * Date: Dec 4, 2009
 * Time: 5:39:46 PM
 * To change this template use File | Settings | File Templates.
 */
public class TestRoleService extends BaseSpringAwareServiceTestCase{
    @Test
    public void testGetRoles() throws Exception{
        cleanDatabase();
        roleDAO.saveRole(createTestRole());
        Assert.assertFalse(roleService.getRoles().isEmpty());
    }

    @Test
    public void testFindRoleById() throws Exception{
        cleanDatabase();
        RoleDTO testRole = createTestRole();
        roleDAO.saveRole(testRole);
        Assert.assertFalse(roleService.getRoles().isEmpty());

        Assert.assertNotNull("findRoleById should return the role that we just added when we search by the id for it",
                roleService.findRoleById((testRole.getId())));
    }

    @Test
    public void testFindRoles(){
        cleanDatabase();
        RoleDTO testRole = createTestRole();
        roleDAO.saveRole(testRole);
        Assert.assertFalse(roleService.getRoles().isEmpty());
        Assert.assertTrue(roleService.findRoles(testRole).contains(testRole));
    }

    @Test
    public void testDeleteRoles(){
        cleanDatabase();
        RoleDTO testRole = createTestRole();
        roleDAO.saveRole(testRole);
        Assert.assertFalse(roleService.getRoles().isEmpty());
        roleService.deleteRole(testRole);
        Assert.assertTrue(roleService.getRoles().isEmpty());
    }
}
