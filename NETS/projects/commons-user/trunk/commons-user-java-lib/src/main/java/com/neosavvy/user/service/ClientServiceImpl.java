package com.neosavvy.user.service;

import com.neosavvy.user.dao.project.ClientCompanyDAO;
import com.neosavvy.user.dao.project.ClientUserContactDAO;
import com.neosavvy.user.dto.companyManagement.CompanyDTO;
import com.neosavvy.user.dto.project.ClientCompany;
import com.neosavvy.user.dto.project.ClientUserContact;
import com.neosavvy.user.service.exception.ClientServiceException;
import com.neosavvy.user.service.exception.CompanyServiceException;
import org.springframework.dao.DataAccessException;
import org.springframework.transaction.annotation.Transactional;

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
 * Time: 1:11:43 PM
 */
@Transactional
public class ClientServiceImpl implements ClientService {

    private ClientCompanyDAO clientCompanyDAO;

    private ClientUserContactDAO clientUserContactDAO;

    public List<ClientCompany> findClientsForParentCompany(CompanyDTO company) {

        if( company == null ) {
            throw new ClientServiceException("Cannot find clients for a company without specifying a parent company");
        }

        ClientCompany clientCompanyExample = new ClientCompany();
        clientCompanyExample.setParentCompany(company);

        return clientCompanyDAO.findCompanies(clientCompanyExample);
    }

    public void saveClientForCompany(ClientCompany client, ClientUserContact contact) {
        if( client == null ) {
            throw new ClientServiceException("ClientCompany must be provided to save it");
        }

        if( client.getParentCompany() == null ) {
            throw new ClientServiceException("ClientCompany must be associated with a parentCompany to establish client relationship");
        }

        if( contact == null ) {
            throw new ClientServiceException("ClientUserContact must be provided to associate a point of contact with a company");
        }

        try {
            clientUserContactDAO.saveUser(contact);
        } catch (DataAccessException e) {
            throw new ClientServiceException("There was an error saving the client contact",e);
        }

        try {
            client.setClientContact(contact);
            clientCompanyDAO.saveCompany(client);
        } catch (DataAccessException e) {
            throw new ClientServiceException("There was an error saving the client company",e);
        }
    }

    public ClientCompanyDAO getClientCompanyDAO() {
        return clientCompanyDAO;
    }

    public void setClientCompanyDAO(ClientCompanyDAO clientCompanyDAO) {
        this.clientCompanyDAO = clientCompanyDAO;
    }

    public ClientUserContactDAO getClientUserContactDAO() {
        return clientUserContactDAO;
    }

    public void setClientUserContactDAO(ClientUserContactDAO clientUserContactDAO) {
        this.clientUserContactDAO = clientUserContactDAO;
    }
}
