package com.neosavvy.user.service;

import com.neosavvy.security.AclSecurityUtil;
import com.neosavvy.security.RunAsExecutor;
import com.neosavvy.user.dao.companyManagement.*;
import com.neosavvy.user.dto.companyManagement.*;
import com.neosavvy.user.service.exception.CompanyServiceException;
import com.neosavvy.user.service.exception.UserServiceException;
import com.neosavvy.util.StringUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.dao.DataAccessException;
import org.springframework.mail.MailException;
import org.springframework.mail.MailSender;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.security.acls.domain.BasePermission;
import org.springframework.security.acls.domain.PrincipalSid;
import org.springframework.security.acls.model.Sid;
import org.springframework.transaction.annotation.Transactional;

import java.io.UnsupportedEncodingException;
import java.util.List;
import java.util.HashSet;
import java.util.Set;

@Transactional
public class CompanyServiceImpl implements CompanyService{

    private static final Logger logger = LoggerFactory.getLogger(UserServiceImpl.class);

    private CompanyDAO companyDao;
    private UserCompanyRoleDAO userCompanyRoleDao;
    private RoleDAO roleDao;
    private UserDAO userDao;
    private UserInviteDAO userInviteDao;
    private AclSecurityUtil aclSecurityUtil;
    private RunAsExecutor adminExecutor;
    private MailService mailService;

    public CompanyDTO saveCompany(CompanyDTO company) {
        return companyDao.saveCompany(company);
    }

    public CompanyDTO findCompanyById(long id) {
        return companyDao.findCompanyById(id);
    }

    public List<CompanyDTO> findCompanies(CompanyDTO company) {
        List<CompanyDTO> companies = companyDao.findCompanies(company);
        return companies;
    }

    @Transactional(rollbackFor={CompanyServiceException.class, DataAccessException.class})
    public void addCompany(CompanyDTO company, UserDTO user) {
        final UserDTO savedUser = saveUserAndEmailConfirmation(user);
        saveCompany(company);
        // At some point we should look at getting rid of this hard coding.
        RoleDTO roleToFind = new RoleDTO();
        roleToFind.setShortName("ROLE_ADMIN");
        List<RoleDTO> adminRoles = roleDao.findRoles(roleToFind);
        if((adminRoles.size() > 1) || (adminRoles.size() < 1)){
          throw new CompanyServiceException("invalid number of ROLE_ADMINS found " + adminRoles.size(), null);
        }

        final UserCompanyRoleDTO userCompanyRole = new UserCompanyRoleDTO();
        userCompanyRole.setRole(adminRoles.get(0));
        userCompanyRole.setUser(user);
        userCompanyRole.setCompany(company);
        userCompanyRoleDao.saveUserCompanyRole(userCompanyRole);
        HashSet<UserCompanyRoleDTO> userCompanyRoles = new HashSet<UserCompanyRoleDTO>();
        userCompanyRoles.add(userCompanyRole);
        company.setUserCompanyRoles(userCompanyRoles);
        companyDao.saveCompany(company);

        final CompanyDTO savedCompany = company;
        userDao.refreshUser(savedUser);

        // we have to add the company permissions here because the admin user role didn't exist
        // when we persisted the company
        adminExecutor.runAsAdmin(new Runnable() {
            public void run() {
                Sid sid = new PrincipalSid(savedUser.getUsername());
                aclSecurityUtil.addPermission(savedCompany, sid, BasePermission.READ, CompanyDTO.class);
                aclSecurityUtil.addPermission(savedCompany, sid, BasePermission.WRITE, CompanyDTO.class);
                aclSecurityUtil.addPermission(savedCompany, sid, BasePermission.DELETE, CompanyDTO.class);
            }
        });

    }

    protected UserDTO saveUserAndEmailConfirmation(UserDTO user) {
        try {
            user.setRegistrationToken(StringUtil.getHash64(user.toString() + System.currentTimeMillis() + ""));
        } catch (UnsupportedEncodingException e) {
            logger.error(e.toString());
            throw new UserServiceException("Unable to generate token for user: "+ user.toString(),e);
        }

        UserDTO savedUser = userDao.saveUser(user);

        mailService.newUserConfirmationTokenEmail(user);

        return savedUser;
    }



    public void addUserToCompany(CompanyDTO company, UserDTO user) {
        if(user == null || user.getId() == null){
            throw new CompanyServiceException("Must supply an existing user to add a user to the company", null);    
        }
        verifyAndAttachCompany(company);
        //look for user
        UserDTO foundUser = userDao.findUserById(user.getId());

        if ((foundUser == null) || (!foundUser.getUsername().equals(user.getUsername()))){
            throw new CompanyServiceException("no User found that matches username " + user.getUsername(), null);
        }
        
        //look for a valid role
        RoleDTO roleToFind = new RoleDTO();
        roleToFind.setShortName("ROLE_EMPLOYEE");
        List<RoleDTO> employeeRoles = roleDao.findRoles(roleToFind);
        if((employeeRoles.size() > 1) || (employeeRoles.size() < 1)) {
            throw new CompanyServiceException("invalid number of ROLE_EMPLOYEEs found " + employeeRoles.size(), null);
        }

        UserCompanyRoleDTO userCompanyRole = new UserCompanyRoleDTO();
        userCompanyRole.setRole(employeeRoles.get(0));
        userCompanyRole.setUser(user);
        userCompanyRole.setCompany(company);

        if(userCompanyRoleDao.findUserCompanyRoles(userCompanyRole).size() > 0){
            throw new CompanyServiceException("employee/role/company conbination already added " 
                    , null);
        }

        userCompanyRoleDao.saveUserCompanyRole(userCompanyRole);
    }

    public void inviteUsers(CompanyDTO company, UserInviteDTO userInvite) {
        if(userInvite == null){
            throw new CompanyServiceException("null userInvites not supported");
        }

        if(userInvite.getEmailAddress() == null || userInvite.getEmailAddress().length() == 0) {
            throw new CompanyServiceException("Empty email addresses won't allow us to invite your users - please provide an email address");
        }

        company = verifyAndAttachCompany(company);

        UserInviteDTO userInvitesToFind = new UserInviteDTO();
        userInvitesToFind.setCompany(company);
        List<UserInviteDTO> currentInvites = userInviteDao.findUserInvites(userInvitesToFind);

        if (currentInvites != null) {
            for (UserInviteDTO currentInvite : currentInvites) {
                if (currentInvite.getEmailAddress().equals(userInvite.getEmailAddress())) {
                    throw new CompanyServiceException("user already invited", null);
                }
            }
        }

        userInvite.setCompany(company);
        try {
            userInvite.setRegistrationToken(StringUtil.getHash64(userInvite.toString() + System.currentTimeMillis() + ""));
        } catch (UnsupportedEncodingException e) {
            logger.error(e.toString());
            throw new UserServiceException("Unable to generate token for user: " + userInvite.toString(), e);
        }
        final UserInviteDTO savedInvite = userInviteDao.saveUserInvite(userInvite);
/*
        adminExecutor.runAsAdmin(new Runnable() {
            public void run() {
                aclSecurityUtil.addAcl(savedInvite, UserInviteDTO.class);
            }
        });
*/
        
        mailService.sendInvite(userInvite);        
    }

    public void deleteInvitedUser(CompanyDTO company, UserInviteDTO userInvite) {
        userInviteDao.deleteUserInvite(userInvite);
    }

    public void sendInvite(UserInviteDTO userInvite){
        mailService.sendInvite(userInvite);
    }

    protected CompanyDTO verifyAndAttachCompany(CompanyDTO company){
        if(company == null || company.getId() == null){
            throw new CompanyServiceException("Can not save a user to a company that isn't in the database", null);
        }

        CompanyDTO verifiedCompany = companyDao.findCompanyById(company.getId());

        if(verifiedCompany == null){
            throw new CompanyServiceException("unpersisted company", null);
        }
        return verifiedCompany;
    }

    public List<UserInviteDTO> getInvitedUsers(CompanyDTO company) {
        if( company == null ) {
            throw new CompanyServiceException("Company can not be null otherwise no invites will be returned");
        }
        if( company.getId() == null ) {
            throw new CompanyServiceException("Company must have an id to have user invites requested");
        }

        UserInviteDTO userInvite = new UserInviteDTO();
        userInvite.setCompany(company);
        return userInviteDao.findUserInvites(userInvite);
    }

    public List<UserDTO> findUsersForCompany(CompanyDTO company) {
        if( company == null ) {
            throw new CompanyServiceException("To find users for a company, you must supply a company parameter");
        }

        List<UserDTO> users = userDao.findUsersForCompany(company, null);
        return users; 
    }

    public List<UserDTO> findActiveUsersForCompany(CompanyDTO company) {
        if( company == null ) {
            throw new CompanyServiceException("To find active users for a company, you must supply a company parameter");
        }

        UserDTO user = new UserDTO();
        user.setActive(true);
        return userDao.findUsersForCompany(company, user);
    }

    public List<UserDTO> findInactiveUsersForCompany(CompanyDTO company) {
        if( company == null ) {
            throw new CompanyServiceException("To find inactive users for a company, you must supply a company parameter");
        }

        UserDTO user = new UserDTO();
        user.setActive(false);
        return userDao.findUsersForCompany(company, user);
    }

    @Transactional(rollbackFor=CompanyServiceException.class)
    public void addEmployeeToCompany(UserDTO user) {
        // find a user invite via registration token
        UserInviteDTO searchByRegistration = new UserInviteDTO();
        searchByRegistration.setRegistrationToken(user.getRegistrationToken());
        List <UserInviteDTO> invitesFromToken = userInviteDao.findUserInvites(searchByRegistration);
        if( invitesFromToken == null || invitesFromToken.size() != 1) {
            throw new CompanyServiceException("Unfortunately the system could not find a single invite for your confirmation number you provided. Please have your company administrator resend an invite.");
        }

        // get the invite from the persistent invites
        UserInviteDTO userInvite = invitesFromToken.get(0);
        user.setEmailAddress(userInvite.getEmailAddress());

        //Ensure that the user is active and enabled
        user.setConfirmedRegistration(true);
        user.setActive(true);
        final UserDTO savedUser = userDao.saveUser(user);

        // get the company from the UserInvite
        CompanyDTO company = userInvite.getCompany();


        // save the new user to the company
        Set<UserCompanyRoleDTO> membersOfCompany = company.getUserCompanyRoles();
        UserCompanyRoleDTO userCompanyRole = new UserCompanyRoleDTO();
        userCompanyRole.setCompany(company);
        userCompanyRole.setRole(getEmployeeRoleFromDatabase());
        userCompanyRole.setUser(user);
        membersOfCompany.add(userCompanyRole);
        company.setUserCompanyRoles(membersOfCompany);
        userCompanyRoleDao.saveUserCompanyRole(userCompanyRole);

        // email them to tell them how grateful you are for joining
        mailService.newUserConfirmationEmail(user, company);
        userDao.refreshUser(savedUser);

        adminExecutor.runAsAdmin(new Runnable() {
            public void run() {
                Sid sid = new PrincipalSid(savedUser.getUsername());
                // we have to update the ACL here because the company roles didn't exist
                // yet when we persisted the user
                aclSecurityUtil.addAcl(savedUser, UserDTO.class);
            }
        });

    }



    private RoleDTO getEmployeeRoleFromDatabase() {
        RoleDTO role = new RoleDTO();
        role.setShortName("ROLE_EMPLOYEE");
        List<RoleDTO> roles = roleDao.findRoles(role);
        if( roles ==  null || roles.size() != 1) {
            throw new CompanyServiceException("No Employee role could be found - please contact the customer support at customersupport@neosavvy.com");
        }
        return roles.get(0);
    }

    public void setCompanyDao(CompanyDAO companyDao) {
        this.companyDao = companyDao;
    }

    public CompanyDAO getCompanyDao(){
        return companyDao;
    }

    public UserCompanyRoleDAO getUserCompanyRoleDao() {
        return userCompanyRoleDao;
    }

    public void setUserCompanyRoleDao(UserCompanyRoleDAO userCompanyRoleDao) {
        this.userCompanyRoleDao = userCompanyRoleDao;
    }

    public RoleDAO getRoleDao() {
        return roleDao;
    }

    public void setRoleDao(RoleDAO roleDao) {
        this.roleDao = roleDao;
    }

    public UserDAO getUserDao() {
        return userDao;
    }

    public void setUserDao(UserDAO userDao) {
        this.userDao = userDao;
    }

    public UserInviteDAO getUserInviteDao() {
        return userInviteDao;
    }

    public void setUserInviteDao(UserInviteDAO userinviteDao) {
        this.userInviteDao = userinviteDao;
    }

    public MailService getMailService() {
        return mailService;
    }

    public void setMailService(MailService mailService) {
        this.mailService = mailService;
    }
    
    public AclSecurityUtil getAclSecurityUtil() {
        return aclSecurityUtil;
    }

    public void setAclSecurityUtil(AclSecurityUtil aclSecurityUtil) {
        this.aclSecurityUtil = aclSecurityUtil;
    }

    public RunAsExecutor getAdminExecutor() {
        return adminExecutor;
    }

    public void setAdminExecutor(RunAsExecutor adminExecutor) {
        this.adminExecutor = adminExecutor;
    }    
}
