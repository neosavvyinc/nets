package com.neosavvy.user.dao.base;

import com.neosavvy.user.dto.companyManagement.AbstractCompany;
import com.neosavvy.user.dto.companyManagement.CompanyDTO;
import org.hibernate.Criteria;
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
 * Time: 3:39:31 AM
 */
public abstract class BaseCompanyDAOImpl<T extends AbstractCompany> extends BaseDAO implements BaseCompanyDAO<T> {

    public List<T> getCompanies() {
        return getCurrentSession().createCriteria(AbstractCompany.class).list();
    }

    public T saveCompany(T company) {
        getCurrentSession().clear();
		getCurrentSession().saveOrUpdate(company);
        getCurrentSession().flush();
        return company;
    }

    public T updateCompany(T company) {
        getCurrentSession().update(company);
        getCurrentSession().flush();
        return company;
    }

    public T findCompanyById(int id) {
        return (T) getCurrentSession()
            .createCriteria(AbstractCompany.class)
            .add( Restrictions.idEq(id) )
            .uniqueResult();
    }

    public List<T> findCompanies(T company) {
        Criteria criteria = getCurrentSession().createCriteria(CompanyDTO.class);
        if(company.getCompanyName() != null && company.getCompanyName().length() > 0) {
            criteria.add(Restrictions.eq("companyName", company.getCompanyName()));
        }
        if(company.getCity() != null && company.getCity().length() > 0) {
            criteria.add(Restrictions.eq("city", company.getCity()));
        }
        if(company.getState() != null && company.getState().length() > 0) {
            criteria.add(Restrictions.eq("state", company.getState()));
        }
        if(company.getPostalCode() != null && company.getPostalCode().length() > 0) {
            criteria.add(Restrictions.eq("postalCode", company.getPostalCode()));
        }
		return criteria.list();
    }

    public void delete(T company) {
		getCurrentSession().delete(company);
        getCurrentSession().flush();
	}
}
