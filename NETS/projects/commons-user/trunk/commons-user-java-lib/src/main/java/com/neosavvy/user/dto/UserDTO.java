package com.neosavvy.user.dto;

import javax.persistence.*;
import javax.ws.rs.FormParam;
import javax.xml.bind.annotation.XmlRootElement;
import java.util.Set;

@Entity
@Table(
    name="USER" ,
    uniqueConstraints = {
            @UniqueConstraint(columnNames = {"ID"})
            ,@UniqueConstraint(columnNames = {"USERNAME"})
    }
)
@XmlRootElement
public class UserDTO extends BaseUserDTO{// implements Externalizable {


    @Column(name="USERNAME")
    private String username;

	@Column(name="PASSWORD")
	private String password;

    @Column(name="REG_TOKEN")
    private String registrationToken;

    @Column(name="ACTIVE")
    private Boolean active = true;

    @Column(name="CONFIRMED_REGISTRATION")
    private Boolean confirmedRegistration = true;

    @OneToMany(mappedBy="user", fetch=FetchType.EAGER)
    private Set<UserCompanyRoleDTO> userCompanyRoles;

    public String getUsername() {
        return username;
    }
    @FormParam("userName")
    public void setUsername(String username) {
        this.username = username;
    }
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}

    public String getRegistrationToken() {
        return registrationToken;
    }

    public void setRegistrationToken(String registrationToken) {
        this.registrationToken = registrationToken;
    }

    public void setActive( Boolean active) {
        this.active = active;
    }

    public Boolean getActive() {
        return this.active;
    }

    public Set<UserCompanyRoleDTO> getUserCompanyRoles() {
        return userCompanyRoles;
    }

    public void setUserCompanyRoles(Set<UserCompanyRoleDTO> userCompanyRoles) {
        this.userCompanyRoles = userCompanyRoles;
    }

    public Boolean getConfirmedRegistration() {
        return confirmedRegistration;
    }

    public void setConfirmedRegistration(Boolean confirmedRegistration) {
        this.confirmedRegistration = confirmedRegistration;
    }
}
