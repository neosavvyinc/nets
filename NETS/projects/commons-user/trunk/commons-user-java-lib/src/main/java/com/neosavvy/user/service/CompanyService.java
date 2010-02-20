package com.neosavvy.user.service;

import com.neosavvy.security.RunAs;
import com.neosavvy.user.dto.companyManagement.CompanyDTO;
import com.neosavvy.user.dto.companyManagement.UserInviteDTO;

import java.util.List;

import com.neosavvy.user.dto.companyManagement.UserDTO;
import org.springframework.security.access.annotation.Secured;
import org.springframework.transaction.annotation.Transactional;

/**
 * User: lgleason
 * Date: Dec 4, 2009
 * Time: 4:15:26 PM
 */
@Transactional
public interface CompanyService {
    @Secured({"ROLE_ADMIN", "AFTER_ACL_READ"})
	public CompanyDTO findCompanyById(long id);

    @Secured({"ROLE_ADMIN", "AFTER_ACL_COLLECTION_READ"})
	public List<CompanyDTO> findCompanies(CompanyDTO company);

    @Secured({"ROLE_ADMIN", "ACL_OBJECT_WRITE"})
    public void addUserToCompany(CompanyDTO company, UserDTO employee);

    @Secured({"ROLE_ADMIN", "ACL_OBJECT_WRITE"})
    public void inviteUsers(CompanyDTO company, UserInviteDTO userInvites);

    @Secured({"ROLE_ADMIN", "AFTER_ACL_READ"})
    public List<UserInviteDTO> getInvitedUsers(CompanyDTO company);

    @Secured({"ROLE_ADMIN", "ACL_OBJECT_WRITE", "ACL_OBJECT_DELETE"})
    public void deleteInvitedUser(CompanyDTO company, UserInviteDTO userInvite);

    /****
     * Interface for helper search methods
     ****/
    @Secured({"ROLE_ADMIN", "AFTER_ACL_COLLECTION_READ"})
    public List<UserDTO> findUsersForCompany(CompanyDTO company);

    @Secured({"ROLE_ADMIN", "AFTER_ACL_COLLECTION_READ"})
    public List<UserDTO> findActiveUsersForCompany(CompanyDTO company);

    @Secured({"ROLE_ADMIN", "AFTER_ACL_COLLECTION_READ"})
    public List<UserDTO> findInactiveUsersForCompany(CompanyDTO company);

    @Secured({"ROLE_ADMIN", "ACL_OBJECT_WRITE", "AFTER_ACL_READ"})
    public CompanyDTO saveCompany(CompanyDTO company);

    /*****************************************************************
     *  All Non Secured Methods should go below this line
     *****************************************************************/
    /**
     * This method attempts to look up a user's invite via the registration token.
     * Then it will retrieve the company they were invited to off of the invite.
     * It will then persist the new user and send a confirmation email to thank
     * them for joining the company.
     *
     * @param user
     */
    public void addEmployeeToCompany(UserDTO user);

    public void addCompany(CompanyDTO company, UserDTO user);
}
