package com.neosavvy.user.service;

import org.springframework.security.annotation.Secured;

import java.util.List;
import java.util.Set;

import com.neosavvy.user.dto.CompanyDTO;
import com.neosavvy.user.dto.UserDTO;
import com.neosavvy.user.dto.UserInviteDTO;
import com.neosavvy.user.dao.CompanyDAO;
import org.springframework.transaction.annotation.Transactional;

/**
 * User: lgleason
 * Date: Dec 4, 2009
 * Time: 4:15:26 PM
 */
@Transactional
public interface CompanyService {
    @Secured("ROLE_ADMIN")
	public List<CompanyDTO> getCompanies();

	public CompanyDTO saveCompany(CompanyDTO company);

    public void addCompany(CompanyDTO company, UserDTO user);

    @Secured("ROLE_ADMIN")
	public CompanyDTO findCompanyById(int id);

    @Secured("ROLE_ADMIN")
	public List<CompanyDTO> findCompanies(CompanyDTO company);

    public void addUserToCompany(CompanyDTO company, UserDTO employee);

    public List<UserInviteDTO> inviteUsers(CompanyDTO company, List<UserInviteDTO> userInvites);

    public List<UserInviteDTO> getInvitedUsers(CompanyDTO company);

    public void deleteInvitedUser(CompanyDTO company, UserInviteDTO userInvite);
}
