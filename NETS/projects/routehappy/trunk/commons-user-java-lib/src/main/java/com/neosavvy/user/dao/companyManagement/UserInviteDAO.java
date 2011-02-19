package com.neosavvy.user.dao.companyManagement;

import com.neosavvy.user.dto.companyManagement.UserInviteDTO;

import java.util.List;


public interface UserInviteDAO {
	public UserInviteDTO saveUserInvite(UserInviteDTO userInvite);

	public UserInviteDTO findUserInviteById(long id);

	public List<UserInviteDTO> findUserInvites(UserInviteDTO userInvite);

	public void deleteUserInvite(UserInviteDTO userInvite);
}
