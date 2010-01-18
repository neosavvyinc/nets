package com.neosavvy.user.service;

import com.neosavvy.user.dto.companyManagement.CompanyDTO;
import com.neosavvy.user.dto.companyManagement.UserDTO;
import com.neosavvy.user.dto.companyManagement.UserInviteDTO;
import com.neosavvy.user.service.exception.UserServiceException;
import org.apache.log4j.Logger;
import org.springframework.mail.MailException;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
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
 * Time: 8:47:03 PM
 */
public class MailServiceImpl implements MailService {

    private static final Logger logger = Logger.getLogger(MailServiceImpl.class);

    private JavaMailSender mailSender;

    public JavaMailSender getMailSender() {
        return mailSender;
    }

    public void setMailSender(JavaMailSender mailSender) {
        this.mailSender = mailSender;
    }

    public void resetPasswordForUserEmail(UserDTO user) {
        SimpleMailMessage msg = new SimpleMailMessage();
        msg.setFrom("customerservice@mycompany.com");
        msg.setTo(user.getEmailAddress());
        msg.setText("Your new password is: " + user.getPassword());
        msg.setSubject("Password reset email for expense tracker");
        try {
            mailSender.send(msg);
        }
        catch (MailException ex) {
            logger.error(ex.getMessage());
            throw new UserServiceException("Unable to mail the password to user: " + user.toString(), ex);
        }
    }

    public void newUserConfirmationTokenEmail(UserDTO user) {
        SimpleMailMessage msg = new SimpleMailMessage();
        msg.setFrom("customerservice@mycompany.com");
        msg.setTo(user.getEmailAddress());
        msg.setSubject("Confirm that you have just been added as the admin user for your company's expense tracking system");
        msg.setText("Use your registration token to confirm that you are actually whom you say you are. \n\nThis is your registration token: " + user.getRegistrationToken());
        try{
            mailSender.send(msg);
        }
        catch(MailException ex) {
            logger.error(ex.getMessage());
        }
    }

    public void sendInvite(UserInviteDTO userInvite){
        SimpleMailMessage msg = new SimpleMailMessage();
        msg.setFrom("customerservice@mycompany.com");
        msg.setTo(userInvite.getEmailAddress());
        msg.setSubject("Welcome to your company's expense tracking tool");
        msg.setText("This is an invite to join your company's expense tracking tool!!!\n\nUse this key as your confirmation: " + userInvite.getRegistrationToken());
        try{
            mailSender.send(msg);
        }
        catch(MailException ex) {
            logger.error(ex.getMessage());
        }
    }

    public void newUserConfirmationEmail(UserDTO user, CompanyDTO company) {
        SimpleMailMessage msg = new SimpleMailMessage();
        msg.setFrom("customerservice@company.com");
        msg.setTo(user.getEmailAddress());
        msg.setSubject("Welcome to " + company.getCompanyName()+ "'s expense tracking system");
        msg.setText(
            "username: " + user.getUsername() + "\n"
            + "password: "+ user.getPassword() + "\n"
            + "\n\n\nThanks, Expense Tracking Team!");
        try{
            mailSender.send(msg);
        }
        catch(MailException ex) {
            logger.error(ex.getMessage());
        }
    }
    
}
