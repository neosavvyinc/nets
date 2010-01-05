package com.neosavvy.user.dto.companyManagement;

import javax.persistence.*;
import javax.xml.bind.annotation.XmlRootElement;
import java.util.Set;

/**
 * Created by IntelliJ IDEA.
 * User: lgleason
 * Date: Nov 28, 2009
 * Time: 3:54:52 AM
 */

@Entity
@Table(
    name="ROLE" ,
    uniqueConstraints = {
            @UniqueConstraint(columnNames = {"ID"}),
            @UniqueConstraint(columnNames = {"SHORT_NAME"})
    }
)
@XmlRootElement
public class RoleDTO {
    @Id
    @GeneratedValue
	@Column(name="ID")
	private int id;

	@Column(name="SHORT_NAME")
	private String shortName;

	@Column(name="LONG_NAME")
	private String longName;

    @OneToMany(mappedBy="role", fetch = FetchType.EAGER)
    private Set<UserCompanyRoleDTO> userCompanyRoles;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getShortName() {
        return shortName;
    }

    public void setShortName(String shortName) {
        this.shortName = shortName;
    }

    public String getLongName() {
        return longName;
    }

    public void setLongName(String longName) {
        this.longName = longName;
    }

    public Set<UserCompanyRoleDTO> getUserCompanyRoles() {
        return userCompanyRoles;
    }

    public void setUserCompanyRoles(Set<UserCompanyRoleDTO> userCompanyRoles) {
        this.userCompanyRoles = userCompanyRoles;
    }
}
