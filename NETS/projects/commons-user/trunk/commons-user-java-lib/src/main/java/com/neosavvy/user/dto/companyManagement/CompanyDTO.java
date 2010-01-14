package com.neosavvy.user.dto.companyManagement;



import flex.messaging.annotations.FlexClass;
import flex.messaging.annotations.FlexField;
import flex.messaging.annotations.IAnnotatedProxy;

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
@FlexClass(classType= FlexClass.FlexClassType.RemoteObject)
public class CompanyDTO extends AbstractCompany implements IAnnotatedProxy {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "company_id_seq")
    @SequenceGenerator(name = "company_id_seq", sequenceName = "company_id_seq", allocationSize=1)
    @Column(name="ID")
    private Long id;

    @OneToMany(mappedBy="company", fetch=FetchType.LAZY)
    private Set<UserCompanyRoleDTO> userCompanyRoles;

    @OneToMany(mappedBy="company", fetch=FetchType.LAZY)
    private Set<UserInviteDTO> userInvites;

    @FlexField(fieldType = FlexField.FlexFieldType.Excluded)
    public Set<UserCompanyRoleDTO> getUserCompanyRoles() {
        return userCompanyRoles;
    }

    public void setUserCompanyRoles(Set<UserCompanyRoleDTO> userCompanyRoles) {
        this.userCompanyRoles = userCompanyRoles;
    }

    @FlexField(fieldType = FlexField.FlexFieldType.Excluded)
    public Set<UserInviteDTO> getUserInvites() {
        return userInvites;
    }

    public void setUserInvites(Set<UserInviteDTO> userInvites) {
        this.userInvites = userInvites;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }
}
