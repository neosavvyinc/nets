package com.neosavvy.user.dao.base;

import com.neosavvy.user.dto.base.BaseUserDTO;
import com.neosavvy.user.dto.companyManagement.UserDTO;

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
 * Date: Jan 5, 2010
 * Time: 3:22:55 PM
 */
public abstract class BaseUserDAOImpl<T extends BaseUserDTO> extends BaseDAO implements BaseUserDAO<T> {

    public void deleteUser(T user) {
		getEntityManager().remove(user);
        getEntityManager().flush();
	}

	public T findUserById(long id) {
        return getEntityManager().find(getTypeClass(), id);
    }

    public List<T> findUsers(T user) {
        CriteriaQuery<T> q = generateCommonCriteriaFromBaseClass(user);
        return getEntityManager().createQuery(q).getResultList();
    }

    protected CriteriaQuery<T> generateCommonCriteriaFromBaseClass(T user) {
        CriteriaBuilder builder = getEntityManager().getCriteriaBuilder();
        CriteriaQuery<T> criteria = builder.createQuery(getTypeClass());
        Root<T> root = criteria.from(getTypeClass());
        List<Predicate> searchPredicates = new ArrayList<Predicate>();
        addSearchPredicates(user, builder, root, searchPredicates);
        return criteria.where(searchPredicates.toArray(new Predicate[0]));
    }

    protected void addSearchPredicates(T user, CriteriaBuilder builder, Root<T> root, List<Predicate> searchPredicates) {
        if(user.getFirstName() != null && user.getFirstName().length() > 0) {
            searchPredicates.add(builder.equal(root.get("firstName"), user.getFirstName()));
        }
        if(user.getMiddleName() != null && user.getMiddleName().length() > 0) {
            searchPredicates.add(builder.equal(root.get("middleName"), user.getMiddleName()));
        }
        if(user.getLastName() != null && user.getLastName().length() > 0) {
            searchPredicates.add(builder.equal(root.get("lastName"), user.getLastName()));
        }
        if(user.getEmailAddress() != null && user.getEmailAddress().length() > 0) {
            searchPredicates.add(builder.equal(root.get("emailAddress"), user.getEmailAddress()));
        }
    }

    public T saveUser(T user) {
        if (user.getId() == null) {
            getEntityManager().persist(user);
        }
        else {
		    user = getEntityManager().merge(user);
        }

        getEntityManager().flush();
        return user;
	}

    protected abstract Class<T> getTypeClass();
}
