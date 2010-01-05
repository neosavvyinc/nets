package com.neosavvy.user.dao.base;

import com.neosavvy.user.dto.companyManagement.UserDTO;

import java.util.List;

public interface BaseUserDAO {

	public List<UserDTO> getUsers();

	public void saveUser(UserDTO user);

	public UserDTO findUserById(int id);

	public List<UserDTO> findUsers(UserDTO user);

	public void deleteUser(UserDTO user);
}
