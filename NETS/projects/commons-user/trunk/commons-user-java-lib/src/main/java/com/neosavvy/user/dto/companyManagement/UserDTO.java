package com.neosavvy.user.dto.companyManagement;

import com.neosavvy.security.SecuredObject;
import com.neosavvy.user.dto.base.BaseUserDTO;
import com.neosavvy.user.dto.project.Project;
import fineline.focal.common.types.v1.EntityListenerManager;
import flex.messaging.annotations.FlexClass;
import flex.messaging.annotations.IAnnotatedProxy;

import javax.persistence.*;
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

    @ManyToMany
    @JoinTable(
        name="PROJECT_PARTICIPANTS",
        joinColumns=
             @JoinColumn(name="USER_ID", referencedColumnName="ID"),
        inverseJoinColumns=
            @JoinColumn(name="PROJECT_ID", referencedColumnName="ID")
    )
    private List<Project> participantOfProjects;

    @ManyToMany
    @JoinTable(
        name="PROJECT_APPROVERS",
        joinColumns=
             @JoinColumn(name="USER_ID", referencedColumnName="ID"),
        inverseJoinColumns=
            @JoinColumn(name="PROJECT_ID", referencedColumnName="ID")
    )
    private List<Project> approversOfProjects;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }
    public String getUsername() {
        return username;
    }
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

    public SecuredObject getAclParentObject() {
        if (getUserCompanyRoles() == null) {
            return null;
        }

        for (UserCompanyRoleDTO role : getUserCompanyRoles()) {
            return role.getCompany();
        }

        return null;
    }

    public Class getAclParentClass() {
        return CompanyDTO.class;
    }

    public Class<UserDTO> getAclClass() {
        return UserDTO.class;
    }

    public String getOwnerUsername() {
        return getUsername();
    }

    public List<Project> getApproversOfProjects() {
        return approversOfProjects;
    }

    public void setApproversOfProjects(List<Project> approversOfProjects) {
        this.approversOfProjects = approversOfProjects;
    }

    public List<Project> getParticipantOfProjects() {
        return participantOfProjects;
    }

    public void setParticipantOfProjects(List<Project> participantOfProjects) {
        this.participantOfProjects = participantOfProjects;
    }

    public UserDTO() {
        super();
    }

    
}
