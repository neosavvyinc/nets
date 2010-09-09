package com.neosavvy.user.service;

import com.neosavvy.user.dto.companyManagement.CompanyDTO;
import com.neosavvy.user.dto.companyManagement.UserDTO;
import com.neosavvy.user.dto.companyManagement.UserInviteDTO;
import com.neosavvy.user.dto.mail.MailMessageDTO;
import com.neosavvy.user.service.exception.MailServiceException;
import com.neosavvy.user.service.exception.UserServiceException;
import com.neosavvy.user.service.mail.DocumentGenerationException;
import com.neosavvy.user.service.mail.DocumentGenerator;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.core.io.Resource;
import org.springframework.mail.MailException;
import org.springframework.mail.MailSender;
import org.springframework.mail.SimpleMailMessage;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
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

    private static final Logger logger = LoggerFactory.getLogger(MailServiceImpl.class);

    private MailSender mailSender;
    private DocumentGenerator docGenerator;

    private Resource resetPasswordForUserEmail;
    private Resource newUserConfirmationTokenEmail;
    private Resource sendInvite;
    private Resource newUserConfirmationEmail;
    private Resource systemMailTemplate;
    private Resource systemConfirmationMailTemplate;

    private String serverFromAddress = "nets@neosavvy.com";

    public MailSender getMailSender() {
        return mailSender;
    }

    public void setMailSender(MailSender mailSender) {
        this.mailSender = mailSender;
    }

    public void resetPasswordForUserEmail(UserDTO user) {
        SimpleMailMessage msg = new SimpleMailMessage();

        msg.setFrom(serverFromAddress);
        msg.setTo(user.getEmailAddress());
        msg.setSubject("Password reset email for expense tracker");

        try {
            Map<String, Object> bindings = new HashMap<String, Object>();
            bindings.put("password", user.getPassword());
            msg.setText( docGenerator.processTemplate(resetPasswordForUserEmail.getURL(), bindings) );
        } catch (IOException e) {
            logger.error("The email template could not be found", e);
            throw new MailServiceException("The email template could not be found", e);
        } catch (DocumentGenerationException e) {
            logger.error("Unable to send the reset password email" + user.toString(), e);
            throw new MailServiceException("An error occurred generating the quote summary message body", e);
        }

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
        msg.setFrom(serverFromAddress);
        msg.setTo(user.getEmailAddress());
        msg.setSubject("Confirm that you have just been added as the admin user for your company's expense tracking system");

        try {
            Map<String, Object> bindings = new HashMap<String, Object>();
            bindings.put("registrationToken", user.getRegistrationToken());
            msg.setText( docGenerator.processTemplate(newUserConfirmationTokenEmail.getURL(), bindings) );
        } catch (IOException e) {
            logger.error("The email template could not be found", e);
            throw new MailServiceException("The email template could not be found", e);
        }
        catch (DocumentGenerationException e) {
            logger.error("Unable to send the invite for the user registration" + user.toString(), e);
            throw new MailServiceException("An error occurred generating the quote summary message body", e);
        }

        try{
            mailSender.send(msg);
        }
        catch(MailException ex) {
            logger.error(ex.getMessage());
        }
    }

    public void sendInvite(UserInviteDTO userInvite){
        SimpleMailMessage msg = new SimpleMailMessage();
        msg.setFrom(serverFromAddress);
        msg.setTo(userInvite.getEmailAddress());
        msg.setSubject("Welcome to your company's expense tracking tool");

        try {
            Map<String, Object> bindings = new HashMap<String, Object>();
            bindings.put("registrationToken", userInvite.getRegistrationToken());
            msg.setText( docGenerator.processTemplate(sendInvite.getURL(), bindings) );
        } catch (IOException e) {
            logger.error("The email template could not be found", e);
            throw new MailServiceException("The email template could not be found", e);
        }
        catch (DocumentGenerationException e) {
            logger.error("Unable to send the invite for the user registration" + userInvite.toString(), e);
            throw new MailServiceException("An error occurred generating the quote summary message body", e);
        }

        try{
            mailSender.send(msg);
        }
        catch(MailException ex) {
            logger.error(ex.getMessage());
        }
    }

    public void newUserConfirmationEmail(UserDTO user, CompanyDTO company) {
        SimpleMailMessage msg = new SimpleMailMessage();
        msg.setFrom(serverFromAddress);
        msg.setTo(user.getEmailAddress());
        msg.setSubject("Welcome to " + company.getCompanyName()+ "'s expense tracking system");

        try {
            Map<String, Object> bindings = new HashMap<String, Object>();
            bindings.put("username", user.getUsername());
            bindings.put("password", user.getPassword());
            msg.setText( docGenerator.processTemplate(newUserConfirmationEmail.getURL(), bindings) );
        } catch (IOException e) {
            logger.error("The email template could not be found", e);
            throw new MailServiceException("The email template could not be found", e);
        }
        catch (DocumentGenerationException e) {
            logger.error("Unable to create body for new user confirmation - the message was not setn", e);
            throw new MailServiceException("An error occurred generating the quote summary message body", e);
        }

        try{
            mailSender.send(msg);
        }
        catch(MailException ex) {
            logger.error(ex.getMessage());
        }
    }

    public void sendSystemMail(MailMessageDTO message) {
        SimpleMailMessage msg = new SimpleMailMessage();
        msg.setFrom(serverFromAddress);
        msg.setTo(serverFromAddress);
        msg.setSubject(message.getSubject());

        sendSystemMailMessage(message, msg);


        try {
            SimpleMailMessage confirmationMessage = new SimpleMailMessage();
            confirmationMessage.setFrom(serverFromAddress);
            confirmationMessage.setTo(message.getFrom());
            confirmationMessage.setSubject("Thanks for reaching out to us!");
            confirmationMessage.setText( docGenerator.processTemplate(systemConfirmationMailTemplate.getURL(),new HashMap()));
            mailSender.send(confirmationMessage);
        }
        catch (IOException e) {
            logger.error("The email template could not be found", e);
            throw new MailServiceException("The email template could not be found", e);
        }
        catch (DocumentGenerationException e) {
            logger.error("Unable to create system message - the message was not sent", e);
            throw new MailServiceException("An error occurred generating the quote summary message body", e);
        }
        catch ( MailException ex ) {
            logger.error(ex.getMessage());
        }


    }

    private void sendSystemMailMessage(MailMessageDTO message, SimpleMailMessage msg) {
        try {
            Map<String, Object> bindings = new HashMap<String, Object>();
            bindings.put("fromEmail", message.getFrom());
            bindings.put("message", message.getMessage());
            msg.setText( docGenerator.processTemplate(systemMailTemplate.getURL(), bindings));
        } catch (IOException e) {
            logger.error("The email template could not be found", e);
            throw new MailServiceException("The email template could not be found", e);
        }
        catch (DocumentGenerationException e) {
            logger.error("Unable to create system message - the message was not sent", e);
            throw new MailServiceException("An error occurred generating the quote summary message body", e);
        }

        try {
            mailSender.send(msg);
        }
        catch ( MailException ex ) {
            logger.error(ex.getMessage());
        }
    }

    public void setDocGenerator(DocumentGenerator docGenerator) {
        this.docGenerator = docGenerator;
    }

    public DocumentGenerator getDocGenerator() {
        return docGenerator;
    }

    public void setResetPasswordForUserEmail(Resource resetPasswordForUserEmail) {
        this.resetPasswordForUserEmail = resetPasswordForUserEmail;
    }

    public Resource getResetPasswordForUserEmail() {
        return resetPasswordForUserEmail;
    }

    public void setNewUserConfirmationTokenEmail(Resource newUserConfirmationTokenEmail) {
        this.newUserConfirmationTokenEmail = newUserConfirmationTokenEmail;
    }

    public Resource getNewUserConfirmationTokenEmail() {
        return newUserConfirmationTokenEmail;
    }

    public void setSendInvite(Resource sendInvite) {
        this.sendInvite = sendInvite;
    }

    public Resource getSendInvite() {
        return sendInvite;
    }

    public void setNewUserConfirmationEmail(Resource newUserConfirmationEmail) {
        this.newUserConfirmationEmail = newUserConfirmationEmail;
    }

    public Resource getNewUserConfirmationEmail() {
        return newUserConfirmationEmail;
    }

    public String getServerFromAddress() {
        return serverFromAddress;
    }

    public void setServerFromAddress(String serverFromAddress) {
        this.serverFromAddress = serverFromAddress;
    }

    public Resource getSystemMailTemplate() {
        return systemMailTemplate;
    }

    public void setSystemMailTemplate(Resource systemMailTemplate) {
        this.systemMailTemplate = systemMailTemplate;
    }

    public Resource getSystemConfirmationMailTemplate() {
        return systemConfirmationMailTemplate;
    }

    public void setSystemConfirmationMailTemplate(Resource systemConfirmationMailTemplate) {
        this.systemConfirmationMailTemplate = systemConfirmationMailTemplate;
    }
}
