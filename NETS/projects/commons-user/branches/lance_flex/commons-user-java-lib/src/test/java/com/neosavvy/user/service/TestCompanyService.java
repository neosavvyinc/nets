package com.neosavvy.user.service;

import org.junit.Test;
import junit.framework.Assert;
import com.neosavvy.user.dto.CompanyDTO;
import com.neosavvy.user.dto.UserDTO;
import com.neosavvy.user.dto.RoleDTO;
import com.neosavvy.user.dto.UserCompanyRoleDTO;
import com.neosavvy.user.service.exception.CompanyServiceException;

/**
 * @author lgleason
 */
public class TestCompanyService extends BaseSpringAwareServiceTestCase{
    @Test
    public void testGetCompanies() throws Exception{
        cleanDatabase();
        companyDAO.saveCompany(createTestCompany());
        Assert.assertFalse(companyService.getCompanies().isEmpty());
    }

    @Test
    public void testFindCompanyById() throws Exception{
        cleanDatabase();
        CompanyDTO testCompany = createTestCompany();
        companyDAO.saveCompany(testCompany);
        Assert.assertFalse(companyService.getCompanies().isEmpty());

        Assert.assertNotNull("findCompanyById should return the company that we just added when we search by the id for it",
                companyService.findCompanyById(testCompany.getId()));
    }

    @Test
    public void testFindCompanies(){
        cleanDatabase();
        CompanyDTO testCompany = createTestCompany();
        companyDAO.saveCompany(testCompany);
        Assert.assertFalse(companyService.getCompanies().isEmpty());
        Assert.assertTrue(companyService.findCompanies(testCompany).contains(testCompany));
    }

    @Test
    public void testAddCompany(){
        cleanDatabase();
        CompanyDTO testCompany = createTestCompany();
        UserDTO testUser = createTestUser();
        RoleDTO testRole = createTestRole();

        roleDAO.saveRole(testRole);

        companyService.addCompany(testCompany, testUser);
        int numUserCompanyRoles = countRowsInTable("USER_COMPANY_ROLE");
        Assert.assertEquals("a row was added to the USER_COMPANY_ROLE table",
                1,
                numUserCompanyRoles);

        CompanyDTO foundCompany = companyService.findCompanyById(testCompany.getId());
        UserCompanyRoleDTO foundUserCompanyRole = (UserCompanyRoleDTO) foundCompany.getUserCompanyRoles().toArray()[0];
        Assert.assertEquals("role for found company is the same as what we saved",
                testRole.getId(),
                foundUserCompanyRole.getRole().getId());
        Assert.assertEquals("user for found company is the same as what we saved",
                testUser.getId(),
                foundUserCompanyRole.getUser().getId());
    }

    @Test(expected= CompanyServiceException.class)
    public void testAddCompanyException(){
        //this expects to throw an exception
        cleanDatabase();
        CompanyDTO testCompany = createTestCompany();
        UserDTO testUser = createTestUser();

        companyService.addCompany(testCompany, testUser);
    }
}
