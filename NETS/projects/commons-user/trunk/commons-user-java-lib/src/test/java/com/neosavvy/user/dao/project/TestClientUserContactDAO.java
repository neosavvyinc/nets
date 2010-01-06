package com.neosavvy.user.dao.project;

import com.neosavvy.user.dto.companyManagement.UserDTO;
import com.neosavvy.user.dto.project.ClientUserContact;
import junit.framework.Assert;
import org.junit.Test;
import org.springframework.transaction.annotation.Transactional;
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
 * Time: 4:34:54 PM
 */
@Transactional
public class TestClientUserContactDAO extends BaseProjectManagementDAOTest {


    @Test
    public void testSave() {
        cleanupTables();
        ClientUserContact contact = createTestClientContact();
        clientUserContactDAO.saveUser(contact);
		Assert.assertTrue((int)contact.getId() > 0);
    }

    @Test
    public void testDelete() {

        cleanupTables();
        int numRows = countRowsInTable("CLIENT_USER_CONTACT");
        Assert.assertEquals(numRows, 0);

        ClientUserContact clientContact = createTestClientContact();
        clientUserContactDAO.saveUser(clientContact);

        numRows = countRowsInTable("CLIENT_USER_CONTACT");
        Assert.assertEquals(numRows, 1);

        clientUserContactDAO.deleteUser(clientContact);

        numRows = countRowsInTable("CLIENT_USER_CONTACT");
        Assert.assertEquals(0,numRows);

    }

    @Test
    public void testUpdate() {

        cleanupTables();
        ClientUserContact contact = createTestClientContact();
        clientUserContactDAO.saveUser(contact);
		Assert.assertTrue((int)contact.getId() > 0);
        int numRows = countRowsInTable("CLIENT_USER_CONTACT");
        Assert.assertEquals(numRows, 1);
        contact.setFirstName("CHANGEDNAME");
        clientUserContactDAO.saveUser(contact);
        numRows = countRowsInTable("CLIENT_USER_CONTACT");
        Assert.assertEquals(numRows,1);


    }

}
