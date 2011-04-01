package com.neosavvy.user.dao.base;

import com.neosavvy.user.dto.companyManagement.AbstractCompany;
import com.neosavvy.user.dto.companyManagement.CompanyDTO;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import java.util.ArrayList;
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

    public T saveCompany(T company) {
        if (company.getId() == null) {
            getEntityManager().persist(company);
        }
		else {
            company = getEntityManager().merge(company);
        }
        getEntityManager().flush();
        return company;
    }

    public T findCompanyById(long id) {
        return getEntityManager().find(getTypeClass(), id);
    }

    public List<T> findCompanies(T company) {
        CriteriaQuery<T> criteria = generateCriteriaForFind(company);
		return getEntityManager().createQuery(criteria).getResultList();
    }

    protected CriteriaQuery<T> generateCriteriaForFind(T company) {
        CriteriaBuilder builder = getEntityManager().getCriteriaBuilder();
        CriteriaQuery<T> criteria = builder.createQuery(getTypeClass());
        Root<T> root = criteria.from(getTypeClass());
        List<Predicate> searchPredicates = new ArrayList<Predicate>();

        addSearchPredicates(company, builder, root, searchPredicates);
        return criteria.where(searchPredicates.toArray(new Predicate[0]));
    }

    protected void addSearchPredicates(T company, CriteriaBuilder builder, Root<T> root, List<Predicate> searchPredicates) {
        if(company.getCompanyName() != null && company.getCompanyName().length() > 0) {
            searchPredicates.add(builder.equal(root.get("companyName"), company.getCompanyName()));
        }
        if(company.getCity() != null && company.getCity().length() > 0) {
            searchPredicates.add(builder.equal(root.get("city"), company.getCity()));
        }
        if(company.getState() != null && company.getState().length() > 0) {
            searchPredicates.add(builder.equal(root.get("state"), company.getState()));
        }
        if(company.getPostalCode() != null && company.getPostalCode().length() > 0) {
            searchPredicates.add(builder.equal(root.get("postalCode"), company.getPostalCode()));
        }
    }

    public void delete(T company) {
		getEntityManager().remove(company);
        getEntityManager().flush();
	}

    protected abstract Class<T> getTypeClass();

}
