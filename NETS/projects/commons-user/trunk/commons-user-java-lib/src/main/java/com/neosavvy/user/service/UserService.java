package com.neosavvy.user.service;

import com.neosavvy.user.dto.UserDTO;
import com.neosavvy.user.dao.UserDAO;
import org.springframework.security.annotation.Secured;
import org.springframework.mail.MailSender;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

public interface UserService {

    @Secured("ROLE_ADMIN")
	public List<UserDTO> getUsers();

	public void saveUser(UserDTO user);

    @Secured("ROLE_ADMIN")
	public UserDTO findUserById(int id);

    @Secured("ROLE_ADMIN")
	public List<UserDTO> findUsers(UserDTO user);

    @Secured("ROLE_ADMIN")
	public void deleteUser(UserDTO user);

    public boolean confirmUser(String userName, String hashCode);

    public void setMailSender(MailSender mailSender);
}
