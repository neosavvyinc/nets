package com.neosavvy.user.dao;

import com.neosavvy.user.dto.UserCompanyRoleDTO;

import java.util.List;

import org.hibernate.criterion.Restrictions;

/**
 * Created by IntelliJ IDEA.
 * User: lgleason
 * Date: Dec 9, 2009
 * Time: 1:00:17 PM
 * To change this template use File | Settings | File Templates.
 */
public class UserCompanyRoleDAOImpl extends BaseDAO implements UserCompanyRoleDAO{
    public List<UserCompanyRoleDTO> getUserCompanyRoles() {
        return getCurrentSession().createCriteria(UserCompanyRoleDTO.class).list();
    }

    public void saveUserCompanyRole(UserCompanyRoleDTO userCompanyRole) {
        getCurrentSession().saveOrUpdate(userCompanyRole);
        getCurrentSession().flush();
    }

    public UserCompanyRoleDTO findUserCompanyRoleById(int id) {
        return (UserCompanyRoleDTO) getCurrentSession()
                .createCriteria(UserCompanyRoleDTO.class)
                .add(Restrictions.idEq(id))
                .uniqueResult();
    }

    public void deleteUserCompanyRole(UserCompanyRoleDTO userCompanyRole) {
        getCurrentSession().delete(userCompanyRole);
        getCurrentSession().flush();
    }
}
