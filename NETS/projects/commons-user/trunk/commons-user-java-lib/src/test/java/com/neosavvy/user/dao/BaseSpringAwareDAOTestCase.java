package com.neosavvy.user.dao;

import com.neosavvy.user.BaseSpringAwareTestCase;
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
		"classpath:applicationContext.xml"
        })
public abstract class BaseSpringAwareDAOTestCase extends BaseSpringAwareTestCase {

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

    protected RoleDTO createAltTestRole() {
        RoleDTO role = new RoleDTO();
        role.setShortName("ROLE_USER");
        role.setLongName("User Role");
        return role;
    }

    protected UserInviteDTO createTestUserInvite(){
        UserInviteDTO userInvite = new UserInviteDTO();
        userInvite.setFirstName("William");
        userInvite.setMiddleName("Adam");
        userInvite.setLastName("Parrish");
        userInvite.setEmailAddress("aparrish@neosavvy.com");
        return userInvite;
    }
    
    protected UserInviteDTO createAltTestUserInvite(){
        UserInviteDTO userInvite = new UserInviteDTO();
        userInvite.setFirstName("Lance");
        userInvite.setMiddleName("B");
        userInvite.setLastName("Gleason");
        userInvite.setEmailAddress("lg@neosavvy.com");
        return userInvite;
    }

    protected void assertSearchCriteriaResults(List itemsFound,int numRows) {
        Assert.assertNotNull("Search results were null", itemsFound);
        Assert.assertEquals("Size of returned results should have been " + numRows, numRows,itemsFound.size());
    }

    protected void cleanupTables() {
        deleteFromTables("USER_COMPANY_ROLE");
        deleteFromTables("ROLE");
        deleteFromTables("COMPANY");
        deleteFromTables("USER");
        deleteFromTables("USER_INVITE");
        deleteFromTables("NUM_EMPLOYEES_RANGE");

    }
}
