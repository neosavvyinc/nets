package com.neosavvy.user.dto;



import javax.persistence.*;
import javax.xml.bind.annotation.XmlRootElement;
import javax.ws.rs.FormParam;
import java.util.Set;

/**
 * Created by IntelliJ IDEA.
 * User: lgleason
 * Date: Nov 27, 2009
 * Time: 2:03:57 PM
 * To change this template use File | Settings | File Templates.
 */
@Entity
@Table(
    name="COMPANY" ,
    uniqueConstraints = {
            @UniqueConstraint(columnNames = {"ID"})
    }
)
@XmlRootElement
public class CompanyDTO {

    @Id
    @GeneratedValue
    @Column(name="ID")
    private int id;

    @Column(name="COMPANY_NAME")

    private String companyName;

    @Column(name="ADDRESS_ONE")
    private String addressOne;

    @Column(name="ADDRESS_TWO")
    private String addressTwo;

    @Column(name="CITY")
    private String city;

    @Column(name="POSTAL_CODE")
    private String postalCode;

    @Column(name="STATE")
    private String state;

    @Column(name="COUNTRY")
    private String country;

    @OneToMany(mappedBy="company", fetch=FetchType.EAGER)
    private Set<UserCompanyRoleDTO> userCompanyRoles;

    @OneToMany(mappedBy="company", fetch=FetchType.EAGER)
    private Set<UserInviteDTO> userInvites;


    @ManyToOne
    @JoinColumn(name="NUM_EMPLOYEES_RANGE_FK")
    private NumEmployeesRangeDTO numEmployeesRange;

    public int getId() {
        return id;
    }

    @FormParam("id")
    public void setId(int id) {
        this.id = id;
    }

    public String getCompanyName() {
        return companyName;
    }

    @FormParam("companyName")
    public void setCompanyName(String companyName) {
        this.companyName = companyName;
    }

    public String getAddressOne() {
        return addressOne;
    }

    @FormParam("addressOne")
    public void setAddressOne(String addressOne) {
        this.addressOne = addressOne;
    }

    public String getAddressTwo() {
        return addressTwo;
    }

    @FormParam("addressTwo")
    public void setAddressTwo(String addressTwo) {
        this.addressTwo = addressTwo;
    }

    public String getCity() {
        return city;
    }

    @FormParam("city")
    public void setCity(String city) {
        this.city = city;
    }

    public String getPostalCode() {
        return postalCode;
    }

    @FormParam("postalCode")
    public void setPostalCode(String postalCode) {
        this.postalCode = postalCode;
    }

    public String getState() {
        return state;
    }

    @FormParam("state")
    public void setState(String state) {
        this.state = state;
    }

    public String getCountry() {
        return country;
    }

    @FormParam("country")
    public void setCountry(String country) {
        this.country = country;
    }

    public NumEmployeesRangeDTO getNumEmployeesRange() {
        return numEmployeesRange;
    }

    public void setNumEmployeesRange(NumEmployeesRangeDTO numEmployeesRange) {
        this.numEmployeesRange = numEmployeesRange;
    }

    public Set<UserCompanyRoleDTO> getUserCompanyRoles() {
        return userCompanyRoles;
    }

    public void setUserCompanyRoles(Set<UserCompanyRoleDTO> userCompanyRoles) {
        this.userCompanyRoles = userCompanyRoles;
    }

    public Set<UserInviteDTO> getUserInvites() {
        return userInvites;
    }

    public void setUserInvites(Set<UserInviteDTO> userInvites) {
        this.userInvites = userInvites;
    }
}
