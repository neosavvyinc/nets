package com.neosavvy.user.dao.companyManagement;

import com.neosavvy.user.dao.base.BaseUserDAOImpl;
import com.neosavvy.user.dto.base.BaseUserDTO;
import com.neosavvy.user.dto.companyManagement.CompanyDTO;
import com.neosavvy.user.dto.companyManagement.UserDTO;
import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.criterion.Restrictions;

import java.util.List;

public class UserDAOImpl extends BaseUserDAOImpl<UserDTO> implements UserDAO {

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

    @Override
    public List<UserDTO> findUsers(UserDTO user) {
        Criteria criteria = generateCommonCriteriaFromBaseClass(user);
        if(user.getUsername() != null && user.getUsername().length() > 0) {
            criteria.add(Restrictions.eq("username", user.getUsername()));
        }
        if(user.getPassword() != null && user.getPassword().length() > 0) {
            criteria.add(Restrictions.eq("password", user.getPassword()));
        }

		return criteria.list();
    }
}
