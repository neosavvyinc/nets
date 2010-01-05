package com.neosavvy.user.dao.base;

import com.neosavvy.user.dto.base.BaseUserDTO;
import com.neosavvy.user.dto.companyManagement.UserDTO;
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
 * Date: Jan 5, 2010
 * Time: 3:22:55 PM
 */
public abstract class BaseUserDAOImpl<T extends BaseUserDTO> extends BaseDAO implements BaseUserDAO<T> {

    public void deleteUser(T user) {
		getCurrentSession().delete(user);
        getCurrentSession().flush();
	}

	public UserDTO findUserById(int id) {
        return (UserDTO) getCurrentSession()
                .createCriteria(UserDTO.class)
                .add( Restrictions.idEq(id) )
                .uniqueResult();
    }

    public List<T> findUsers(T user) {
        Criteria c = generateCommonCriteriaFromBaseClass(user);
        return c.list();
    }

    protected Criteria generateCommonCriteriaFromBaseClass(T user) {
        Criteria criteria = getCurrentSession().createCriteria(UserDTO.class);
        if(user.getFirstName() != null && user.getFirstName().length() > 0) {
            criteria.add(Restrictions.eq("firstName", user.getFirstName()));
        }
        if(user.getMiddleName() != null && user.getMiddleName().length() > 0) {
            criteria.add(Restrictions.eq("middleName", user.getMiddleName()));
        }
        if(user.getLastName() != null && user.getLastName().length() > 0) {
            criteria.add(Restrictions.eq("lastName", user.getLastName()));
        }
        if(user.getEmailAddress() != null && user.getEmailAddress().length() > 0) {
            criteria.add(Restrictions.eq("emailAddress", user.getEmailAddress()));
        }
        return criteria;
    }

    public List<T> getUsers() {
		return getCurrentSession().createCriteria(UserDTO.class).list();
	}

	public void saveUser(T user) {
		getCurrentSession().saveOrUpdate(user);
        getCurrentSession().flush();
	}
}
