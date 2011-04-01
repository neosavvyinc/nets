package com.neosavvy.user.service.project;

import com.neosavvy.user.dao.BaseSpringAwareDAOTestCase;
import com.neosavvy.user.dao.project.ClientCompanyDAO;
import com.neosavvy.user.dao.project.ClientUserContactDAO;
import com.neosavvy.user.dto.companyManagement.CompanyDTO;
import com.neosavvy.user.dto.companyManagement.UserDTO;
import com.neosavvy.user.dto.companyManagement.UserInviteDTO;
import com.neosavvy.user.dto.project.ClientCompany;
import com.neosavvy.user.dto.project.ClientUserContact;
import com.neosavvy.user.service.BaseSpringAwareServiceTestCase;
import com.neosavvy.user.service.ClientService;
import com.neosavvy.user.service.CompanyService;
import com.neosavvy.user.service.ProjectService;
import com.neosavvy.user.util.ProjectTestUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.simple.ParameterizedRowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;
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
 * Date: Jan 5, 2010
 * Time: 4:33:48 PM
 */
public abstract class BaseProjectManagementServiceTest extends BaseSpringAwareServiceTestCase {


    @Autowired
    protected ProjectService projectService;

    @Autowired
    protected ClientService clientService;

    @Autowired
    protected CompanyService companyService;

    public ClientService getClientService() {
        return clientService;
    }

    public void setClientService(ClientService clientService) {
        this.clientService = clientService;
    }

    public CompanyService getCompanyService() {
        return companyService;
    }

    public void setCompanyService(CompanyService companyService) {
        this.companyService = companyService;
    }

    public ProjectService getProjectService() {
        return projectService;
    }

    public void setProjectService(ProjectService projectService) {
        this.projectService = projectService;
    }

    protected CompanyDTO saveTestCompanyForParent() {
        ClientCompany clientCompany = ProjectTestUtil.createTestClientCompany();
        ClientUserContact clientContact = ProjectTestUtil.createTestClientContact();
        clientCompany.setParentCompany(adminCompany);

        clientService.saveClientForCompany(adminCompany, clientCompany, clientContact);
        return adminCompany;
    }

    protected void saveAltTestCompanyForParent(CompanyDTO parentCompany) {
        ClientCompany clientCompany = ProjectTestUtil.createTestAltClientCompany();
        ClientUserContact clientContact = ProjectTestUtil.createTestAltClientContact();
        clientCompany.setParentCompany(parentCompany);

        clientService.saveClientForCompany(adminCompany, clientCompany, clientContact);
    }
    

    protected void addUserToCompany(CompanyDTO parent, UserDTO user) {
        UserInviteDTO userToInvite = new UserInviteDTO();
        userToInvite.setFirstName(user.getFirstName());
        userToInvite.setLastName(user.getLastName());
        userToInvite.setEmailAddress(user.getEmailAddress());
        companyService.inviteUsers(parent,userToInvite);

        // Populate a user with the confirmation token and call addEmployeToCompany
        user.setRegistrationToken(userToInvite.getRegistrationToken());

        companyService.addEmployeeToCompany(user);
    }
}