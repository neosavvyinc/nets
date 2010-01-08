package com.neosavvy.user.dao.companyManagement;

import com.neosavvy.user.dao.base.BaseDAO;
import com.neosavvy.user.dto.companyManagement.RoleDTO;

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
        return getCurrentSession().createCriteria(RoleDTO.class).list();
    }

    public void saveRole(RoleDTO role) {
        getCurrentSession().saveOrUpdate(role);
        getCurrentSession().flush();
    }

    public RoleDTO findRoleById(long id) {
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
        return criteria.list(); 
    }

    public void deleteRole(RoleDTO role) {
        getCurrentSession().delete(role);
        getCurrentSession().flush();
    }
}
