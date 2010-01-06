package com.neosavvy.user.service.project;

import com.neosavvy.user.dao.BaseSpringAwareDAOTestCase;
import com.neosavvy.user.dao.project.ClientCompanyDAO;
import com.neosavvy.user.dao.project.ClientUserContactDAO;
import com.neosavvy.user.dto.project.ClientCompany;
import com.neosavvy.user.dto.project.ClientUserContact;
import com.neosavvy.user.service.BaseSpringAwareServiceTestCase;
import com.neosavvy.user.service.ClientService;
import com.neosavvy.user.service.CompanyService;
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
public abstract class BaseProjectManagementServiceTest extends BaseSpringAwareServiceTestCase {


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
}