package com.neosavvy.user.dao;

import com.neosavvy.user.dto.UserInviteDTO;

import java.util.List;

import org.hibernate.criterion.Restrictions;
import org.hibernate.Criteria;

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
        return (UserInviteDTO) getCurrentSession().
                createCriteria(UserInviteDTO.class).
                add(Restrictions.idEq(id)).
                uniqueResult();
    }

    public List<UserInviteDTO> findUserInvites(UserInviteDTO userInvite) {
        Criteria criteria = getCurrentSession().createCriteria(UserInviteDTO.class);

        if((userInvite.getFirstName() != null) && (userInvite.getFirstName().length() > 0)){
            criteria.add(Restrictions.eq("firstName", userInvite.getFirstName()));
        }

        return criteria.list();  
    }

    public void deleteUserInvite(UserInviteDTO userInvite) {
        getCurrentSession().delete(userInvite);
        getCurrentSession().flush();
    }
}
