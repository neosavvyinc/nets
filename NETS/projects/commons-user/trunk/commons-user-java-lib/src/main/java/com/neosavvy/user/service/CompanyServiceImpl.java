package com.neosavvy.user.service;

import com.neosavvy.user.dao.*;
import com.neosavvy.user.dto.*;
import com.neosavvy.user.service.exception.CompanyServiceException;
import com.neosavvy.user.service.exception.UserServiceException;
import com.neosavvy.util.StringUtil;
import org.apache.log4j.Logger;
import org.springframework.mail.MailException;
import org.springframework.mail.MailSender;
import org.springframework.mail.SimpleMailMessage;

import java.io.UnsupportedEncodingException;
import java.util.List;
import java.util.HashSet;
import java.util.ArrayList;

/**
 * User: lgleason
 * Date: Dec 4, 2009
 * Time: 4:18:34 PM
 */
public class CompanyServiceImpl implements CompanyService{

    private static final Logger logger = Logger.getLogger(UserServiceImpl.class);

    private CompanyDAO companyDao;
    private UserCompanyRoleDAO userCompanyRoleDao;
    private RoleDAO roleDao;
    private UserDAO userDao;
    private NumEmployeesRangeDAO numEmployeesRangeDao;
    private UserInviteDAO userInviteDao;
    private MailSender mailSender;
    private SimpleMailMessage templateMessage;
    private String hostName;

    public List<CompanyDTO> getCompanies() {
        return companyDao.getCompanies();
    }

    public CompanyDTO saveCompany(CompanyDTO company) {
        if( company.getNumEmployeesRange() != null )
            numEmployeesRangeDao.saveRange(company.getNumEmployeesRange());

        return companyDao.saveCompany(company);
    }

    public CompanyDTO findCompanyById(int id) {
        return companyDao.findCompanyById(id);
    }

    public List<CompanyDTO> findCompanies(CompanyDTO company) {
        return companyDao.findCompanies(company);
    }

    public void addCompany(CompanyDTO company, UserDTO user) {
        saveUserAndEmailConfirmation(user);
        saveCompany(company);
        // At some point we should look at getting rid of this hard coding.
        RoleDTO roleToFind = new RoleDTO();
        roleToFind.setShortName("ROLE_ADMIN");
        List<RoleDTO> adminRoles = roleDao.findRoles(roleToFind);
        if((adminRoles.size() > 1) || (adminRoles.size() < 1)){
          throw new CompanyServiceException("invalid number of ROLE_ADMINS found " + adminRoles.size(), null);
        }
        UserCompanyRoleDTO userCompanyRole = new UserCompanyRoleDTO();
        userCompanyRole.setRole(adminRoles.get(0));
        userCompanyRole.setUser(user);
        userCompanyRole.setCompany(company);
        userCompanyRoleDao.saveUserCompanyRole(userCompanyRole);
        HashSet<UserCompanyRoleDTO> userCompanyRoles = new HashSet<UserCompanyRoleDTO>();
        userCompanyRoles.add(userCompanyRole);
        company.setUserCompanyRoles(userCompanyRoles);
        companyDao.saveCompany(company);
    }

    protected void saveUserAndEmailConfirmation(UserDTO user) {
        try {
            user.setRegistrationToken(StringUtil.getHash64(user.toString() + System.currentTimeMillis() + ""));
        } catch (UnsupportedEncodingException e) {
            logger.error(e);
            throw new UserServiceException("Unable to generate token for user: "+ user.toString(),e);
        }

        userDao.saveUser(user);

        SimpleMailMessage msg = new SimpleMailMessage(this.templateMessage);
        msg.setTo(user.getEmailAddress());
        msg.setText("Use your registration token to confirm that you are actually whom you say you are. \n\nThis is your registration token: " + user.getRegistrationToken());
        try{
            mailSender.send(msg);
        }
        catch(MailException ex) {
            logger.error(ex.getMessage());
        }
    }

    public void addUserToCompany(CompanyDTO company, UserDTO user) {
        if(user == null){
            throw new CompanyServiceException("null user not supported", null);    
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

        verifyAndAttachCompany(company);
        userInvite.setCompany(company);
        try {
            userInvite.setRegistrationToken(StringUtil.getHash64(userInvite.toString() + System.currentTimeMillis() + ""));
        } catch (UnsupportedEncodingException e) {
            logger.error(e);
            throw new UserServiceException("Unable to generate token for user: " + userInvite.toString(), e);
        }
        userInviteDao.saveUserInvite(userInvite);
        companyDao.saveCompany(company);
        sendInvite(userInvite);
    }

    public void deleteInvitedUser(CompanyDTO company, UserInviteDTO userInvite) {
        userInviteDao.deleteUserInvite(userInvite);
    }

    public void sendInvite(UserInviteDTO userInvite){
        SimpleMailMessage msg = new SimpleMailMessage(this.templateMessage);
        msg.setTo(userInvite.getEmailAddress());
        msg.setText("This is an invite to join your company's expense tracking tool!!!");
        try{
            mailSender.send(msg);
        }
        catch(MailException ex) {
            logger.error(ex.getMessage());
        }
    }

    protected CompanyDTO verifyAndAttachCompany(CompanyDTO company){
        if(company == null){
            throw new CompanyServiceException("null company not supported", null);
        }

        CompanyDTO verifiedCompany = companyDao.findCompanyById(company.getId());

        if(verifiedCompany == null){
            throw new CompanyServiceException("unpersisted company", null);
        }
        return verifiedCompany;
    }

    public List<UserInviteDTO> getInvitedUsers(CompanyDTO company) {
        // for now we are going to access this via company but later on this should probably be a direct
        // query against the userInvites table.
        company = verifyAndAttachCompany(company);
        return new ArrayList(company.getUserInvites());
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

    public NumEmployeesRangeDAO getNumEmployeesRangeDao() {
        return numEmployeesRangeDao;
    }

    public void setNumEmployeesRangeDao(NumEmployeesRangeDAO numEmployeesRangeDao) {
        this.numEmployeesRangeDao = numEmployeesRangeDao;
    }

    public void setMailSender(MailSender mailSender) {
        this.mailSender = mailSender;
    }

    public MailSender getMailSender() {
        return this.mailSender;
    }

    public void setTemplateMessage(SimpleMailMessage templateMessage) {
        this.templateMessage = templateMessage;
    }

    public SimpleMailMessage getTemplateMessage() {
        return this.templateMessage;
    }

    public List<UserDTO> getUsers() {
        return userDao.getUsers();
    }
    
    public String getHostName() {
        return hostName;
    }

    public void setHostName(String hostName) {
        this.hostName = hostName;
    }

    public UserInviteDAO getUserInviteDao() {
        return userInviteDao;
    }

    public void setUserInviteDao(UserInviteDAO userinviteDao) {
        this.userInviteDao = userinviteDao;
    }
}
