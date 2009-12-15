package com.neosavvy.user.dao;

import org.junit.Test;
import org.junit.Assert;
import org.hibernate.exception.ConstraintViolationException;

import java.util.List;

import com.neosavvy.user.dto.RoleDTO;
import com.neosavvy.user.dto.UserDTO;

/**
 * @author lgleason
 */
public class TestRoleDAO extends BaseSpringAwareDAOTestCase {

    @Test
    public void testSaveRole() {
        cleanupTables();
        RoleDTO role = createTestRole();

        roleDAO.saveRole(role);
        Assert.assertTrue((int)role.getId() > 0);
    }

    @Test
    public void testDeleteRole() {
        cleanupTables();
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
        cleanupTables();
        RoleDTO role = createTestRole();
        roleDAO.saveRole(role);

        int numRows = countRowsInTable("ROLE");

        Assert.assertEquals("Num of rows is not equal to 1", 1, numRows);

        RoleDTO roleFound = roleDAO.findRoleById(role.getId());

        Assert.assertNotNull("User object was not found by id " + role.getId(), roleFound);
    }

    private void setupCriteriaBasedSearchTest() {
        cleanupTables();
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
        searchCriteria.setShortName("ROLE_ADMIN");

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
        cleanupTables();
    }

    @Test
    public void testSaveTwoUsersSameUserName() {
        cleanupTables();
        roleDAO.saveRole(createTestRole());
        try {
            Assert.assertEquals("Should be a row in the table for the user",countRowsInTable("ROLE"),1);
            roleDAO.saveRole(createTestRole());
        } catch (ConstraintViolationException e) {
            return;
        }
        Assert.fail("No data access exception was thrown when saving a role by the same id");
    }

}
