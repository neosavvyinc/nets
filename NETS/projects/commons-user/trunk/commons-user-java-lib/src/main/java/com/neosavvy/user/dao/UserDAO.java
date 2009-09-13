package com.neosavvy.user.dao;

import com.neosavvy.user.dto.UserDTO;

public interface UserDAO {

	public UserDTO[] getUsers();

	public Integer saveUser(UserDTO user);

	public UserDTO findUserById(int id);

	public UserDTO[] findUsers(UserDTO user);

	public boolean deleteUser(UserDTO user);

}
