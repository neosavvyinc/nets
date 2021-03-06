package com.neosavvy.user.dto;

import javax.persistence.*;
import java.io.Serializable;

@Entity
@Table(
    name="USER" ,
    uniqueConstraints = {
            @UniqueConstraint(columnNames = {"USER_ID"})
            ,@UniqueConstraint(columnNames = {"USERNAME"})
    }
)
public class UserDTO implements Serializable {

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
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getFirstName() {
		return firstName;
	}
	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}
	public String getMiddleName() {
		return middleName;
	}
	public void setMiddleName(String middleName) {
		this.middleName = middleName;
	}
	public String getLastName() {
		return lastName;
	}
	public void setLastName(String lastName) {
		this.lastName = lastName;
	}
	public String getEmailAddress() {
		return emailAddress;
	}
	public void setEmailAddress(String emailAddress) {
		this.emailAddress = emailAddress;
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

}
