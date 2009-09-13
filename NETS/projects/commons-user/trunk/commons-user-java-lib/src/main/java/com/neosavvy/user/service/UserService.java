package com.neosavvy.user.service;

import com.neosavvy.user.dto.UserDTO;

public interface UserService {

	public UserDTO[] getUsers();
	
	public UserDTO saveUser(UserDTO user);
	
	public UserDTO findUserById(int id);
	
	public UserDTO[] findUsers(UserDTO user);
	
	public boolean deleteUser(UserDTO user);	

}
