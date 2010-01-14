package com.neosavvy.user.dao.companyManagement;

import com.neosavvy.user.dto.companyManagement.UserInviteDTO;

import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: lgleason
 * Date: Dec 19, 2009
 * Time: 11:30:36 PM
 * To change this template use File | Settings | File Templates.
 */
public interface UserInviteDAO {
	public UserInviteDTO saveUserInvite(UserInviteDTO userInvite);

	public UserInviteDTO findUserInviteById(long id);

	public List<UserInviteDTO> findUserInvites(UserInviteDTO userInvite);

	public void deleteUserInvite(UserInviteDTO userInvite);
}
