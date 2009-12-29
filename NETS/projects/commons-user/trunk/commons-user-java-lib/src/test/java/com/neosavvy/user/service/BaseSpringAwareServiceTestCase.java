package com.neosavvy.user.service;

import com.neosavvy.user.BaseSpringAwareTestCase;
import org.springframework.security.providers.UsernamePasswordAuthenticationToken;
import org.springframework.test.context.junit4.AbstractTransactionalJUnit4SpringContextTests;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.BeanFactoryUtils;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.security.context.SecurityContextHolder;
import org.junit.Before;
import com.neosavvy.user.dao.*;
import com.neosavvy.user.dto.*;

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
    @Autowired
    protected RoleService roleService;
    @Autowired
    protected NumEmployeesRangeService numEmployeesRangeService;

    @Before
    public void loginTestUser() {
       SecurityContextHolder.getContext().setAuthentication(new UsernamePasswordAuthenticationToken("admin", "admin"));
    }

    //todo:  refactor this to something common for dao and Service tests

    protected UserInviteDTO createTestInvite() {
        UserInviteDTO invite = new UserInviteDTO();

        invite.setFirstName("Adam");
        invite.setLastName("Parrish");
        invite.setEmailAddress("aparrish@neosavvy.com");

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
    }
}
