package com.neosavvy.user.service;

import com.neosavvy.user.dto.companyManagement.SecurityWrapperDTO;
import com.neosavvy.user.dto.companyManagement.UserDTO;
import org.springframework.security.annotation.Secured;
import org.springframework.mail.MailSender;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/*************************************************************************
 *
 * NEOSAVVY CONFIDENTIAL
 * __________________
 *
 *  Copyright 2008 - 2009 Neosavvy Incorporated
 *  All Rights Reserved.
 *
 * NOTICE:  All information contained herein is, and remains
 * the property of Neosavvy Incorporated and its suppliers,
 * if any.  The intellectual and technical concepts contained
 * herein are proprietary to Neosavvy Incorporated
 * and its suppliers and may be covered by U.S. and Foreign Patents,
 * patents in process, and are protected by trade secret or copyright law.
 * Dissemination of this information or reproduction of this material
 * is strictly forbidden unless prior written permission is obtained
 * from Neosavvy Incorporated.
 **************************************************************************/

/**
 * User: adamparrish
 * Date: Jan 6, 2010
 * Time: 1:04:18 PM
 */
@Transactional
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

    @Secured("ROLE_ADMIN")
    public SecurityWrapperDTO checkUserLoggedIn();

    @Secured("ROLE_ADMIN")
    public void resetPassword(UserDTO user);

    public boolean confirmUser(String userName, String hashCode);

    public void setMailSender(MailSender mailSender);

    public void createAdminUser(UserDTO user);
}
