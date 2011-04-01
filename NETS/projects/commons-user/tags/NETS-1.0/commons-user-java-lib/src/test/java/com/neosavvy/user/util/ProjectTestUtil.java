package com.neosavvy.user.util;

import com.neosavvy.user.dto.companyManagement.CompanyDTO;
import com.neosavvy.user.dto.companyManagement.RoleDTO;
import com.neosavvy.user.dto.companyManagement.UserDTO;
import com.neosavvy.user.dto.companyManagement.UserInviteDTO;
import com.neosavvy.user.dto.project.*;
import org.springframework.jdbc.core.simple.SimpleJdbcTemplate;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
/*************************************************************************
 *
 * NEOSAVVY CONFIDENTIAL
 * __________________
 *
 *  Copyright 2008 - 2009 Neosavvy Incorporated
 *  All Rights Reserved.
 *
 * NOTICE:  All information contained herein is, and remains
 * the property of Neosavvy Incorporated and its suppliers,
 * if any.  The intellectual and technical concepts contained
 * herein are proprietary to Neosavvy Incorporated
 * and its suppliers and may be covered by U.S. and Foreign Patents,
 * patents in process, and are protected by trade secret or copyright law.
 * Dissemination of this information or reproduction of this material
 * is strictly forbidden unless prior written permission is obtained
 * from Neosavvy Incorporated.
 **************************************************************************/

/**
 * User: adamparrish
 * Date: Jan 6, 2010
 * Time: 1:20:07 PM
 */
public class ProjectTestUtil {

    public static ClientCompany createTestClientCompany() {
        ClientCompany company = new ClientCompany();
        company.setAddressOne("4500 Manor Village Way");
        company.setAddressTwo("Apt 127");
        company.setCity("Raleigh");
        company.setCompanyName("Neosavvy, Inc.");
        company.setCountry("USA");
        company.setPostalCode("27612");
        company.setState("NC");
        return company;
    }

    public static ClientCompany createTestAltClientCompany() {
        ClientCompany company = new ClientCompany();
        company.setAddressOne("4500 Manor Village Way 1");
        company.setAddressTwo("Apt 127 1");
        company.setCity("Raleigh");
        company.setCompanyName("Neosavvy 1, Inc.");
        company.setCountry("USA");
        company.setPostalCode("27612");
        company.setState("NC");
        return company;
    }

    public static ClientUserContact createTestClientContact() {
        ClientUserContact contact = new ClientUserContact();
        contact.setContactPhoneNumber("9197419597");
        contact.setEmailAddress("aparrish1@neosavvy.com");
        contact.setFirstName("William");
        contact.setMiddleName("Adam");
        contact.setLastName("Parrish");
        return contact;
    }

    public static ClientUserContact createTestAltClientContact() {
        ClientUserContact contact = new ClientUserContact();
        contact.setContactPhoneNumber("9197419597");
        contact.setEmailAddress("dana@neosavvy.com");
        contact.setFirstName("Dana");
        contact.setMiddleName("L");
        contact.setLastName("Hamlett");
        return contact;
    }

    public static CompanyDTO createParentCompany() {
        CompanyDTO companyDTO = new CompanyDTO();
        companyDTO.setAddressOne("350 N LaSalle");
        companyDTO.setAddressTwo("Suite 12");
        companyDTO.setCity("Chicago");
        companyDTO.setCompanyName("Roundarch, Inc.");
        companyDTO.setCountry("USA");
        companyDTO.setPostalCode("60610");
        companyDTO.setState("NC");
        return companyDTO;
    }

    public static UserDTO createAdminUser() {
        UserDTO user = new UserDTO();
        user.setUsername("admin");
        user.setFirstName("William");
        user.setMiddleName("Adam");
        user.setLastName("Parrish");
        user.setPassword("admin");
        user.setPasswordReset(false);
        user.setEmailAddress("aparrish1@neosavvy.com");

        return user;
    }

    public static UserDTO createAdmin2User() {
        UserDTO user = new UserDTO();
        user.setUsername("admin2");
        user.setFirstName("William");
        user.setMiddleName("Adam");
        user.setLastName("Parrish");
        user.setPassword("admin2");
        user.setPasswordReset(false);
        user.setEmailAddress("aparrishAdmin2@neosavvy.com");

        return user;
    }

    public static UserDTO createEmployee1User() {
        UserDTO user = new UserDTO();
        user.setUsername("empl1");
        user.setFirstName("William");
        user.setMiddleName("Adam");
        user.setLastName("Parrish");
        user.setPassword("pass1");
        user.setPasswordReset(false);
        user.setEmailAddress("aparrish1@neosavvy.com");

        return user;
    }

    public static UserDTO createEmployee2User() {
        UserDTO user = new UserDTO();
        user.setUsername("empl2");
        user.setFirstName("William");
        user.setMiddleName("Adam");
        user.setLastName("Parrish");
        user.setPassword("pass2");
        user.setPasswordReset(false);
        user.setEmailAddress("aparrish1@neosavvy.com");

        return user;
    }

    public static UserDTO createUnauthenticatedUser() {
        UserDTO user = new UserDTO();
        user.setFirstName("William");
        user.setMiddleName("Adam");
        user.setLastName("Parrish");
        user.setUsername("testUser");
        user.setPassword("testPassword");
        user.setEmailAddress("aparrish1@neosavvy.com");
        return user;
    }

    public static UserDTO createTestUser() {
        UserDTO user = new UserDTO();
        user.setFirstName("William");
        user.setMiddleName("Adam");
        user.setLastName("Parrish");
        user.setUsername("aparrish");
        user.setPassword("testPassword");
        user.setPasswordReset(false);
        user.setEmailAddress("aparrish1@neosavvy.com");
        return user;
    }

    public static UserDTO createEmailableTestUser() {
        UserDTO user = createTestUser();
        user.setEmailAddress("aparrish@neosavvy.com");
        user.setRegistrationToken("0000999933334444");
        return user;
    }

    public static UserDTO createAltTestUser() {
        UserDTO user = new UserDTO();
        user.setFirstName("Tommy");
        user.setLastName("Odom");
        user.setUsername("todom");
        user.setPassword("test");
        user.setPasswordReset(false);
        user.setEmailAddress("todom1@neosavvy.com");
        return user;
    }

    public static UserDTO createAltTestUser2() {
        UserDTO user = new UserDTO();
        user.setFirstName("Dana");
        user.setLastName("Hamlett");
        user.setUsername("dhamlett");
        user.setPassword("test");
        user.setPasswordReset(false);
        user.setEmailAddress("dhamlett1@neosavvy.com");
        return user;
    }

    public static UserDTO createAltTestUser3() {
        UserDTO user = new UserDTO();
        user.setFirstName("Whitney");
        user.setLastName("Odom");
        user.setUsername("wodom");
        user.setPassword("test");
        user.setPasswordReset(false);
        user.setEmailAddress("wodom@neosavvy.com");
        return user;
    }

    public static UserDTO createTestUser3() {
        UserDTO user = new UserDTO();
        user.setFirstName("Tommy");
        user.setLastName("Odom");
        user.setUsername("todom2");
        user.setPassword("testPassword");
        user.setPasswordReset(false);
        user.setEmailAddress("tommy.odom@gmail.com");
        return user;
    }

    public static CompanyDTO createTestCompany() {
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

    public static CompanyDTO createAltTestCompany() {
        CompanyDTO company = new CompanyDTO();
        company.setCompanyName("Widgets, Inc.");
        company.setAddressOne("address one");
        company.setAddressTwo("address two");
        company.setCity("Atlanta");
        company.setState("GA");
        company.setPostalCode("30312");
        company.setCountry("USA");
        return company;
    }

    public static UserInviteDTO createTestInvite() {
        UserInviteDTO invite = new UserInviteDTO();

        invite.setFirstName("Adam");
        invite.setLastName("Parrish");
        invite.setEmailAddress("aparrish1@neosavvy.com");

        return invite;
    }

    public static UserInviteDTO createEmailableTestInvite() {
        UserInviteDTO invite = createTestInvite();
        invite.setEmailAddress("aparrish@neosavvy.com");
        invite.setRegistrationToken("0000333344445555");
        return invite;
    }

    public static RoleDTO createEmployeeTestRole() {
        RoleDTO role = new RoleDTO();
        role.setShortName("ROLE_EMPLOYEE");
        return role;
    }
    
    public static RoleDTO createAdminTestRole() {
        RoleDTO role = new RoleDTO();
        role.setShortName("ROLE_ADMIN");
        return role;
    }
    

    public static UserInviteDTO createTestUserInvite(){
        UserInviteDTO userInvite = new UserInviteDTO();
        userInvite.setFirstName("William");
        userInvite.setMiddleName("Adam");
        userInvite.setLastName("Parrish");
        userInvite.setEmailAddress("aparrish1@neosavvy.com");
        return userInvite;
    }

    public static UserInviteDTO createAltTestUserInvite(){
        UserInviteDTO userInvite = new UserInviteDTO();
        userInvite.setFirstName("Tommy");
        userInvite.setLastName("Odom");
        userInvite.setEmailAddress("todom@neosavvy.com");
        return userInvite;
    }

    public static UserInviteDTO createAnotherTestUserInvite(){
        UserInviteDTO userInvite = new UserInviteDTO();
        userInvite.setFirstName("Dana");
        userInvite.setMiddleName("L");
        userInvite.setLastName("Hamlett");
        userInvite.setEmailAddress("dana@neosavvy.com");
        return userInvite;
    }

    public static Project createTestProject1(CompanyDTO parent, ClientCompany client) {
        Project project = new Project();
        project.setCode("BLX");
        project.setCompany(parent);
        project.setClient(client);
        project.setEndDate(new Date());
        project.setStartDate(new Date());
        project.setName("BuildLinks1");
        return project;
    }
    public static Project createTestProject2(CompanyDTO parent, ClientCompany client) {
        Project project = new Project();
        project.setCode("BLX");
        project.setCompany(parent);
        project.setClient(client);
        project.setEndDate(new Date());
        project.setStartDate(new Date());
        project.setName("BuildLinks1");
        return project;
    }

    public static ExpenseReport createTextExpenseReport1(UserDTO owner, Project project) {
        ExpenseReport report = new ExpenseReport();
        report.setOwner(owner);
        report.setProject(project);
        report.setPurpose("Purpose");
        report.setStartDate(new Date());
        report.setExpenseItems(new ArrayList<ExpenseItem>());
        report.setLocation("Location");
        report.setStatus(ExpenseReportStatus.OPEN);

        return report;
    }

    public static ExpenseItem createTextExpenseItem1(double value, ExpenseItemType type, PaymentMethod method, ProjectType projectType) {
        ExpenseItem item = new ExpenseItem();
        item.setAmount(BigDecimal.valueOf(value).setScale(2, BigDecimal.ROUND_HALF_UP));
        item.setComment("Comment");
        item.setExpenseItemType(type);
        item.setExpenseDate(new Date());
        item.setExpenseItemValues(new HashSet<ExpenseItemValue>());
        item.setPaymentMethod(method);
        item.setProjectType(projectType);
        return item;
    }
}
