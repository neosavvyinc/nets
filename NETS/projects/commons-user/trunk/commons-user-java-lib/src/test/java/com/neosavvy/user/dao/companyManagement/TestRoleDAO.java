package com.neosavvy.user.dao.companyManagement;

import com.neosavvy.user.dao.BaseSpringAwareDAOTestCase;
import com.neosavvy.user.dto.companyManagement.RoleDTO;
import com.neosavvy.user.util.ProjectTestUtil;
import org.junit.Test;
import org.junit.Assert;

import javax.persistence.PersistenceException;
import java.util.List;

/**
 * @author lgleason
 */
public class TestRoleDAO extends BaseSpringAwareDAOTestCase {

    @Test
    public void testSaveRole() {
        cleanupTables();
        RoleDTO role = ProjectTestUtil.createAdminTestRole();

        roleDAO.saveRole(role);
        Assert.assertTrue(role.getId() > 0);
    }

    @Test
    public void testDeleteRole() {
        cleanupTables();
        int numRows = countRowsInTable("ROLE");
        Assert.assertEquals(numRows, 0);

        RoleDTO role = ProjectTestUtil.createAdminTestRole();
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
        RoleDTO role = ProjectTestUtil.createAdminTestRole();
        roleDAO.saveRole(role);

        int numRows = countRowsInTable("ROLE");

        Assert.assertEquals("Num of rows is not equal to 1", 1, numRows);

        RoleDTO roleFound = roleDAO.findRoleById(role.getId());

        Assert.assertNotNull("User object was not found by id " + role.getId(), roleFound);
    }

    private void setupCriteriaBasedSearchTest() {
        cleanupTables();
        RoleDTO role = ProjectTestUtil.createAdminTestRole();
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

    @Test(expected = PersistenceException.class)
    public void testSaveTwoUsersSameUserName() {
        cleanupTables();
        roleDAO.saveRole(ProjectTestUtil.createAdminTestRole());
        Assert.assertEquals("Should be a row in the table for the user",countRowsInTable("ROLE"),1);
        roleDAO.saveRole(ProjectTestUtil.createAdminTestRole());
        Assert.fail("No data access exception was thrown when saving a role by the same id");
    }
}
