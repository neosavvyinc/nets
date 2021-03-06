package com.neosavvy.user.dao;

import org.junit.Before;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.AbstractJUnit4SpringContextTests;
import org.springframework.test.context.junit4.AbstractTransactionalJUnit4SpringContextTests;
import org.springframework.beans.factory.annotation.Autowired;
import org.junit.Assert;
import com.neosavvy.user.dto.*;
import com.neosavvy.user.dao.CompanyDAO;
import com.neosavvy.user.dao.UserDAO;
import com.neosavvy.user.dao.RoleDAO;

import java.util.List;

@ContextConfiguration(locations = {
		"classpath:testApplicationContext.xml"
        })
public abstract class BaseSpringAwareDAOTestCase extends AbstractTransactionalJUnit4SpringContextTests {
    @Autowired
	protected CompanyDAO companyDAO;
    @Autowired
    protected UserDAO userDAO;
    @Autowired
    protected RoleDAO roleDAO;
    @Autowired
    protected NumEmployeesRangeDAO numEmployeesRangeDAO;
    @Autowired
    protected UserCompanyRoleDAO userCompanyRoleDAO;


    protected UserDTO createTestUser(){
        UserDTO user = new UserDTO();
        user.setFirstName("William");
        user.setMiddleName("Adam");
        user.setLastName("Parrish");
        user.setUsername("aparrish");
        user.setPassword("testPassword");
        user.setEmailAddress("aparrish@neosavvy.com");
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

    protected CompanyDTO createAltTestCompany() {
        CompanyDTO company = new CompanyDTO();
        company.setCompanyName("Zymol Enterprises");
        company.setAddressOne("address one one");
        company.setAddressTwo("address two two");
        company.setCity("Wellsville");
        company.setState("NY");
        company.setPostalCode("14895");
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

    protected RoleDTO createAltTestRole() {
        RoleDTO role = new RoleDTO();
        role.setShortName("ROLE_USER");
        role.setLongName("User Role");
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

    protected void assertSearchCriteriaResults(List itemsFound,int numRows) {
        Assert.assertNotNull("Search results were null", itemsFound);
        Assert.assertEquals("Size of returned results should have been " + numRows, numRows,itemsFound.size());
    }

    protected void cleanupTables() {
        deleteFromTables("USER_ROLE");
        deleteFromTables("ROLE");
        deleteFromTables("USER_COMPANY");
        deleteFromTables("COMPANY");
        deleteFromTables("USER");
        deleteFromTables("NUM_EMPLOYEES_RANGE");
        deleteFromTables("USER_COMPANY_ROLE");
    }
}
