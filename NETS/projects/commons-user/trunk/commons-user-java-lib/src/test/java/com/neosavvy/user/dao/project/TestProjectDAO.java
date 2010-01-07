package com.neosavvy.user.dao.project;

import com.neosavvy.user.dto.companyManagement.CompanyDTO;
import com.neosavvy.user.dto.project.ClientCompany;
import com.neosavvy.user.dto.project.Project;
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
 * Date: Jan 7, 2010
 * Time: 3:30:52 PM
 */
public class TestProjectDAO extends BaseProjectManagementDAOTest {

    @Test
    public void testSave() {
        cleanupTables();
        CompanyDTO testCompany = ProjectTestUtil.createTestCompany();
        ClientCompany testClientCompany = ProjectTestUtil.createTestClientCompany();
        companyDAO.saveCompany(testCompany);
        clientCompanyDAO.saveCompany(testClientCompany);

        Project testProject = ProjectTestUtil.createTestProject1(testCompany, testClientCompany);

        projectDAO.save(testProject);

        int rowsInProjectsTable = countRowsInTable("PROJECT");
        Assert.assertEquals("Should be only one project inserted at this point",1,rowsInProjectsTable);
    }

}
