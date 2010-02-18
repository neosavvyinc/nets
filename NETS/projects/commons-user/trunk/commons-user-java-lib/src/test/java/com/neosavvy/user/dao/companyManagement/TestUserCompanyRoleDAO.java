package com.neosavvy.user.dao.companyManagement;

import com.neosavvy.user.dao.BaseSpringAwareDAOTestCase;
import com.neosavvy.user.util.ProjectTestUtil;
import org.junit.Before;
import org.junit.Test;
import org.junit.Assert;
import com.neosavvy.user.dto.companyManagement.CompanyDTO;
import com.neosavvy.user.dto.companyManagement.RoleDTO;
import com.neosavvy.user.dto.companyManagement.UserCompanyRoleDTO;
import com.neosavvy.user.dto.companyManagement.UserDTO;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import java.util.List;

public class TestUserCompanyRoleDAO extends BaseSpringAwareDAOTestCase {
    private CompanyDTO testCompany;
    private UserDTO testUser;

    @Before
    public void setupUserCompanyRole() {
        CompanyDTO company = ProjectTestUtil.createTestCompany();
        testCompany = companyDAO.saveCompany(company);

        UserDTO user = ProjectTestUtil.createTestUser();
        testUser = userDAO.saveUser(user);
    }

    @Test
    public void testGetUserCompanyRoleData() {
        UserCompanyRoleDTO userCompanyRole = createTestUserCompanyRole();
        List<UserCompanyRoleDTO> roles = findUserCompanyRoles();
        Assert.assertFalse(roles.isEmpty());
        UserCompanyRoleDTO userCompanyRoleReturned = roles.get(0);
        Assert.assertEquals("ojbect stored is the one returned",
                userCompanyRole.getId(),
                userCompanyRoleReturned.getId());
        Assert.assertEquals("role in the returned object is the same one we inserted in it",
                adminRole,
                userCompanyRoleReturned.getRole());
        Assert.assertEquals("company in the returned object is the same one we inserted in it",
                testCompany,
                userCompanyRoleReturned.getCompany());        
    }

    @Test
    public void testFindUserCompanyRoleById() {
        Assert.assertEquals("Num of rows is equal to 0", 0, countRowsInTable("USER_COMPANY_ROLE"));
        UserCompanyRoleDTO userCompanyRole = createTestUserCompanyRole();
        Assert.assertEquals("Num of rows is equal to 1", 1, countRowsInTable("USER_COMPANY_ROLE"));


        UserCompanyRoleDTO userCompanyRoleFound = userCompanyRoleDAO.findUserCompanyRoleById(userCompanyRole.getId());
        Assert.assertNotNull("User object was found by id " + adminRole.getId(), userCompanyRoleFound);
    }

    @Test
    public void testFindUserCompanyRoleByRoleId() {
        Assert.assertEquals("Num of rows is equal to 0", 0, countRowsInTable("USER_COMPANY_ROLE"));
        createTestUserCompanyRole();
        Assert.assertEquals("Num of rows is equal to 1", 1, countRowsInTable("USER_COMPANY_ROLE"));

        UserCompanyRoleDTO userCompanyRole = new UserCompanyRoleDTO();
        userCompanyRole.setRole(adminRole);
        UserCompanyRoleDTO userCompanyRoleFound = userCompanyRoleDAO.findUserCompanyRoles(userCompanyRole).get(0);

        Assert.assertEquals("UserCompanyRole object was found by id ",
                adminRole.getId(),
                userCompanyRoleFound.getRole().getId());
    }

    @Test
    public void testFindUserCompanyRoleByUserId() {
        UserCompanyRoleDTO userCompanyRole = createTestUserCompanyRole();
        UserDTO altUser = ProjectTestUtil.createAltTestUser();
        altUser = userDAO.saveUser(altUser);
        UserCompanyRoleDTO altUserCompanyRole = createTestUserCompanyRole(adminRole, testCompany, altUser);
        userCompanyRoleDAO.saveUserCompanyRole(altUserCompanyRole);

        int numRows = countRowsInTable("USER_COMPANY_ROLE");

        Assert.assertEquals("Num of rows is equal to 1", 2, numRows);
        UserCompanyRoleDTO filter = new UserCompanyRoleDTO();
        filter.setUser(testUser);
        List<UserCompanyRoleDTO> userCompanyRolesFound = userCompanyRoleDAO.findUserCompanyRoles(filter);

        Assert.assertEquals("found only the one usercompany role that we saved and searched for ",
                1,
                userCompanyRolesFound.size());
        Assert.assertEquals("UserCompanyRole object was found by id ",
                testUser.getId(),
                userCompanyRolesFound.get(0).getUser().getId());
    }

    @Test
    public void testFindUserCompanyRoleByCompanyId() {
        UserCompanyRoleDTO userCompanyRole = createTestUserCompanyRole();
        CompanyDTO altCompany = ProjectTestUtil.createAltTestCompany();
        companyDAO.saveCompany(altCompany);
        UserDTO altUser = ProjectTestUtil.createAltTestUser();
        userDAO.saveUser(altUser);
        UserCompanyRoleDTO altUserCompanyRole = createTestUserCompanyRole(adminRole, altCompany, altUser);
        userCompanyRoleDAO.saveUserCompanyRole(altUserCompanyRole);

        int numRows = countRowsInTable("USER_COMPANY_ROLE");

        Assert.assertEquals("Num of rows is equal to 1", 2, numRows);

        UserCompanyRoleDTO filter = new UserCompanyRoleDTO();
        filter.setCompany(testCompany);
        List<UserCompanyRoleDTO> userCompanyRolesFound = userCompanyRoleDAO.findUserCompanyRoles(filter);

        Assert.assertEquals("found only the one usercompany role that we saved and searched for ",
                1,
                userCompanyRolesFound.size());
        Assert.assertEquals("UserCompanyRole object was found by id ",
                testCompany.getId(),
                userCompanyRolesFound.get(0).getCompany().getId());
    }

    @Test
    public void testFindUserCompanyRoleByAllThree() {
        UserCompanyRoleDTO userCompanyRole = createTestUserCompanyRole();
        CompanyDTO altCompany = ProjectTestUtil.createAltTestCompany();
        companyDAO.saveCompany(altCompany);
        UserDTO altUser = ProjectTestUtil.createAltTestUser();
        userDAO.saveUser(altUser);
        UserCompanyRoleDTO altUserCompanyRole = createTestUserCompanyRole(adminRole, altCompany, altUser);
        userCompanyRoleDAO.saveUserCompanyRole(altUserCompanyRole);

        int numRows = countRowsInTable("USER_COMPANY_ROLE");

        Assert.assertEquals("Num of rows is equal to 1", 2, numRows);

        List<UserCompanyRoleDTO> userCompanyRolesFound = userCompanyRoleDAO.findUserCompanyRoles(userCompanyRole);

        Assert.assertEquals("found only the one usercompany role that we saved and searched for ",
                1,
                userCompanyRolesFound.size());
        Assert.assertEquals("UserCompanyRole object was found by id ",
                testCompany.getId(),
                userCompanyRolesFound.get(0).getCompany().getId());
    }

    @Test
    public void testDeleteUserCompanyRole() {
        cleanupTables();
        UserCompanyRoleDTO userCompanyRole = createTestUserCompanyRole();

        int numRows = countRowsInTable("USER_COMPANY_ROLE");

        Assert.assertEquals("Num of rows is equal to 1", 1, numRows);

        userCompanyRoleDAO.deleteUserCompanyRole(userCompanyRole);

        numRows = countRowsInTable("USER_COMPANY_ROLE");
        Assert.assertEquals(0,numRows);
    }

    private List<UserCompanyRoleDTO> findUserCompanyRoles() {
        CriteriaBuilder builder = getEntityManager().getCriteriaBuilder();
        CriteriaQuery query = builder.createQuery(UserCompanyRoleDTO.class);
        query.from(UserCompanyRoleDTO.class);
        return getEntityManager().createQuery(query).getResultList();
    }

    private UserCompanyRoleDTO createTestUserCompanyRole() {

        UserCompanyRoleDTO userCompanyRole = createTestUserCompanyRole(adminRole, testCompany, testUser);
        userCompanyRoleDAO.saveUserCompanyRole(userCompanyRole);

        return userCompanyRole;
    }
}
