package com.neosavvy.user.service.mail;

import javax.mail.Address;
import javax.mail.MessagingException;
import javax.mail.Message.RecipientType;
import javax.mail.internet.MimeMessage;

import org.springframework.mail.MailException;
import org.springframework.mail.MailSendException;
import org.springframework.mail.javamail.JavaMailSenderImpl;


/**
 * This class is a derivative work of Fineline via Tommy Odom.
 * The code herein cannot be distributed without first establishing prior written consent
 * from tommy.odom@gmail.com
 */
public class FocalMailSender extends JavaMailSenderImpl
{
    private String testRecipients;
    private boolean test = false;
    
    @Override
    protected void doSend(MimeMessage[] messages, Object[] originalMessages) throws MailException {
        
        if (test) {
            try {
                for (MimeMessage message : messages) {
                    String toString = createTestString(message.getRecipients(RecipientType.TO));                    
                    String ccString = createTestString(message.getRecipients(RecipientType.CC));
                    
                    message.setSubject("TEST [To: " + toString + " Cc: " + ccString + "] " + message.getSubject());
                    message.setRecipients(RecipientType.TO, testRecipients);
                    message.setRecipients(RecipientType.CC, "");
                    message.setRecipients(RecipientType.BCC, "");
                }
            }
            catch (MessagingException e) {
                throw new MailSendException(e.getMessage(), e);
            }
        }
        
        super.doSend(messages, originalMessages);
    }

    private String createTestString(Address[] addresses) {
        StringBuilder testString = new StringBuilder();
        
        if (addresses != null) {
	        for (int i = 0; i < addresses.length; i++) {
	            testString.append(addresses[i].toString());
	            if (i < addresses.length - 1) {
	                testString.append(", ");
	            }
	        }
        }
        return testString.toString();
    }

    public String getTestRecipients() {
        return testRecipients;
    }

    public void setTestRecipients(String testRecipients) {
        this.testRecipients = testRecipients;
    }

    public boolean isTest() {
        return test;
    }

    public void setTest(boolean test) {
        this.test = test;
    }
}
