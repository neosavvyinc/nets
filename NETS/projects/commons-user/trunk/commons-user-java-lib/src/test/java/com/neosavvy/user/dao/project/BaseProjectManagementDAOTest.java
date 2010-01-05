package com.neosavvy.user.dao.project;

import com.neosavvy.user.BaseSpringAwareTestCase;
import com.neosavvy.user.dao.BaseSpringAwareDAOTestCase;
import org.springframework.beans.factory.annotation.Autowired;
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
public abstract class BaseProjectManagementDAOTest extends BaseSpringAwareDAOTestCase {

    @Autowired
    protected ClientUserContactDAO clientUserContactDAO;

    public ClientUserContactDAO getClientUserContactDAO() {
        return clientUserContactDAO;
    }

    public void setClientUserContactDAO(ClientUserContactDAO clientUserContactDAO) {
        this.clientUserContactDAO = clientUserContactDAO;
    }

    @Override
    protected void cleanupTables() {
        super.cleanupTables();
        deleteFromTables("CLIENT_COMPANY");
        deleteFromTables("CLIENT_USER_CONTACT");
    }
}
