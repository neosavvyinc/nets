package com.neosavvy.user.dao;

import com.neosavvy.user.dto.UserCompanyRoleDTO;

import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: lgleason
 * Date: Dec 9, 2009
 * Time: 1:00:01 PM
 * To change this template use File | Settings | File Templates.
 */
public interface UserCompanyRoleDAO {
    public List<UserCompanyRoleDTO> getUserCompanyRoles();

	public void saveUserCompanyRole(UserCompanyRoleDTO userCompanyRole);

	public UserCompanyRoleDTO findUserCompanyRoleById(int id);

    public void deleteUserCompanyRole(UserCompanyRoleDTO userCompanyRole);
}
