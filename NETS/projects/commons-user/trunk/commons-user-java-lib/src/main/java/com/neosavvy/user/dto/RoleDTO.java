package com.neosavvy.user.dto;

import javax.persistence.*;
import javax.xml.bind.annotation.XmlRootElement;
import java.util.Set;
import java.util.LinkedHashSet;

/**
 * Created by IntelliJ IDEA.
 * User: lgleason
 * Date: Nov 28, 2009
 * Time: 3:54:52 AM
 * To change this template use File | Settings | File Templates.
 */

@Entity
@Table(
    name="ROLE" ,
    uniqueConstraints = {
            @UniqueConstraint(columnNames = {"ROLE_ID"}),
            @UniqueConstraint(columnNames = {"SHORT_NAME"})
    }
)
@XmlRootElement
public class RoleDTO {
    @Id
    @GeneratedValue
	@Column(name="ROLE_ID")
	private int id;

	@Column(name="SHORT_NAME")
	private String shortName;

	@Column(name="LONG_NAME")
	private String longName;

    @ManyToMany(cascade = { CascadeType.PERSIST, CascadeType.MERGE })
    @JoinTable(name = "USER_ROLE", joinColumns = { @JoinColumn(name = "USER_ID") },
            inverseJoinColumns = { @JoinColumn(name = "ROLE_ID") })
    private Set<UserDTO> users = new LinkedHashSet<UserDTO>();

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

    public Set<UserDTO> getUsers() {
        return users;
    }

    public void setUsers(Set<UserDTO> users) {
        this.users = users;
    }

    public void addUser(UserDTO user){
        if (this.users != null)
            this.users.add(user);
    }
}
