package com.neosavvy.user.service;

import com.neosavvy.user.dto.UserDTO;
import com.neosavvy.user.dao.UserDAO;

import java.util.List;

import org.springframework.transaction.annotation.Transactional;

@Transactional
public class UserServiceImpl implements UserService {

    UserDAO userDao;

    public void setUserDao(UserDAO userDao) {
        this.userDao = userDao;
    }

    public UserDAO getUserDao() {
        return userDao;
    }
    
    public List<UserDTO> getUsers() {
        return userDao.getUsers();
    }

    public void saveUser(UserDTO user) {
        userDao.saveUser(user);
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

    public Boolean login(UserDTO user) {
        return null;  //To change body of implemented methods use File | Settings | File Templates.
    }

    public Boolean logout(UserDTO user) {
        return null;  //To change body of implemented methods use File | Settings | File Templates.
    }
}
