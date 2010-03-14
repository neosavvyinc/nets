package com.neosavvy.user.service;

import com.neosavvy.user.dao.companyManagement.UserDAO;
import com.neosavvy.user.dto.companyManagement.SecurityWrapperDTO;
import com.neosavvy.user.dto.companyManagement.UserDTO;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import com.neosavvy.user.service.exception.UserServiceException;
import com.neosavvy.util.StringUtil;
import fineline.focal.common.security.UserSessionManager;
import fineline.focal.common.types.v1.UserSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.mail.MailException;
import org.springframework.mail.MailSender;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;

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

        if (!results.isEmpty()) {
            security.setUser(results.get(0));
            return security;
        }

        return null;
    }

    /**
     * REST login method, still needs request/response access
     * @param userName
     * @param password
     * @return
     */
    public SecurityWrapperDTO login(String userName, String password) {
        Authentication authentication = authManager.authenticate(new UsernamePasswordAuthenticationToken(userName, password));
        SecurityContextHolder.getContext().setAuthentication(authentication);
        /**
         * TODO, sessionManager.initSession(userName, request, response);
         */
        return getUserDetails();
    }

    /**
     * REST logout method, still needs request/response access
     * @return
     */
    public boolean logout() {
        SecurityContextHolder.clearContext();
        /**
         * TODO, sessionManager.invalidateCurrentSession(request, response);
         */
        return true;
    }
    
    public void resetPassword(UserDTO user) {
        try {
            user.setPassword(StringUtil.getHash64(user.toString() + System.currentTimeMillis() + ""));
        } catch (UnsupportedEncodingException e) {
            logger.error(e.toString());
            throw new UserServiceException("Unable to generate new password for user: "+ user.toString(),e);
        }

        userDao.saveUser(user);

        mailService.resetPasswordForUserEmail(user);
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
}
