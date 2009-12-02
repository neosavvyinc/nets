package com.neosavvy.user.service;

import com.neosavvy.user.dto.UserDTO;
import com.neosavvy.user.dao.UserDAO;

import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.List;

import com.neosavvy.user.service.exception.UserServiceException;
import com.neosavvy.util.StringUtil;
import org.apache.log4j.Logger;
import org.springframework.mail.MailException;
import org.springframework.mail.MailSender;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;

@Transactional
public class UserServiceImpl implements UserService {

    private static final Logger logger = Logger.getLogger(UserServiceImpl.class);

    private UserDAO userDao;
    private MailSender mailSender;
    private SimpleMailMessage templateMessage;
    private String hostName;

    public String getHostName() {
        return hostName;
    }

    public void setHostName(String hostName) {
        this.hostName = hostName;
    }

    public void setUserDao(UserDAO userDao) {
        this.userDao = userDao;
    }

    public UserDAO getUserDao() {
        return userDao;
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

    public void saveUser(UserDTO user) {
        try {
            user.setRegistrationToken(StringUtil.getHash64(user.toString() + System.currentTimeMillis() + ""));
        } catch (UnsupportedEncodingException e) {
            logger.error(e);
            throw new UserServiceException("Unable to generate token for user: "+ user.toString(),e);
        }

        userDao.saveUser(user);

        SimpleMailMessage msg = new SimpleMailMessage(this.templateMessage);
        msg.setTo(user.getEmailAddress());
        msg.setText("Please click here to activate your account: http://" + hostName + "/commons-user-webapp/users/data/" + user.getUsername() + "/" + user.getRegistrationToken());
        try{
            mailSender.send(msg);
        }
        catch(MailException ex) {
            logger.error(ex.getMessage());
        }
    }
    
    public UserDTO findUserById(int id) {
        return userDao.findUserById(id);
    }

    public List<UserDTO> findUsers(UserDTO user) {
        return userDao.findUsers(user);
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
                matchingUser.setConfirmedRegistration(true);
                userDao.saveUser(matchingUser);
                return true;
            }
        }
        return false;

    }
}
