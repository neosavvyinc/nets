package com.neosavvy.user.dto.companyManagement;



import com.neosavvy.security.SecuredObject;
import fineline.focal.common.types.v1.EntityListenerManager;
import flex.messaging.annotations.FlexClass;
import flex.messaging.annotations.FlexField;
import flex.messaging.annotations.IAnnotatedProxy;

import javax.persistence.*;
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
@EntityListeners(EntityListenerManager.class)
public class CompanyDTO extends AbstractCompany implements IAnnotatedProxy, SecuredObject<CompanyDTO> {
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

    public SecuredObject getAclParentObject() {
        return null;
    }

    public Class getAclParentClass() {
        return Object.class;
    }

    public Class<CompanyDTO> getAclClass() {
        return CompanyDTO.class;
    }

    public String getOwnerUsername() {
        if (getUserCompanyRoles() != null) {
            for (UserCompanyRoleDTO userRole : getUserCompanyRoles()) {
                if (userRole.getRole() != null && userRole.getRole().equals(RoleDTO.ADMIN_ROLE)) {
                    return userRole.getUser().getUsername();
                }
            }
        }

        return null;
    }

    public CompanyDTO() {
        super();
    }
}
