package com.neosavvy.user.dao;

import com.neosavvy.user.dto.CompanyDTO;
import com.neosavvy.user.dto.UserDTO;

import java.util.List;

public interface UserDAO {

	public List<UserDTO> getUsers();

	public void saveUser(UserDTO user);

	public UserDTO findUserById(int id);

	public List<UserDTO> findUsers(UserDTO user);

	public void deleteUser(UserDTO user);

    public List<UserDTO> findUsersForCompany(CompanyDTO company, UserDTO user);

}
