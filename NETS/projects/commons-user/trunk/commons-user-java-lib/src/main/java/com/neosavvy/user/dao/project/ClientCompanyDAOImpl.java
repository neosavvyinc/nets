package com.neosavvy.user.dao.project;

import com.neosavvy.user.dao.base.BaseCompanyDAOImpl;
import com.neosavvy.user.dto.companyManagement.CompanyDTO;
import com.neosavvy.user.dto.project.ClientCompany;
import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.criterion.Restrictions;

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
    public List<ClientCompany> findCompanies(ClientCompany company) {
        Criteria criteria = super.generateCriteriaForFind(company);

        if(company.getParentCompany() != null) {
            criteria.add(Restrictions.eq("parentCompany", company.getParentCompany()));
        }

        return criteria.list();
    }
}
