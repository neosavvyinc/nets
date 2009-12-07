package com.neosavvy.user.service;

import org.junit.Test;
import junit.framework.Assert;
import com.neosavvy.user.dto.RoleDTO;

/**
 * @author lgleason
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
