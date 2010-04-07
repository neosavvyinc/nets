package com.neosavvy.user.dto.companyManagement;

import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;


/**
 * User: adamparrish
 * Date: Dec 20, 2009
 * Time: 6:53:09 PM
 */
@XmlRootElement(namespace = "urn:com:neosavvy:user:dto:companyManagement")
public class SecurityWrapperDTO {

    private String name;
    private UserDTO user;
    private String[] authorities;

    public SecurityWrapperDTO() {
    }

    public SecurityWrapperDTO(String userName, String[] authortiesAsStrings) {
        this.name = userName;
        this.authorities = authortiesAsStrings;
    }

    @XmlElement(required = true)
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @XmlElement(required = true)
    public String[] getAuthorities() {
        return authorities;
    }

    public void setAuthorities(String[] authorities) {
        this.authorities = authorities;
    }

    @XmlElement(required = true)
    public UserDTO getUser() {
        return user;
    }

    public void setUser(UserDTO user) {
        this.user = user;
    }
}
