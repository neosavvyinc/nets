package com.neosavvy.user.dto;

import javax.persistence.*;

/**
 * Created by IntelliJ IDEA.
 * User: lgleason
 * Date: Dec 18, 2009
 * Time: 11:57:55 PM
 * To change this template use File | Settings | File Templates.
 */
@Entity
@Table(
    name="USER_INVITE" ,
    uniqueConstraints = {
            @UniqueConstraint(columnNames = {"ID"})
    }
)
public class UserInviteDTO extends BaseUserDTO{

    @ManyToOne
    @JoinColumn(name="COMPANY_FK")
    private CompanyDTO company;

    private String registrationToken;

    public CompanyDTO getCompany() {
        return company;
    }

    public void setCompany(CompanyDTO company) {
        this.company = company;
    }

    public String getRegistrationToken() {
        return registrationToken;
    }

    public void setRegistrationToken(String registrationToken) {
        this.registrationToken = registrationToken;
    }
}
