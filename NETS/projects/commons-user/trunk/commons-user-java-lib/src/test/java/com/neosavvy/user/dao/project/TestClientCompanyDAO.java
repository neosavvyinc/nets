package com.neosavvy.user.dao.project;

import com.neosavvy.user.dto.companyManagement.CompanyDTO;
import com.neosavvy.user.dto.project.ClientCompany;
import com.neosavvy.user.dto.project.ClientUserContact;
import com.neosavvy.user.util.ProjectTestUtil;
import org.junit.Assert;
import org.junit.Test;
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
 * Time: 3:55:53 AM
 */
public class TestClientCompanyDAO extends BaseProjectManagementDAOTest {

    @Test
    public void testSaveClientCompany() {
        saveAndAssertTestCompany();
    }

    private ClientCompany saveAndAssertTestCompany() {
        ClientCompany company = ProjectTestUtil.createTestClientCompany();
        ClientUserContact contact = ProjectTestUtil.createTestClientContact();
        clientUserContactDAO.saveUser(contact);
        company.setClientContact(contact);
        CompanyDTO parentCompany = ProjectTestUtil.createTestCompany();
        companyDAO.saveCompany(parentCompany);
        company.setParentCompany(parentCompany);
        
        clientCompanyDAO.saveCompany(company);
        int rows = countRowsInTable("CLIENT_COMPANY");
        Assert.assertEquals(rows,1);
        return company;
    }

    @Test
    public void testDeleteClientCompany() {
        cleanupTables();
        ClientCompany company = saveAndAssertTestCompany();

        clientCompanyDAO.delete(company);

        int rows = countRowsInTable("CLIENT_COMPANY");
        Assert.assertEquals(rows,0);
    }

    @Test
    public void testUpdateClientCompany() {
        cleanupTables();
        ClientCompany company = saveAndAssertTestCompany();

        company.setCompanyName("Neosavvy LLC");
        long id = company.getId();


        clientCompanyDAO.saveCompany(company);

        Assert.assertEquals("Ids should be the same before and after the update", id, (long) company.getId());
        Assert.assertEquals("Name should now be Neosavvy LLC","Neosavvy LLC", company.getCompanyName());
    }

}
