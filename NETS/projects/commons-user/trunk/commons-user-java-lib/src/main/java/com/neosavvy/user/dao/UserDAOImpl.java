package com.neosavvy.user.dao;

import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.neosavvy.user.dto.UserDTO;

public class UserDAOImpl extends HibernateDaoSupport implements UserDAO {

	public boolean deleteUser(UserDTO user) {
		// TODO Auto-generated method stub
		return false;
	}

	public UserDTO findUserById(int id) {
		// TODO Auto-generated method stub
		return null;
	}

	public UserDTO[] findUsers(UserDTO user) {
		// TODO Auto-generated method stub
		return null;
	}

	public UserDTO[] getUsers() {
		// TODO Auto-generated method stub
		return null;
	}

	public Integer saveUser(UserDTO user) {
		return (Integer) getHibernateTemplate().save(user);
	}

}
