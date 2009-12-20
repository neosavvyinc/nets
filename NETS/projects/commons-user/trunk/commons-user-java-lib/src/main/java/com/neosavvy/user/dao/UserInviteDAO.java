package com.neosavvy.user.dao;

import com.neosavvy.user.dto.UserInviteDTO;

import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: lgleason
 * Date: Dec 19, 2009
 * Time: 11:30:36 PM
 * To change this template use File | Settings | File Templates.
 */
public interface UserInviteDAO {
    
    public List<UserInviteDTO> getUserInvites();

	public void saveUserInvite(UserInviteDTO userInvite);

	public UserInviteDTO findUserInviteById(int id);

	public List<UserInviteDTO> findUserInvites(UserInviteDTO userInvite);

	public void deleteUserInvite(UserInviteDTO userInvite);
}