package com.neosavvy.user.service;

import org.springframework.security.annotation.Secured;

import java.util.List;

import com.neosavvy.user.dto.RoleDTO;
import org.springframework.transaction.annotation.Transactional;

/**
 * User: lgleason
 * Date: Dec 4, 2009
 * Time: 5:28:05 PM
 */
@Transactional
public interface RoleService {

    @Secured("ROLE_ADMIN")
	public List<RoleDTO> getRoles();

    @Secured("ROLE_ADMIN")
	public void saveRole(RoleDTO role);

    @Secured("ROLE_ADMIN")
	public RoleDTO findRoleById(int id);

    @Secured("ROLE_ADMIN")
	public List<RoleDTO> findRoles(RoleDTO role);

    @Secured("ROLE_ADMIN")
	public void deleteRole(RoleDTO role);

}
