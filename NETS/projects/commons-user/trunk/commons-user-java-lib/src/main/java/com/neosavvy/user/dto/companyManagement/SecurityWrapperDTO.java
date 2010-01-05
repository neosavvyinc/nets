package com.neosavvy.user.dto.companyManagement;


/**
 * User: adamparrish
 * Date: Dec 20, 2009
 * Time: 6:53:09 PM
 */
public class SecurityWrapperDTO {

    private String name;
    private String[] authorities;

    public SecurityWrapperDTO(String userName, String[] authortiesAsStrings) {
        this.name = userName;
        this.authorities = authortiesAsStrings;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String[] getAuthorities() {
        return authorities;
    }

    public void setAuthorities(String[] authorities) {
        this.authorities = authorities;
    }
}
