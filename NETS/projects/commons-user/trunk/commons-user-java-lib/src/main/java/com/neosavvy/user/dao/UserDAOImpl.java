package com.neosavvy.user.dao;

import com.neosavvy.user.dto.CompanyDTO;
import com.neosavvy.user.dto.UserDTO;
import org.hibernate.SessionFactory;
import org.hibernate.classic.Session;
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

    public List<UserDTO> findUsersForCompany(CompanyDTO company) {
        return getCurrentSession().createQuery(
                "from UserDTO user inner join UserCompanyRoles ucl where user.id = ucl.user_fk")
                .list();
    }

}
