package com.neosavvy.user.service.mail;

import groovy.text.Template;

import java.util.Date;


/**
 * This class is a derivative work of Fineline via Tommy Odom.
 * The code herein cannot be distributed without first establishing prior written consent
 * from tommy.odom@gmail.com
 */
public class CachedTemplate
{
    private Template template;
    private Date cacheDate;
    
    public Template getTemplate() {
        return template;
    }
    public void setTemplate(Template template) {
        this.template = template;
    }
    public Date getCacheDate() {
        return cacheDate;
    }
    public void setCacheDate(Date cacheDate) {
        this.cacheDate = cacheDate;
    }
}
