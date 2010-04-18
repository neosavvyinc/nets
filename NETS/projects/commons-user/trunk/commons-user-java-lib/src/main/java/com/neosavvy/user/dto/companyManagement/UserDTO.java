package com.neosavvy.user.dto.companyManagement;

import com.neosavvy.security.SecuredObject;
import com.neosavvy.user.dto.base.BaseUserDTO;
import com.neosavvy.user.dto.project.Project;
import fineline.focal.common.types.v1.EntityListenerManager;
import fineline.focal.common.types.v1.StorageServiceFileRef;
import flex.messaging.annotations.FlexClass;
import flex.messaging.annotations.FlexField;
import flex.messaging.annotations.IAnnotatedProxy;

import javax.persistence.*;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;
import java.util.List;
import java.util.Set;

@Entity
@Table(
    name="USERS" ,
    uniqueConstraints = {
            @UniqueConstraint(columnNames = {"ID"})
            ,@UniqueConstraint(columnNames = {"USERNAME"})
    }
)
@FlexClass(classType= FlexClass.FlexClassType.RemoteObject)
@EntityListeners(EntityListenerManager.class)
@XmlRootElement(namespace = "urn:com:neosavvy:user:dto:companyManagement")
public class UserDTO extends BaseUserDTO implements IAnnotatedProxy, SecuredObject<UserDTO> {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "users_id_seq")
    @SequenceGenerator(name = "users_id_seq", sequenceName = "users_id_seq", allocationSize=1)
    @Column(name="ID")
    private Long id;

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

    @ManyToMany(mappedBy="participants", fetch=FetchType.EAGER)
    private List<Project> participantOfProjects;

    @ManyToMany(mappedBy="approvers")
    private List<Project> approversOfProjects;

    @OneToMany(fetch=FetchType.EAGER)
    private List<StorageServiceFileRef> uncategorizedReceipts;

    @XmlElement(required = true)
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }
    @XmlElement(required = true)
    public String getUsername() {
        return username;
    }
    public void setUsername(String username) {
        this.username = username;
    }
    @XmlTransient
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}

    @XmlTransient
    public String getRegistrationToken() {
        return registrationToken;
    }

    public void setRegistrationToken(String registrationToken) {
        this.registrationToken = registrationToken;
    }

    public void setActive( Boolean active) {
        this.active = active;
    }

    @XmlElement(required = true)
    public Boolean getActive() {
        return this.active;
    }

    @XmlTransient
    public Set<UserCompanyRoleDTO> getUserCompanyRoles() {
        return userCompanyRoles;
    }

    public void setUserCompanyRoles(Set<UserCompanyRoleDTO> userCompanyRoles) {
        this.userCompanyRoles = userCompanyRoles;
    }

    @XmlElement(required = true)
    public Boolean getConfirmedRegistration() {
        return confirmedRegistration;
    }

    public void setConfirmedRegistration(Boolean confirmedRegistration) {
        this.confirmedRegistration = confirmedRegistration;
    }

    @XmlTransient
    public SecuredObject getAclParentObject() {
        if (getUserCompanyRoles() == null) {
            return null;
        }

        for (UserCompanyRoleDTO role : getUserCompanyRoles()) {
            return role.getCompany();
        }

        return null;
    }

    @XmlTransient
    public Class getAclParentClass() {
        return CompanyDTO.class;
    }

    public Class<UserDTO> getAclClass() {
        return UserDTO.class;
    }

    @XmlTransient
    public String getOwnerUsername() {
        return getUsername();
    }

    @XmlTransient
    @FlexField(fieldType = FlexField.FlexFieldType.Excluded)
    public List<Project> getApproversOfProjects() {
        return approversOfProjects;
    }

    public void setApproversOfProjects(List<Project> approversOfProjects) {
        this.approversOfProjects = approversOfProjects;
    }

    @XmlTransient
    @FlexField(fieldType = FlexField.FlexFieldType.Excluded)
    public List<Project> getParticipantOfProjects() {
        return participantOfProjects;
    }

    public void setParticipantOfProjects(List<Project> participantOfProjects) {
        this.participantOfProjects = participantOfProjects;
    }

    public UserDTO() {
        super();
    }

    @XmlTransient
    @FlexField(fieldType = FlexField.FlexFieldType.Excluded)
    public List<StorageServiceFileRef> getUncategorizedReceipts() {
        return uncategorizedReceipts;
    }

    public void setUncategorizedReceipts(List<StorageServiceFileRef> uncategorizedReceipts) {
        this.uncategorizedReceipts = uncategorizedReceipts;
    }
}
