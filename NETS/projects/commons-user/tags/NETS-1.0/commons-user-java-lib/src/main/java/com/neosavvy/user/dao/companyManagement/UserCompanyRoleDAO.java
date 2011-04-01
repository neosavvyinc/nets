package com.neosavvy.user.dao.companyManagement;

import com.neosavvy.user.dto.companyManagement.UserCompanyRoleDTO;

import java.util.List;


public interface UserCompanyRoleDAO {
	public UserCompanyRoleDTO saveUserCompanyRole(UserCompanyRoleDTO userCompanyRole);

	public UserCompanyRoleDTO findUserCompanyRoleById(long id);

    public List<UserCompanyRoleDTO> findUserCompanyRoles(UserCompanyRoleDTO userCompanyRole);

    public void deleteUserCompanyRole(UserCompanyRoleDTO userCompanyRole);
}
