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
    name="RH_TRIP" ,
    uniqueConstraints = {
            @UniqueConstraint(columnNames = {"TRIP_ID"})
    }
)
@EntityListeners(EntityListenerManager.class)
public class TripDTO {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "RH_TRIP_SEQ")
    @SequenceGenerator(name = "RH_TRIP_SEQ", sequenceName = "RH_TRIP_SEQ", allocationSize=1)
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
    private char reason;

    @Column(name="PARTY_CODE")
    private char partyCode;

    @OneToMany(mappedBy="trip", fetch= FetchType.LAZY)
    private Set<ReviewDTO> reviews;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

//    public Integer getMemberId() {
//        return memberId;
//    }
//
//    public void setMemberId(Integer memberId) {
//        this.memberId = memberId;
//    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public char getReason() {
        return reason;
    }

    public void setReason(char reason) {
        this.reason = reason;
    }

    public char getPartyCode() {
        return partyCode;
    }

    public void setPartyCode(char partyCode) {
        this.partyCode = partyCode;
    }

    public Set<ReviewDTO> getReviews() {
        return reviews;
    }

    public void setReviews(Set<ReviewDTO> reviews) {
        this.reviews = reviews;
    }
}
