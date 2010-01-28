package com.neosavvy.user.service.companyManagement;

import org.junit.Before;
import org.junit.Test;
import org.springframework.security.AccessDeniedException;

/**
 * Created by IntelliJ IDEA.
 * User: tommyodom
 * Date: Jan 19, 2010
 * Time: 7:04:38 PM
 * To change this template use File | Settings | File Templates.
 */
public class TestEmployeeCompanyService extends TestCompanyService {
    @Before
    public void setupEmployee() {
        setupAsEmployeeUser();
    }

    @Test(expected = AccessDeniedException.class)
    public void testUnauthorizedFindUsers() {
        companyService.findActiveUsersForCompany(adminCompany);
    }

    @Test(expected = AccessDeniedException.class)
    public void testUnauthorizedFindCompany() {
        companyService.findCompanyById(adminCompany.getId());
    }

    @Test(expected = AccessDeniedException.class)
    public void testUnauthorizedFindCompanies() {
        companyService.findCompanies(adminCompany);
    }
}
