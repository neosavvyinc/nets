package com.neosavvy.user.dto.companyManagement;



import javax.persistence.*;
import javax.xml.bind.annotation.XmlRootElement;
import java.util.Set;

/**
 * Created by IntelliJ IDEA.
 * User: lgleason
 * Date: Nov 27, 2009
 * Time: 2:03:57 PM
 */
@Entity
@Table(
    name="COMPANY" ,
    uniqueConstraints = {
            @UniqueConstraint(columnNames = {"ID"})
    }
)
public class CompanyDTO extends AbstractCompany {

    @OneToMany(mappedBy="company", fetch=FetchType.EAGER)
    private Set<UserCompanyRoleDTO> userCompanyRoles;

    @OneToMany(mappedBy="company", fetch=FetchType.EAGER)
    private Set<UserInviteDTO> userInvites;

    public Set<UserCompanyRoleDTO> getUserCompanyRoles() {
        return userCompanyRoles;
    }

    public void setUserCompanyRoles(Set<UserCompanyRoleDTO> userCompanyRoles) {
        this.userCompanyRoles = userCompanyRoles;
    }

    public Set<UserInviteDTO> getUserInvites() {
        return userInvites;
    }

    public void setUserInvites(Set<UserInviteDTO> userInvites) {
        this.userInvites = userInvites;
    }
}
