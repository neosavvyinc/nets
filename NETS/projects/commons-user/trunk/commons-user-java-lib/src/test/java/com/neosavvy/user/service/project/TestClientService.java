package com.neosavvy.user.service.project;

import com.neosavvy.user.dto.companyManagement.CompanyDTO;
import com.neosavvy.user.dto.companyManagement.UserDTO;
import com.neosavvy.user.dto.project.ClientCompany;
import com.neosavvy.user.dto.project.ClientUserContact;
import com.neosavvy.user.service.exception.ClientServiceException;
import com.neosavvy.user.util.ProjectTestUtil;
import org.junit.Assert;
import org.junit.Test;
import org.springframework.test.annotation.ExpectedException;

import java.util.List;
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
 * Time: 1:22:36 PM
 */
public class TestClientService extends BaseProjectManagementServiceTest {

    @Test
    @ExpectedException( value = ClientServiceException.class )
    public void testSaveClientForCompanyWithNoParentCompany() {

        ClientCompany clientCompany = ProjectTestUtil.createTestClientCompany();
        ClientUserContact clientContact = ProjectTestUtil.createTestClientContact();

        clientService.saveClientForCompany(clientCompany, clientContact);

    }

    @Test
    @ExpectedException( value = ClientServiceException.class )
    public void testSaveClientForCompanyWithClientCompany() {

        ClientUserContact clientContact = ProjectTestUtil.createTestClientContact();

        clientService.saveClientForCompany(null, clientContact);

    }

    @Test
    @ExpectedException( value = ClientServiceException.class )
    public void testSaveClientForCompanyWithClientContact() {

        ClientCompany clientCompany = ProjectTestUtil.createTestClientCompany();

        clientService.saveClientForCompany(clientCompany, null);

    }

    @Test
    public void testSaveClientForCompany() {
        cleanDatabase();

        // Admin role required to add a company
        roleDAO.saveRole(ProjectTestUtil.createTestRole());

        // add a company so that the parent relationship can be established
        saveTestCompanyForParent();

        int numRowsInClientCompanyTable = countRowsInTable("CLIENT_COMPANY");
        int numRowsInClientUserContactTable = countRowsInTable("CLIENT_USER_CONTACT");

        Assert.assertEquals("Client Company table should have one row", 1, numRowsInClientCompanyTable);
        Assert.assertEquals("Client User Contact table should have one row", 1, numRowsInClientUserContactTable);

    }


    @Test
    public void testSaveTwoClientsAndTestFindForCompany() {

        cleanDatabase();

        // Admin role required to add a company
        roleDAO.saveRole(ProjectTestUtil.createTestRole());

        // add a company so that the parent relationship can be established
        CompanyDTO parentCompany = saveTestCompanyForParent();
        saveAltTestCompanyForParent(parentCompany);


        List<ClientCompany> clientCompanies = clientService.findClientsForParentCompany(parentCompany);

        Assert.assertNotNull(clientCompanies);
        Assert.assertEquals("There should be two client companies", clientCompanies.size(), 2);
    }

    private CompanyDTO saveTestCompanyForParent() {
        CompanyDTO companyDTO = ProjectTestUtil.createParentCompany();
        UserDTO companyUser = ProjectTestUtil.createTestUser();
        companyService.addCompany(companyDTO, companyUser);


        ClientCompany clientCompany = ProjectTestUtil.createTestClientCompany();
        ClientUserContact clientContact = ProjectTestUtil.createTestClientContact();
        clientCompany.setParentCompany(companyDTO);

        clientService.saveClientForCompany(clientCompany, clientContact);
        return companyDTO;
    }

    private void saveAltTestCompanyForParent(CompanyDTO parentCompany) {
        ClientCompany clientCompany = ProjectTestUtil.createTestAltClientCompany();
        ClientUserContact clientContact = ProjectTestUtil.createTestAltClientContact();
        clientCompany.setParentCompany(parentCompany);

        clientService.saveClientForCompany(clientCompany, clientContact);
    }


}
