package com.neosavvy.user.dto;



import javax.persistence.*;
import javax.xml.bind.annotation.XmlRootElement;
import javax.ws.rs.FormParam;
import java.util.Set;

/**
 * Created by IntelliJ IDEA.
 * User: lgleason
 * Date: Nov 27, 2009
 * Time: 2:03:57 PM
 * To change this template use File | Settings | File Templates.
 */
@Entity
@Table(
    name="COMPANY" ,
    uniqueConstraints = {
            @UniqueConstraint(columnNames = {"ID"})
    }
)
@XmlRootElement
public class CompanyDTO extends AbstractCompany {

    @OneToMany(mappedBy="company", fetch=FetchType.EAGER)
    private Set<UserCompanyRoleDTO> userCompanyRoles;

    @OneToMany(mappedBy="company", fetch=FetchType.EAGER)
    private Set<UserInviteDTO> userInvites;

    @ManyToOne
    @JoinColumn(name="NUM_EMPLOYEES_RANGE_FK")
    private NumEmployeesRangeDTO numEmployeesRange;


    public NumEmployeesRangeDTO getNumEmployeesRange() {
        return numEmployeesRange;
    }

    public void setNumEmployeesRange(NumEmployeesRangeDTO numEmployeesRange) {
        this.numEmployeesRange = numEmployeesRange;
    }

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
