package com.neosavvy.user.dao.project;

import com.neosavvy.user.dao.base.BaseCompanyDAOImpl;
import com.neosavvy.user.dto.companyManagement.CompanyDTO;
import com.neosavvy.user.dto.project.ClientCompany;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
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
 * Time: 3:54:29 AM
 */
public class ClientCompanyDAOImpl extends BaseCompanyDAOImpl<ClientCompany> implements ClientCompanyDAO {

    @Override
    protected Class<ClientCompany> getTypeClass() {
        return ClientCompany.class;
    }

    @Override
    protected void addSearchPredicates(ClientCompany company, CriteriaBuilder builder, Root<ClientCompany> root, List<Predicate> searchPredicates) {
        super.addSearchPredicates(company, builder, root, searchPredicates);

        if(company.getParentCompany() != null) {
            searchPredicates.add(builder.equal(root.get("parentCompany"), company.getParentCompany()));
        }
    }
}
