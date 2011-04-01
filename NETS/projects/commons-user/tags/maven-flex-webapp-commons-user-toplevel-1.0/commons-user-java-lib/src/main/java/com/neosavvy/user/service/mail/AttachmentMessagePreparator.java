package com.neosavvy.user.service.mail;

import java.util.ArrayList;
import java.util.List;

import javax.activation.DataSource;
import javax.mail.MessagingException;

import org.springframework.mail.javamail.MimeMessageHelper;

/**
 * This class is a derivative work of Fineline via Tommy Odom.
 * The code herein cannot be distributed without first establishing prior written consent
 * from tommy.odom@gmail.com
 */
public class AttachmentMessagePreparator extends SimpleHTMLMessagePreparator
{
    private List<DataSource> attachments = new ArrayList<DataSource>();
    
    public AttachmentMessagePreparator() {
        
    }

    public AttachmentMessagePreparator(AttachmentMessagePreparator source) {
        super(source);
    }
    
    public void addAttachment(DataSource attachment) {
        attachments.add(attachment);
    }
    
    @Override
    protected void prepare(MimeMessageHelper message) throws MessagingException {
        super.prepare(message);
        
        for (DataSource attachment : attachments) {
            message.addAttachment(attachment.getName(), attachment);
        }
    }
}
