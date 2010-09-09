package com.neosavvy.user.service;

import com.neosavvy.user.dto.companyManagement.CompanyDTO;
import com.neosavvy.user.dto.companyManagement.UserDTO;
import com.neosavvy.user.dto.companyManagement.UserInviteDTO;
import com.neosavvy.user.dto.mail.MailMessageDTO;
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
 * Date: Jan 17, 2010
 * Time: 8:46:54 PM
 */
public interface MailService {

    public void resetPasswordForUserEmail(UserDTO user);

    public void newUserConfirmationTokenEmail(UserDTO user);

    public void sendInvite(UserInviteDTO userInvite);

    public void newUserConfirmationEmail(UserDTO user, CompanyDTO company);

    public void sendSystemMail( MailMessageDTO message );
    
}
