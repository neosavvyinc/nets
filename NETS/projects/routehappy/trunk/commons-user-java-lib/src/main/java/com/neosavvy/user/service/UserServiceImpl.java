package com.neosavvy.user.service;

import com.neosavvy.user.dao.companyManagement.UserDAO;
import com.neosavvy.user.dto.companyManagement.SecurityWrapperDTO;
import com.neosavvy.user.dto.companyManagement.UserDTO;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.List;

import com.neosavvy.user.service.exception.UserServiceException;
import com.neosavvy.util.StringUtil;
import fineline.focal.common.security.UserSessionManager;
import fineline.focal.common.types.v1.StorageServiceFileRef;
import fineline.focal.common.types.v1.UserSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.Scope;
import org.springframework.mail.MailException;
import org.springframework.mail.MailSender;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;

@Transactional
public class UserServiceImpl implements UserService {

    private static final Logger logger = LoggerFactory.getLogger(UserServiceImpl.class);

    private UserDAO userDao;
    private AuthenticationManager authManager;
    private UserSessionManager sessionManager;
    private MailService mailService;

    public void setUserDao(UserDAO userDao) {
        this.userDao = userDao;
    }

    public UserDAO getUserDao() {
        return userDao;
    }

    public void updateUsers(List<UserDTO> users) throws UserServiceException {
        for (UserDTO userDTO : users) {
            userDao.saveUser(userDTO);
        }
    }

    public void updateUser(UserDTO user) {
        userDao.saveUser(user);
    }
    
    public UserDTO findUserById(long id) {
        return userDao.findUserById(id);
    }

    public List<UserDTO> findUsers(UserDTO user) {
        List<UserDTO> userDTOList = userDao.findUsers(user);

        return userDTOList;
    }

    public void deleteUser(UserDTO user) {
        userDao.deleteUser(user);
    }

    public boolean confirmUser(String userName, String hashCode) {
        Assert.notNull(userName);
        Assert.notNull(hashCode);
                
        UserDTO searchUser = new UserDTO();
        searchUser.setUsername(userName);
        List<UserDTO> matchingUsers = findUsers(searchUser);
        if( matchingUsers != null && matchingUsers.size() == 1) {
            UserDTO matchingUser = matchingUsers.get(0);
            if( hashCode.equals(matchingUser.getRegistrationToken()) ){
                matchingUser.setActive(true);
                matchingUser.setConfirmedRegistration(true);
                userDao.saveUser(matchingUser);
                return true;
            }
        }
        return false;
    }

    public SecurityWrapperDTO getUserDetails() {
        if (SecurityContextHolder.getContext().getAuthentication() == null ||
                SecurityContextHolder.getContext().getAuthentication().getPrincipal() == null) {
            return null;
        }

        Object principal = (Object)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String userName = null;

        if (principal instanceof User) {
            userName = ((User)principal).getUsername();
        }
        else {
            return null;
        }

        Collection<GrantedAuthority> authorities = SecurityContextHolder.getContext().getAuthentication().getAuthorities();
        List<String> authortiesAsStrings = new ArrayList<String>();
        for (GrantedAuthority authority : authorities) {
            authortiesAsStrings.add(authority.toString());
        }

        SecurityWrapperDTO security = new SecurityWrapperDTO(userName, authortiesAsStrings.toArray(new String[]{}));
        UserDTO search = new UserDTO();
        search.setUsername(userName);
        List<UserDTO> results = userDao.findUsers(search);

        String mostCurrentSessionIdForUser = userDao.findMostCurrentSessionIdForUser(userName);
        security.setSessionId(mostCurrentSessionIdForUser);

        if (!results.isEmpty()) {
            security.setUser(results.get(0));
            return security;
        }

        return null;
    }

    public void associateReceiptUploadWithUser(UserDTO user, StorageServiceFileRef fileRef) {

        List<UserDTO> users = findUsers(user);
        if (users.isEmpty()) {
            return;
        }
        UserDTO persistentUser = users.get(0);
        List<StorageServiceFileRef> serviceFileRefList = persistentUser.getUncategorizedReceipts();
        if ( serviceFileRefList == null )
        {
            serviceFileRefList = new ArrayList<StorageServiceFileRef>();
        }
        serviceFileRefList.add( fileRef );
        persistentUser.setUncategorizedReceipts( serviceFileRefList );
        userDao.saveUser( persistentUser );

    }

    public void disassociateReceiptUploadWithUser(UserDTO user, StorageServiceFileRef fileRef) {

        List<UserDTO> users = findUsers(user);
        if (users.isEmpty()) {
            return;
        }
        UserDTO persistentUser = users.get(0);
        List<StorageServiceFileRef> serviceFileRefList = persistentUser.getUncategorizedReceipts();
        if ( serviceFileRefList == null )
        {
            serviceFileRefList = new ArrayList<StorageServiceFileRef>();
        }
        if(serviceFileRefList.remove( fileRef ))
        {
            System.out.println("Did it work");
        }
        persistentUser.setUncategorizedReceipts( serviceFileRefList );
        userDao.saveUser( persistentUser );

    }

    public void resetPassword(UserDTO user) {
        try {
            user.setPasswordReset(true);
            user.setPassword(StringUtil.getHash64(user.toString() + System.currentTimeMillis() + ""));
        } catch (UnsupportedEncodingException e) {
            logger.error(e.toString());
            throw new UserServiceException("Unable to generate new password for user: "+ user.toString(),e);
        }

        userDao.saveUser(user);

        mailService.resetPasswordForUserEmail(user);
    }

    public void resetPasswordForUser( String username ) {
        System.out.println("user="+username);
        UserDTO user = new UserDTO();
        user.setUsername( username );
        List<UserDTO> users = findUsers(user);

        if( users != null && users.size() == 1)
        {
            user = users.get(0);
            try {
                String newPassword = StringUtil.getHash32((new Date().toString()));
                user.setPassword(newPassword);
                user.setPasswordReset(true);
                updateUser(user);
                mailService.resetPasswordForUserEmail(user);
            } catch (UnsupportedEncodingException e) {
                e.printStackTrace();
                throw new UserServiceException("Problem generating new password");
            }
        }
        else
        {
            throw new UserServiceException("User was not found, so password could not be reset");
        }
    }


    public AuthenticationManager getAuthManager() {
        return authManager;
    }

    public void setAuthManager(AuthenticationManager authManager) {
        this.authManager = authManager;
    }

    public UserSessionManager getSessionManager() {
        return sessionManager;
    }

    public void setSessionManager(UserSessionManager sessionManager) {
        this.sessionManager = sessionManager;
    }

    public void setMailService(MailService mailService) {
        this.mailService = mailService;
    }

    public MailService getMailService() {
        return mailService;
    }
}
