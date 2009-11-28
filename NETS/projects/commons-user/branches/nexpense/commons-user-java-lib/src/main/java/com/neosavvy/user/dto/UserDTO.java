package com.neosavvy.user.dto;

import javax.persistence.*;
import javax.ws.rs.FormParam;
import javax.xml.bind.annotation.XmlRootElement;
import java.io.*;
import java.util.Set;
import java.util.LinkedHashSet;

@Entity
@Table(
    name="USER" ,
    uniqueConstraints = {
            @UniqueConstraint(columnNames = {"USER_ID"})
            ,@UniqueConstraint(columnNames = {"USERNAME"})
    }
)
@XmlRootElement
public class UserDTO {// implements Externalizable {

	@Id
    @GeneratedValue
	@Column(name="USER_ID")
	private int id;
	
	@Column(name="FIRST_NAME")
	private String firstName;
	
	@Column(name="MIDDLE_NAME")
	private String middleName;
	
	@Column(name="LAST_NAME")
	private String lastName;
	
	@Column(name="EMAIL_ADDRESS")
	private String emailAddress;

    @Column(name="USERNAME")
    private String username;

	@Column(name="PASSWORD")
	private String password;

    @ManyToMany(cascade = { CascadeType.PERSIST, CascadeType.MERGE })
    @JoinTable(name = "USER_COMPANY", joinColumns = { @JoinColumn(name = "COMPANY_ID") },
            inverseJoinColumns = { @JoinColumn(name = "USER_ID") })
    private Set<CompanyDTO> companies = new LinkedHashSet<CompanyDTO>();
	
	public int getId() {
		return id;
	}

    @FormParam("id")
	public void setId(int id) {
		this.id = id;
	}
	public String getFirstName() {
		return firstName;
	}
    @FormParam("firstName")
	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}
	public String getMiddleName() {
		return middleName;
	}
    @FormParam("middleName")
	public void setMiddleName(String middleName) {
		this.middleName = middleName;
	}
	public String getLastName() {
		return lastName;
	}
    @FormParam("lastName")
	public void setLastName(String lastName) {
		this.lastName = lastName;
	}
	public String getEmailAddress() {
		return emailAddress;
	}
    @FormParam("emailAddress")
	public void setEmailAddress(String emailAddress) {
		this.emailAddress = emailAddress;
	}
    public String getUsername() {
        return username;
    }
    @FormParam("userName")
    public void setUsername(String username) {
        this.username = username;
    }
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}

	public Set<CompanyDTO> getCompanies() {
		return companies;
	}

	public void setCompanies(Set<CompanyDTO> companies) {
		this.companies = companies;
	}
}
