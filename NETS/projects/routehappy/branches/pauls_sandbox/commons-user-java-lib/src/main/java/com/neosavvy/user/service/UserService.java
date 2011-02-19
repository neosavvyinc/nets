package com.neosavvy.user.service;

import com.neosavvy.user.dto.UserDTO;

import java.util.List;

public interface UserService {

	public List<UserDTO> getUsers();

	public void saveUser(UserDTO user);

	public UserDTO findUserById(int id);

	public List<UserDTO> findUsers(UserDTO user);

	public void deleteUser(UserDTO user);

}
