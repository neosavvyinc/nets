package com.neosavvy.user.service;

import com.neosavvy.user.dto.companyManagement.SecurityWrapperDTO;
import com.neosavvy.user.dto.companyManagement.UserDTO;
import com.neosavvy.user.service.exception.UserServiceException;
import fineline.focal.common.types.v1.StorageServiceFileRef;
import org.springframework.context.annotation.Scope;
import org.springframework.mail.MailSender;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import javax.ws.rs.FormParam;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
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

public interface UserService {

    @Secured({"ROLE_EMPLOYEE", "OBJECT_ACL_WRITE"})
	public void updateUsers(List<UserDTO> users) throws UserServiceException;

    @Secured({"ROLE_EMPLOYEE", "OBJECT_ACL_WRITE"})
	public void updateUser(UserDTO user) throws UserServiceException;

    @Secured({"ROLE_ADMIN", "AFTER_ACL_READ"})
	public UserDTO findUserById(long id);

    @Secured({"ROLE_ADMIN", "AFTER_ACL_COLLECTION_READ"})
	public List<UserDTO> findUsers(UserDTO user);

    @Secured({"ROLE_ADMIN", "OBJECT_ACL_DELETE"})
	public void deleteUser(UserDTO user);


    @Secured({"ROLE_ADMIN", "OBJECT_ACL_WRITE"})
    public void resetPassword(UserDTO user);

    public void resetPasswordForUser(String username);
    
    public boolean confirmUser(String userName, String hashCode);
    public SecurityWrapperDTO getUserDetails();

    @Secured({"ROLE_EMPLOYEE", "OBJECT_ACL_WRITE"})
    public void associateReceiptUploadWithUser(UserDTO user, StorageServiceFileRef fileRef);

    @Secured({"ROLE_EMPLOYEE", "OBJECT_ACL_WRITE"})
    public void disassociateReceiptUploadWithUser(UserDTO user, StorageServiceFileRef fileRef);




}
