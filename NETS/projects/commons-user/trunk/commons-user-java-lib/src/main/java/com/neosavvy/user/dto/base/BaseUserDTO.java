package com.neosavvy.user.dto.base;

import org.eclipse.persistence.internal.descriptors.PersistenceObject;

import javax.persistence.*;

/**
 * Created by IntelliJ IDEA.
 * User: lgleason
 * Date: Dec 19, 2009
 * Time: 12:57:22 AM
 * To change this template use File | Settings | File Templates.
 */
@MappedSuperclass
public abstract class BaseUserDTO {
    @Column(name="FIRST_NAME")
    private String firstName;

    @Column(name="MIDDLE_NAME")
    private String middleName;

    @Column(name="LAST_NAME")
    private String lastName;

    @Column(name="EMAIL_ADDRESS")
    private String emailAddress;

    @Column(name="CONTACT_PHONE_NUMBER")
    private String contactPhoneNumber;

    protected BaseUserDTO() {

    }

    public abstract Long getId();
    
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

    public String getContactPhoneNumber() {
        return contactPhoneNumber;
    }

    public void setContactPhoneNumber(String contactPhoneNumber) {
        this.contactPhoneNumber = contactPhoneNumber;
    }
}
