package com.neosavvy.user.dao.companyManagement;

import com.neosavvy.user.dto.companyManagement.RoleDTO;

import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: lgleason
 * Date: Nov 28, 2009
 * Time: 4:03:44 AM
 * To change this template use File | Settings | File Templates.
 */
public interface RoleDAO {
	public RoleDTO saveRole(RoleDTO user);

	public RoleDTO findRoleById(long id);

	public List<RoleDTO> findRoles(RoleDTO role);
    
    public void deleteRole(RoleDTO role);
}
