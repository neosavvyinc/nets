package com.neosavvy.user.util;

import com.neosavvy.user.dto.companyManagement.CompanyDTO;
import com.neosavvy.user.dto.companyManagement.RoleDTO;
import com.neosavvy.user.dto.companyManagement.UserDTO;
import com.neosavvy.user.dto.companyManagement.UserInviteDTO;
import com.neosavvy.user.dto.project.ClientCompany;
import com.neosavvy.user.dto.project.ClientUserContact;
import com.neosavvy.user.dto.project.Project;
import org.springframework.jdbc.core.simple.SimpleJdbcTemplate;

import java.util.Date;
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

    public static UserDTO createTestUser() {
        UserDTO user = new UserDTO();
        user.setFirstName("William");
        user.setMiddleName("Adam");
        user.setLastName("Parrish");
        user.setUsername("aparrish");
        user.setPassword("testPassword");
        user.setEmailAddress("aparrish1@neosavvy.com");
        return user;
    }

    public static UserDTO createEmailableTestUser() {
        UserDTO user = createTestUser();
        user.setEmailAddress("aparrish@neosavvy.com");
        return user;
    }

    public static UserDTO createAltTestUser() {
        UserDTO user = new UserDTO();
        user.setFirstName("Tommy");
        user.setLastName("Odom");
        user.setUsername("todom");
        user.setPassword("test");
        user.setEmailAddress("todom@neosavvy.com");
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

    public static RoleDTO createTestRole() {
        RoleDTO role = new RoleDTO();
        role.setShortName("ROLE_ADMIN");
        role.setLongName("Administrator");
        return role;
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
        return invite;
    }

    public static RoleDTO createEmployeeTestRole() {
        RoleDTO role = new RoleDTO();
        role.setShortName("ROLE_EMPLOYEE");
        role.setLongName("Employee");
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

}
