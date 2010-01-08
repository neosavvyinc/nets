package com.neosavvy.user.dao.base;

import com.neosavvy.user.dto.base.BaseUserDTO;
import com.neosavvy.user.dto.companyManagement.UserDTO;

import java.util.List;

public interface BaseUserDAO<T extends BaseUserDTO> {

	public List<T> getUsers();

	public void saveUser(T user);

	public UserDTO findUserById(long id);

	public List<T> findUsers(T user);

	public void deleteUser(T user);
}
