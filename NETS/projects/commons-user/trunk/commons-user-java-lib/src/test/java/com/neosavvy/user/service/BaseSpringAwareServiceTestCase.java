package com.neosavvy.user.service;

import com.neosavvy.user.BaseSpringAwareTestCase;
import com.neosavvy.user.dto.companyManagement.RoleDTO;
import com.neosavvy.user.dto.companyManagement.UserInviteDTO;
import org.springframework.security.providers.UsernamePasswordAuthenticationToken;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.context.SecurityContextHolder;
import org.junit.Before;

/**
 * @author lgleason
 * todo: refactor this and the other base service out for common classes
 */
@ContextConfiguration(locations = {
		"classpath:applicationContext.xml",
        "classpath:testSecurityContext.xml"
        })
public abstract class BaseSpringAwareServiceTestCase extends BaseSpringAwareTestCase {

    @Autowired
    protected UserService userService;
    @Autowired
    protected CompanyService companyService;

    @Before
    public void loginTestUser() {
       SecurityContextHolder.getContext().setAuthentication(new UsernamePasswordAuthenticationToken("admin", "admin"));
    }
    
    protected UserInviteDTO createTestInvite() {
        UserInviteDTO invite = new UserInviteDTO();

        invite.setFirstName("Adam");
        invite.setLastName("Parrish");
        invite.setEmailAddress("aparrish1@neosavvy.com");

        return invite;
    }

    protected RoleDTO createEmployeeTestRole() {
        RoleDTO role = new RoleDTO();
        role.setShortName("ROLE_EMPLOYEE");
        role.setLongName("Employee");
        return role;
    }

    protected void cleanDatabase() {
        deleteFromTables("USER_COMPANY_ROLE");
        deleteFromTables("USER");
        deleteFromTables("ROLE");
        deleteFromTables("USER_INVITE");
        deleteFromTables("COMPANY");
        
    }
}
