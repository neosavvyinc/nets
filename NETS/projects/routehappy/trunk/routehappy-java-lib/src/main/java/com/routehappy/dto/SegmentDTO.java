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
import javax.xml.bind.annotation.XmlTransient;
import java.util.Date;

/**
 * Created by IntelliJ IDEA.
 * User: adamparrish
 * Date: 2/19/11
 * Time: 12:08 PM
 */
@Entity
@Table(
    name="RH_REVIEW_SEGMENT" ,
    uniqueConstraints = {
            @UniqueConstraint(columnNames = {"REVIEW_ID"})
    }
)
@EntityListeners(EntityListenerManager.class)
@XmlRootElement
public class SegmentDTO {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "rh_review_segment_seq")
    @SequenceGenerator(name = "rh_review_segment_seq", sequenceName = "rh_review_segment_seq", allocationSize=1)
	@Column(name="ID")
    private Integer id;

    @OneToOne( cascade = CascadeType.PERSIST )
    @JoinColumn(name="AIRLINE_ID")
    private AirlineDTO airline;

    @OneToOne( cascade = CascadeType.PERSIST )
    @JoinColumn(name = "AIRPORT_ORIG")
    private AirportDTO airportOrig;

    @OneToOne( cascade = CascadeType.PERSIST )
    @JoinColumn(name = "AIRPORT_DEST")
    private AirportDTO airportDest;

    /** Should be an enum */
    @Column(name="CABIN")
    private Integer cabinCode;

    @Temporal(TemporalType.DATE)
    @Column(name="TRIP_DATE")
    private Date tripDate;

    @Column(name="RATING")
    private Integer rating;

    @Column(name="RATING_AIRPORT_ORIG")
    private Integer ratingAirportOrig;

    @Column(name="RATING_AIRPORT_DEST")
    private Integer ratingAirportDest;

    @ManyToOne
    @JoinColumn(name="REVIEW_ID")
    private ReviewDTO review;

    private Integer segment;

    @XmlElement( required = true )
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    @XmlElement( required = true )
    public Integer getCabinCode() {
        return cabinCode;
    }

    public void setCabinCode(Integer cabinCode) {
        this.cabinCode = cabinCode;
    }

    @XmlElement( required = true )
    public Date getTripDate() {
        return tripDate;
    }

    public void setTripDate(Date tripDate) {
        this.tripDate = tripDate;
    }

    @XmlElement( required = true )
    public Integer getRating() {
        return rating;
    }

    public void setRating(Integer rating) {
        this.rating = rating;
    }

    @XmlElement( required = true )
    public Integer getRatingAirportOrig() {
        return ratingAirportOrig;
    }

    public void setRatingAirportOrig(Integer ratingAirportOrig) {
        this.ratingAirportOrig = ratingAirportOrig;
    }

    @XmlElement( required = true )
    public Integer getRatingAirportDest() {
        return ratingAirportDest;
    }

    public void setRatingAirportDest(Integer ratingAirportDest) {
        this.ratingAirportDest = ratingAirportDest;
    }

    @XmlTransient
    public ReviewDTO getReview() {
        return review;
    }

    public void setReview(ReviewDTO review) {
        this.review = review;
    }

    @XmlElement( required = true )
    public Integer getSegment() {
        return segment;
    }

    public void setSegment(Integer segment) {
        this.segment = segment;
    }

    @XmlElement( required = true )
    public AirlineDTO getAirline() {
        return airline;
    }

    public void setAirline(AirlineDTO airlineId) {
        this.airline = airlineId;
    }

    @XmlElement( required = true )
    public AirportDTO getAirportOrig() {
        return airportOrig;
    }

    public void setAirportOrig(AirportDTO airportOrig) {
        this.airportOrig = airportOrig;
    }

    @XmlElement( required = true )
    public AirportDTO getAirportDest() {
        return airportDest;
    }

    public void setAirportDest(AirportDTO airportDest) {
        this.airportDest = airportDest;
    }
}
