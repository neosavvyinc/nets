package com.neosavvy.user.service.mail;

import javax.mail.MessagingException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.mail.javamail.MimeMessagePreparator;

import com.neosavvy.user.util.StringUtils;

/**
 * This class is a derivative work of Fineline via Tommy Odom.
 * The code herein cannot be distributed without first establishing prior written consent
 * from tommy.odom@gmail.com
 */
public class SimpleHTMLMessagePreparator implements MimeMessagePreparator
{
    private String from;
    private String to;
    private String cc;
    private String bcc;
    private String subject;
    private String body;
    private String replyTo;
    
    public SimpleHTMLMessagePreparator() {
        
    }
    
    public SimpleHTMLMessagePreparator(SimpleHTMLMessagePreparator simpleHTMLMessagePreparator) {
        this.from = simpleHTMLMessagePreparator.from;
        this.to = simpleHTMLMessagePreparator.to;
        this.cc = simpleHTMLMessagePreparator.cc;
        this.bcc = simpleHTMLMessagePreparator.bcc;
        this.subject = simpleHTMLMessagePreparator.subject;
        this.body = simpleHTMLMessagePreparator.body;
        this.replyTo = simpleHTMLMessagePreparator.replyTo;
    }

    public void prepare(MimeMessage mimeMessage) throws Exception {
        MimeMessageHelper message = new MimeMessageHelper(mimeMessage, true, "UTF-8");
        prepare(message);
    }

    protected void prepare(MimeMessageHelper message) throws MessagingException {
        message.setFrom(from);
        message.setTo(InternetAddress.parse(to));
        
        if (!StringUtils.isEmpty(cc)) {
            message.setCc(InternetAddress.parse(cc));
        }
        if (!StringUtils.isEmpty(bcc)) {
            message.setBcc(InternetAddress.parse(bcc));
        }
        if (!StringUtils.isEmpty(replyTo)) {
            message.setReplyTo(replyTo);
        }
        message.setSubject(subject);
        
        message.setText(body, true);
    }

    public String getFrom() {
        return from;
    }

    public void setFrom(String from) {
        this.from = from;
    }

    public String getTo() {
        return to;
    }

    public void setTo(String to) {
        this.to = to;
    }

    public String getCc() {
        return cc;
    }

    public void setCc(String cc) {
        this.cc = cc;
    }

    public String getBcc() {
        return bcc;
    }

    public void setBcc(String bcc) {
        this.bcc = bcc;
    }

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public String getBody() {
        return body;
    }

    public void setBody(String body) {
        this.body = body;
    }

    public String getReplyTo() {
        return replyTo;
    }

    public void setReplyTo(String replyTo) {
        this.replyTo = replyTo;
    }

}
