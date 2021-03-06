package com.neosavvy.user.service;

import com.neosavvy.user.dto.companyManagement.CompanyDTO;
import com.neosavvy.user.dto.project.ClientCompany;
import com.neosavvy.user.dto.project.ClientUserContact;
import org.springframework.security.access.annotation.Secured;

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
 * Time: 1:04:18 PM
 */
public interface ClientService {

    @Secured({"ROLE_ADMIN", "AFTER_ACL_COLLECTION_READ"})
    public List<ClientCompany> findClientsForParentCompany(CompanyDTO company);

    @Secured({"ROLE_ADMIN", "ACL_OBJECT_WRITE"})
    public void saveClientForCompany(CompanyDTO parentCompany, ClientCompany client, ClientUserContact contact);

}
