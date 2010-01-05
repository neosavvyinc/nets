package com.neosavvy.user.dao.companyManagement;

import com.neosavvy.user.dao.base.BaseDAO;
import com.neosavvy.user.dto.CompanyDTO;
import com.neosavvy.user.dto.UserDTO;
import org.hibernate.Query;
import org.hibernate.criterion.Restrictions;
import org.hibernate.Criteria;

import java.util.List;

public class UserDAOImpl extends BaseDAO implements UserDAO {


    public void deleteUser(UserDTO user) {
		getCurrentSession().delete(user);
        getCurrentSession().flush();
	}

	public UserDTO findUserById(int id) {
        return (UserDTO) getCurrentSession()
                .createCriteria(UserDTO.class)
                .add( Restrictions.idEq(id) )
                .uniqueResult();
    }

	public List<UserDTO> findUsers(UserDTO user) {
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
        if(user.getUsername() != null && user.getUsername().length() > 0) {
            criteria.add(Restrictions.eq("username", user.getUsername()));
        }
        if(user.getPassword() != null && user.getPassword().length() > 0) {
            criteria.add(Restrictions.eq("password", user.getPassword()));
        }
		return criteria.list();
	}

	public List<UserDTO> getUsers() {
		return getCurrentSession().createCriteria(UserDTO.class).list();
	}

	public void saveUser(UserDTO user) {
		getCurrentSession().saveOrUpdate(user);
        getCurrentSession().flush();
	}

    public List<UserDTO> findUsersForCompany(CompanyDTO company, UserDTO user) {
        StringBuffer queryString = new StringBuffer("select user from UserDTO user, UserCompanyRoleDTO ucl, CompanyDTO company " +
                "where user.id = ucl.user and ucl.company = company.id " +
                "and company.id = :companyId");
        if( user != null ) {
            queryString.append(" and user.active = :userActive");
        }

        Query userQuery = getCurrentSession().createQuery(queryString.toString());
        userQuery.setInteger("companyId",company.getId());

        if( user != null) {
            userQuery.setBoolean("userActive", user.getActive());
        }

        return userQuery.list();
    }

}
