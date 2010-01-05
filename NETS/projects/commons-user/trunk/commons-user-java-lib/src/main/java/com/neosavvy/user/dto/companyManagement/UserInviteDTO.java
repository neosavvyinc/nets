package com.neosavvy.user.dto.companyManagement;

import com.neosavvy.user.dto.base.BaseUserDTO;

import javax.persistence.*;

/**
 * Created by IntelliJ IDEA.
 * User: lgleason
 * Date: Dec 18, 2009
 * Time: 11:57:55 PM
 */
@Entity
@Table(
    name="USER_INVITE" ,
    uniqueConstraints = {
            @UniqueConstraint(columnNames = {"ID"})
    }
)
public class UserInviteDTO extends BaseUserDTO {

    @ManyToOne
    @JoinColumn(name="COMPANY_FK")
    private CompanyDTO company;

    @Column(name="REGISTRATION_TOKEN")
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