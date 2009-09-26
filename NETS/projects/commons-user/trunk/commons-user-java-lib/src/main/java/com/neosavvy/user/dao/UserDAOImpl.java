package com.neosavvy.user.dao;

import com.neosavvy.user.dto.UserDTO;
import org.hibernate.criterion.Restrictions;
import org.hibernate.classic.Session;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import java.util.List;

public class UserDAOImpl extends HibernateDaoSupport implements UserDAO {

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
		return getHibernateTemplate().findByExample(user);
	}

	public List<UserDTO> getUsers() {
		return getHibernateTemplate().loadAll(UserDTO.class);
	}

	public void saveUser(UserDTO user) {
		getCurrentSession().saveOrUpdate(user);
	}

    protected Session getCurrentSession() {
        return getSessionFactory().getCurrentSession();
    }

}
