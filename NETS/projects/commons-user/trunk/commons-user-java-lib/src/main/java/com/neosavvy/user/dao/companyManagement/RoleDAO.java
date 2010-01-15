package com.neosavvy.user.dao.companyManagement;

import com.neosavvy.user.dto.companyManagement.RoleDTO;

import java.util.List;


public interface RoleDAO {
	public RoleDTO saveRole(RoleDTO user);

	public RoleDTO findRoleById(long id);

	public List<RoleDTO> findRoles(RoleDTO role);
    
    public void deleteRole(RoleDTO role);
}
