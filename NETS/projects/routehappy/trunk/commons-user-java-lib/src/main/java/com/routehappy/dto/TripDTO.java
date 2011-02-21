package com.routehappy.dto; /*************************************************************************
 *
 * NEOSAVVY CONFIDENTIAL
 * __________________
 *
 *  Copyright 2008 - 2009 Neosavvy Incorporated
 *  All Rights Reserved.
 *
 * NOTICE:  All information contained herein is, and remains
 * the property of Neosavvy Incorporated and its suppliers,
 * if any.  The intellectual and technical concepts contained
 * herein are proprietary to Neosavvy Incorporated
 * and its suppliers and may be covered by U.S. and Foreign Patents,
 * patents in process, and are protected by trade secret or copyright law.
 * Dissemination of this information or reproduction of this material
 * is strictly forbidden unless prior written permission is obtained
 * from Neosavvy Incorporated.
 **************************************************************************/

import fineline.focal.common.types.v1.EntityListenerManager;

import javax.persistence.*;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;
import java.util.Date;
import java.util.Set;

/**
 * Created by IntelliJ IDEA.
 * User: adamparrish
 * Date: 2/19/11
 * Time: 10:13 AM
 */
@Entity
@Table(
    name="rh_trip" ,
    uniqueConstraints = {
            @UniqueConstraint(columnNames = {"TRIP_ID"})
    }
)
@EntityListeners(EntityListenerManager.class)
@XmlRootElement
public class TripDTO {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "rh_trip_seq")
    @SequenceGenerator(name = "rh_trip_seq", sequenceName = "rh_trip_seq", allocationSize=1)
	@Column(name="TRIP_ID")
    private Integer id;

    /***
     *
     * Later this will point to a user record
     *
     */
//    private Integer memberId;

    @Column(name="CREATE_DATE")
    @Temporal(TemporalType.DATE)
    private Date createDate;

    @Column(name="DESCRIPTION")
    private String description;

    @Column(name="REASON_CODE")
    private String reason;

    @Column(name="PARTY_CODE")
    private String partyCode;

    @OneToMany(mappedBy="trip", fetch= FetchType.LAZY, cascade = CascadeType.PERSIST)
    private Set<ReviewDTO> reviews;

    @XmlElement( required = true )
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    @XmlElement( required = true )
    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    @XmlElement( required = true )
    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    @XmlElement( required = true )
    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }

    @XmlElement( required = true )
    public String getPartyCode() {
        return partyCode;
    }

    public void setPartyCode(String partyCode) {
        this.partyCode = partyCode;
    }

    @XmlElement( required = true )
    public Set<ReviewDTO> getReviews() {
        return reviews;
    }

    public void setReviews(Set<ReviewDTO> reviews) {
        if( reviews != null )
        {
            for ( ReviewDTO review : reviews )
            {
                review.setTrip(this);
            }
        }
        this.reviews = reviews;
    }
}
