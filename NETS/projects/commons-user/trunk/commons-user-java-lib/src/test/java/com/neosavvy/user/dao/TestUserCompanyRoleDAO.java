package com.neosavvy.user.dao;

import org.junit.Test;
import org.junit.Assert;
import com.neosavvy.user.dto.CompanyDTO;
import com.neosavvy.user.dto.RoleDTO;
import com.neosavvy.user.dto.UserCompanyRoleDTO;

import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: lgleason
 * Date: Dec 9, 2009
 * Time: 12:58:01 PM
 * To change this template use File | Settings | File Templates.
 */
public class TestUserCompanyRoleDAO extends BaseSpringAwareDAOTestCase{

    @Test
    public void testSaveUserCompanyRole() {
        cleanupTables();
        RoleDTO role = createTestRole();
        roleDAO.saveRole(role);

        UserCompanyRoleDTO userCompanyRole = createTestUserCompanyRole(role, null, null);
        userCompanyRoleDAO.saveUserCompanyRole(userCompanyRole);

        Assert.assertTrue("record was added in the db", (int)userCompanyRole.getId() > 0);
    }

    @Test
    public void testAltSaveUserCompanyRole() {
        cleanupTables();
        RoleDTO role = createTestRole();
        roleDAO.saveRole(role);
        CompanyDTO company = createTestCompany();
        companyDAO.saveCompany(company);

        UserCompanyRoleDTO userCompanyRole = createTestUserCompanyRole(role, company, null);
        userCompanyRoleDAO.saveUserCompanyRole(userCompanyRole);

        Assert.assertTrue("Record was added in the db", (int)userCompanyRole.getId() > 0);
    }

    @Test
    public void testGetUserCompanyRoleData() {
        cleanupTables();
        RoleDTO role = createTestRole();
        roleDAO.saveRole(role);
        CompanyDTO company = createTestCompany();
        companyDAO.saveCompany(company);

        UserCompanyRoleDTO userCompanyRole = createTestUserCompanyRole(role, company, null);
        userCompanyRoleDAO.saveUserCompanyRole(userCompanyRole);

        UserCompanyRoleDTO userCompanyRoleReturned = userCompanyRoleDAO.getUserCompanyRoles().get(0);
        Assert.assertEquals("ojbect stored is the one returned",
                userCompanyRole.getId(),
                userCompanyRoleReturned.getId());
        Assert.assertEquals("role in the returned object is the same one we inserted in it",
                role,
                userCompanyRoleReturned.getRole());
        Assert.assertEquals("company in the returned object is the same one we inserted in it",
                company,
                userCompanyRoleReturned.getCompany());        
    }

    @Test
    public void testFindUserCompanyRoleById() {
        cleanupTables();
        RoleDTO role = createTestRole();
        roleDAO.saveRole(role);
        UserCompanyRoleDTO userCompanyRole = createTestUserCompanyRole(role, null, null);
        userCompanyRoleDAO.saveUserCompanyRole(userCompanyRole);

        int numRows = countRowsInTable("USER_COMPANY_ROLE");

        Assert.assertEquals("Num of rows is equal to 1", 1, numRows);

        UserCompanyRoleDTO userCompanyRoleFound = userCompanyRoleDAO.findUserCompanyRoleById(userCompanyRole.getId());

        Assert.assertNotNull("User object was found by id " + role.getId(), userCompanyRoleFound);
    }

    @Test
    public void testDeleteUserCompanyRole() {
        cleanupTables();
        RoleDTO role = createTestRole();
        roleDAO.saveRole(role);
        UserCompanyRoleDTO userCompanyRole = createTestUserCompanyRole(role, null, null);
        userCompanyRoleDAO.saveUserCompanyRole(userCompanyRole);

        int numRows = countRowsInTable("USER_COMPANY_ROLE");

        Assert.assertEquals("Num of rows is equal to 1", 1, numRows);

        userCompanyRoleDAO.deleteUserCompanyRole(userCompanyRole);

        numRows = countRowsInTable("USER_COMPANY_ROLE");
        Assert.assertEquals(0,numRows);
    }

}
