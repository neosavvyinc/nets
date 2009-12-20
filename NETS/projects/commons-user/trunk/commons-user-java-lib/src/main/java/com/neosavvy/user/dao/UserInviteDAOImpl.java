package com.neosavvy.user.dao;

import com.neosavvy.user.dto.UserInviteDTO;

import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: lgleason
 * Date: Dec 19, 2009
 * Time: 11:30:52 PM
 * To change this template use File | Settings | File Templates.
 */
public class UserInviteDAOImpl extends BaseDAO implements UserInviteDAO{
    public List<UserInviteDTO> getUserInvites() {
        return null;  //To change body of implemented methods use File | Settings | File Templates.
    }

    public void saveUserInvite(UserInviteDTO userInvite) {
        getCurrentSession().saveOrUpdate(userInvite);
        getCurrentSession().flush();
    }

    public UserInviteDTO findUserInviteById(int id) {
        return null;  //To change body of implemented methods use File | Settings | File Templates.
    }

    public List<UserInviteDTO> findUserInvites(UserInviteDTO userInvite) {
        return null;  //To change body of implemented methods use File | Settings | File Templates.
    }

    public void deleteUserInvite(UserInviteDTO userInvite) {
        getCurrentSession().delete(userInvite);
        getCurrentSession().flush();
    }
}
