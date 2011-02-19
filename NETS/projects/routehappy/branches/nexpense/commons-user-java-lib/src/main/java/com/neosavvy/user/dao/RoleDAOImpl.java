package com.neosavvy.user.dao;

import com.neosavvy.user.dto.RoleDTO;

import java.util.List;

import org.hibernate.criterion.Restrictions;
import org.hibernate.Criteria;

/**
 * Created by IntelliJ IDEA.
 * User: lgleason
 * Date: Nov 28, 2009
 * Time: 4:04:03 AM
 * To change this template use File | Settings | File Templates.
 */
public class RoleDAOImpl extends BaseDAO implements RoleDAO{
    public List<RoleDTO> getRoles() {
        return null;  //To change body of implemented methods use File | Settings | File Templates.
    }

    public void saveRole(RoleDTO role) {
        getCurrentSession().saveOrUpdate(role);
        getCurrentSession().flush();
    }

    public RoleDTO findRoleById(int id) {
        return (RoleDTO) getCurrentSession()
                .createCriteria(RoleDTO.class)
                .add( Restrictions.idEq(id) )
                .uniqueResult();
    }

    public List<RoleDTO> findRoles(RoleDTO role) {
        Criteria criteria = getCurrentSession().createCriteria(RoleDTO.class);
        if(role.getShortName() != null && role.getShortName().length() > 0) {
            criteria.add(Restrictions.eq("shortName", role.getShortName()));
        }
        if(role.getLongName() != null && role.getLongName().length() > 0) {
            criteria.add(Restrictions.eq("longName", role.getLongName()));
        }
        return criteria.list();  //To change body of implemented methods use File | Settings | File Templates.
    }

    public void deleteRole(RoleDTO role) {
        getCurrentSession().delete(role);
        getCurrentSession().flush();
    }
}
