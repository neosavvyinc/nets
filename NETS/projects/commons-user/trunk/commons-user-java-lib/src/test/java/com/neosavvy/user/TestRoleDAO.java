package com.neosavvy.user;

import org.junit.Test;
import org.junit.Assert;
import org.hibernate.exception.ConstraintViolationException;

import java.util.List;

import com.neosavvy.user.dto.RoleDTO;
import com.neosavvy.user.dto.UserDTO;

/**
 * Created by IntelliJ IDEA.
 * User: lgleason
 * Date: Nov 28, 2009
 * Time: 4:08:02 AM
 * To change this template use File | Settings | File Templates.
 */
public class TestRoleDAO extends BaseSpringAwareTestCase{

    private void cleanDatabase() {
        deleteFromTables("USER_ROLE");
        deleteFromTables("ROLE");
        deleteFromTables("USER");
    }

    @Test
    public void testSaveRole() {
        cleanDatabase();
        RoleDTO role = createTestRole();

        roleDAO.saveRole(role);
        Assert.assertTrue((int)role.getId() > 0);
    }

    @Test
    public void testDeleteRole() {
        cleanDatabase();
        int numRows = countRowsInTable("ROLE");
        Assert.assertEquals(numRows, 0);

        RoleDTO role = createTestRole();
        roleDAO.saveRole(role);

        numRows = countRowsInTable("ROLE");
        Assert.assertEquals(numRows, 1);

        roleDAO.deleteRole(role);

        numRows = countRowsInTable("ROLE");
        Assert.assertEquals(0,numRows);
    }

    @Test
    public void testFindRoleById() {
        cleanDatabase();
        RoleDTO role = createTestRole();
        roleDAO.saveRole(role);

        int numRows = countRowsInTable("ROLE");

        Assert.assertEquals("Num of rows is not equal to 1", 1, numRows);

        RoleDTO roleFound = roleDAO.findRoleById(role.getId());

        Assert.assertNotNull("User object was not found by id " + role.getId(), roleFound);
    }

    private void setupCriteriaBasedSearchTest() {
        cleanDatabase();
        RoleDTO role = createTestRole();
        RoleDTO role2 = createAltTestRole();

        roleDAO.saveRole(role);
        roleDAO.saveRole(role2);

        int numRows = countRowsInTable("ROLE");
        Assert.assertEquals("Num of rows is equal to 2", 2, numRows);
    }


    @Test
    public void testFindByShortName() {
        setupCriteriaBasedSearchTest();

        RoleDTO searchCriteria = new RoleDTO();
        searchCriteria.setShortName("ADMIN");

        List<RoleDTO> rolesFound = roleDAO.findRoles(searchCriteria);

        assertSearchCriteriaResults(rolesFound,1);
    }

    @Test
    public void testFindByLongName() {
        setupCriteriaBasedSearchTest();

        RoleDTO searchCriteria = new RoleDTO();
        searchCriteria.setLongName("Administrator");

        List<RoleDTO> rolesFounds = roleDAO.findRoles(searchCriteria);

        assertSearchCriteriaResults(rolesFounds,1);
        cleanDatabase();
    }

    @Test
    public void testSaveTwoUsersSameUserName() {
        cleanDatabase();
        roleDAO.saveRole(createTestRole());
        try {
            Assert.assertEquals("Should be a row in the table for the user",countRowsInTable("ROLE"),1);
            roleDAO.saveRole(createTestRole());
        } catch (ConstraintViolationException e) {
            return;
        }
        Assert.fail("No data access exception was thrown when saving a role by the same id");
    }


    protected RoleDTO createTestRoleWithUser(UserDTO user) {
        RoleDTO role = createTestRole();
        role.addUser(user);
        return role;
    }

    @Test
    public void testFindRoleWithUser() {
        cleanDatabase();
        UserDTO user = createTestUser();
        userDAO.saveUser(user);
        RoleDTO role = createTestRoleWithUser(user);
        roleDAO.saveRole(role);


        int numRows = countRowsInTable("ROLE");

        Assert.assertEquals("Num of rows is equal to 1", 1, numRows);

        RoleDTO roleFound = roleDAO.findRoleById(role.getId());

        Assert.assertNotNull("User object was found by id " + role.getId(), roleFound);

        Assert.assertEquals("User has one company", 1, roleFound.getUsers().size());
    }

    @Test
    public void testFindRoleWithMultipleUsers() {
        cleanDatabase();
        UserDTO user = createTestUser();
        userDAO.saveUser(user);
        UserDTO altUser = createAltTestUser();
        userDAO.saveUser(altUser);
        RoleDTO role = createTestRoleWithUser(user);
        role.addUser(altUser);
        roleDAO.saveRole(role);



        int numRows = countRowsInTable("ROLE");

        Assert.assertEquals("Num of rows is equal to 1", 1, numRows);

        RoleDTO roleFound = roleDAO.findRoleById(role.getId());

        Assert.assertNotNull("User object was found by id " + role.getId(), roleFound);

        Assert.assertEquals("User has one company", 2, roleFound.getUsers().size());
    }

}
