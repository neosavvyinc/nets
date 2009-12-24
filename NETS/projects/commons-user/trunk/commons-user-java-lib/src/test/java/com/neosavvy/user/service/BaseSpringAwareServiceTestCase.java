package com.neosavvy.user.service;

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
public abstract class BaseSpringAwareServiceTestCase extends AbstractTransactionalJUnit4SpringContextTests {

    @Autowired
    protected UserService userService;
    @Autowired
    protected UserDAO userDAO;
    @Autowired
    protected CompanyService companyService;
    @Autowired
    protected CompanyDAO companyDAO;
    @Autowired
    protected RoleService roleService;
    @Autowired
    protected RoleDAO roleDAO;
    @Autowired
    protected NumEmployeesRangeDAO numEmployeesRangeDAO;
    @Autowired
    protected NumEmployeesRangeService numEmployeesRangeService;
    @Autowired
    protected UserCompanyRoleDAO userCompanyRoleDao;
    @Autowired
    protected UserInviteDAO userInviteDao;

    @Before
    public void loginTestUser() {
       SecurityContextHolder.getContext().setAuthentication(new UsernamePasswordAuthenticationToken("admin", "admin"));
    }

    //todo:  refactor this to something common for dao and Service tests
    protected UserDTO createTestUser() {
        UserDTO user = new UserDTO();
        user.setFirstName("William");
        user.setMiddleName("Adam");
        user.setLastName("Parrish");
        user.setUsername("aparrish");
        user.setPassword("testPassword");
        user.setEmailAddress("aparrish1@neosavvy.com");
        return user;
    }

    protected UserDTO createAltTestUser(){
        UserDTO user = new UserDTO();
        user.setFirstName("Lance");
        user.setMiddleName("B");
        user.setLastName("Gleason");
        user.setUsername("lgleason");
        user.setPassword("testPassword");
        user.setEmailAddress("lg@neosavvy.com");
        return user;
    }    

    protected CompanyDTO createTestCompany() {
        CompanyDTO company = new CompanyDTO();
        company.setCompanyName("BFD Enterprises");
        company.setAddressOne("address one");
        company.setAddressTwo("address two");
        company.setCity("Atlanta");
        company.setState("GA");
        company.setPostalCode("30312");
        company.setCountry("USA");

        return company;
    }

    protected UserInviteDTO createTestInvite() {
        UserInviteDTO invite = new UserInviteDTO();

        invite.setFirstName("Adam");
        invite.setLastName("Parrish");
        invite.setEmailAddress("aparrish@neosavvy.com");

        return invite;
    }

    protected RoleDTO createTestRole() {
        RoleDTO role = new RoleDTO();
        role.setShortName("ROLE_ADMIN");
        role.setLongName("Administrator");
        return role;
    }

    protected RoleDTO createEmployeeTestRole() {
        RoleDTO role = new RoleDTO();
        role.setShortName("ROLE_EMPLOYEE");
        role.setLongName("Employee");
        return role;
    }

    protected NumEmployeesRangeDTO createTestRange(){
        NumEmployeesRangeDTO test_range = new NumEmployeesRangeDTO();
        test_range.setRangeDescription("1-10");
        test_range.setRangeFrom(1);
        test_range.setRangeTo(10);
        return test_range;
    }

    protected void cleanDatabase() {
        deleteFromTables("USER_COMPANY_ROLE");
        deleteFromTables("USER");
        deleteFromTables("ROLE");
        deleteFromTables("USER_INVITE");
    }
}
