package com.neosavvy.user.dao.base;

import com.neosavvy.user.dto.CompanyDTO;
import com.neosavvy.user.dto.UserDTO;

import java.util.List;

public interface BaseUserDAO {

	public List<UserDTO> getUsers();

	public void saveUser(UserDTO user);

	public UserDTO findUserById(int id);

	public List<UserDTO> findUsers(UserDTO user);

	public void deleteUser(UserDTO user);
}
