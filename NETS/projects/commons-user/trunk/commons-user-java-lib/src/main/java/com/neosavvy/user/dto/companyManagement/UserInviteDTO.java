package com.neosavvy.user.dto.companyManagement;

import com.neosavvy.security.SecuredObject;
import com.neosavvy.user.dto.base.BaseUserDTO;
import fineline.focal.common.types.v1.EntityListenerManager;

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
@EntityListeners(EntityListenerManager.class)
public class UserInviteDTO extends BaseUserDTO implements SecuredObject<UserInviteDTO> {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "user_invite_id_seq")
    @SequenceGenerator(name = "user_invite_id_seq", sequenceName = "user_invite_id_seq", allocationSize=1)
    @Column(name="ID")
    private Long id;

    @ManyToOne
    @JoinColumn(name="COMPANY_FK")
    private CompanyDTO company;

    @Column(name="REGISTRATION_TOKEN")
    private String registrationToken;

    public UserInviteDTO() {
        super();
    }

    public UserInviteDTO(BaseUserDTO baseCopy) {
        super(baseCopy);
    }
    
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

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

    public SecuredObject getAclParentObject() {
        return getCompany();
    }

    public Class getAclParentClass() {
        return CompanyDTO.class;
    }

    public String getOwnerUsername() {
        return null;
    }

    public Class<UserInviteDTO> getAclClass() {
        return UserInviteDTO.class;
    }
}
