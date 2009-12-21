package com.neosavvy.user.dto;

import javax.persistence.*;
import javax.xml.bind.annotation.XmlRootElement;

/**
 * Created by IntelliJ IDEA.
 * User: lgleason
 * Date: Dec 8, 2009
 * Time: 10:50:05 PM
 * To change this template use File | Settings | File Templates.
 */
@Entity
@Table(
    name="USER_COMPANY_ROLE" ,
    uniqueConstraints = {
            @UniqueConstraint(columnNames = {"ID"})
    }
)
@XmlRootElement
public class UserCompanyRoleDTO {
    @Id
    @GeneratedValue
    @Column(name="ID")
    private int id;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name="COMPANY_FK")
    private CompanyDTO company;
    
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name="ROLE_FK")
    private RoleDTO role;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name="USER_FK")
    private UserDTO user;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public CompanyDTO getCompany() {
        return company;
    }

    public void setCompany(CompanyDTO company) {
        this.company = company;
    }

    public RoleDTO getRole() {
        return role;
    }

    public void setRole(RoleDTO role) {
        this.role = role;
    }

    public UserDTO getUser() {
        return user;
    }

    public void setUser(UserDTO user) {
        this.user = user;
    }
}
