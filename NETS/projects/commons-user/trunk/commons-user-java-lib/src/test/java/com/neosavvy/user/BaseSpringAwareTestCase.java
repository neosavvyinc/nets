package com.neosavvy.user;

import com.neosavvy.user.dao.*;
import com.neosavvy.user.dto.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.AbstractTransactionalJUnit4SpringContextTests;

/**
 * Created by IntelliJ IDEA.
 * User: lgleason
 * Date: Dec 29, 2009
 * Time: 4:45:35 PM
 * To change this template use File | Settings | File Templates.
 */
public abstract class BaseSpringAwareTestCase extends AbstractTransactionalJUnit4SpringContextTests {
    @Autowired
    protected CompanyDAO companyDAO;
    @Autowired
    protected UserDAO userDAO;
    @Autowired
    protected RoleDAO roleDAO;
    @Autowired
    protected UserInviteDAO userInviteDAO;
    @Autowired
    protected NumEmployeesRangeDAO numEmployeesRangeDAO;
    @Autowired
    protected UserCompanyRoleDAO userCompanyRoleDAO;

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

    protected UserDTO createAltTestUser() {
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

    protected NumEmployeesRangeDTO createTestRange(){
        NumEmployeesRangeDTO test_range = new NumEmployeesRangeDTO();
        test_range.setRangeDescription("1-10");
        test_range.setRangeFrom(1);
        test_range.setRangeTo(10);
        return test_range;
    }

    protected RoleDTO createTestRole() {
        RoleDTO role = new RoleDTO();
        role.setShortName("ROLE_ADMIN");
        role.setLongName("Administrator");
        return role;
    }

    protected UserCompanyRoleDTO createTestUserCompanyRole(RoleDTO role, CompanyDTO company, UserDTO user){
        UserCompanyRoleDTO testUserCompanyRole = new UserCompanyRoleDTO();
        if(role != null)
            testUserCompanyRole.setRole(role);
        if(company != null)
            testUserCompanyRole.setCompany(company);
        if(user != null)
            testUserCompanyRole.setUser(user);


        return testUserCompanyRole;
    }
}
