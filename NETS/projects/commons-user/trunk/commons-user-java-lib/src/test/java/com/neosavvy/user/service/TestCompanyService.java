package com.neosavvy.user.service;

import org.junit.Test;
import junit.framework.Assert;
import com.neosavvy.user.dto.CompanyDTO;

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
}
