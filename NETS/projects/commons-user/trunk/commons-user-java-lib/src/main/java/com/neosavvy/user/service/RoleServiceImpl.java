package com.neosavvy.user.service;

import com.neosavvy.user.dao.companyManagement.RoleDAO;
import com.neosavvy.user.dto.RoleDTO;

import java.util.List;

/**
 * User: lgleason
 * Date: Dec 4, 2009
 * Time: 5:37:19 PM
 */
public class RoleServiceImpl implements RoleService{

    private RoleDAO roleDao;

    public List<RoleDTO> getRoles() {
        return roleDao.getRoles();
    }

    public void saveRole(RoleDTO role) {
        roleDao.saveRole(role);
    }

    public RoleDTO findRoleById(int id) {
        return roleDao.findRoleById(id);
    }

    public List<RoleDTO> findRoles(RoleDTO role) {
        return roleDao.findRoles(role);
    }

    public void deleteRole(RoleDTO role) {
        roleDao.deleteRole(role);
    }

    public void setRoleDao(RoleDAO roleDao) {
        this.roleDao = roleDao;
    }
}
