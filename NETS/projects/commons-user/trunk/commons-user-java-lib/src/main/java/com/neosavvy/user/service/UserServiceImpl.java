package com.neosavvy.user.service;

import com.neosavvy.user.dao.companyManagement.UserDAO;
import com.neosavvy.user.dto.companyManagement.SecurityWrapperDTO;
import com.neosavvy.user.dto.companyManagement.UserDTO;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;

import com.neosavvy.user.service.exception.UserServiceException;
import com.neosavvy.util.StringUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.mail.MailException;
import org.springframework.mail.MailSender;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.security.GrantedAuthority;
import org.springframework.security.context.SecurityContextHolder;
import org.springframework.security.userdetails.User;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;

@Transactional
public class UserServiceImpl implements UserService {

    private static final Logger logger = LoggerFactory.getLogger(UserServiceImpl.class);

    private UserDAO userDao;

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

    public SecurityWrapperDTO checkUserLoggedIn() {
        User principal = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String userName = principal.getUsername();
        GrantedAuthority[] authorities = SecurityContextHolder.getContext().getAuthentication().getAuthorities();
        List<String> authortiesAsStrings = new ArrayList<String>();
        for (GrantedAuthority authority : authorities) {
            authortiesAsStrings.add(authority.toString()); 
        }

        SecurityWrapperDTO security = new SecurityWrapperDTO(userName, authortiesAsStrings.toArray(new String[]{}));

        return security;
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
}
