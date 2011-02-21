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
import java.util.Set;

/**
 * Created by IntelliJ IDEA.
 * User: adamparrish
 * Date: 2/19/11
 * Time: 10:10 AM
 */
@Entity
@Table(
    name="RH_REVIEW" ,
    uniqueConstraints = {
            @UniqueConstraint(columnNames = {"ID"})
    }
)
@EntityListeners(EntityListenerManager.class)
@XmlRootElement
public class ReviewDTO {

    
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "rh_review_seq")
    @SequenceGenerator(name = "rh_review_seq", sequenceName = "rh_review_seq", allocationSize=1)
	@Column(name="REVIEW_ID")
    private Integer id;

    
    @Column(name="CREATION_DATE")
    @Temporal(TemporalType.DATE)
    private Date creationDate;

    
    @Column(name="TRIP_DATE")
    @Temporal(TemporalType.DATE)
    private Date tripDate;

    
    @ManyToOne( cascade = CascadeType.PERSIST )
    @JoinColumn(name="TRIP_ID")
    private TripDTO trip;

    
    @OneToMany(mappedBy="review", fetch= FetchType.LAZY, cascade = CascadeType.PERSIST)
    private Set<SegmentDTO> segments;

    
    @Column(name="NUM_STOPS")
    private Integer numberStops;

    
    @Column(name="OUTBOUND_OR_RETURN_CODE")
    private Integer outboundReturnCode;

    @XmlElement( required = true )
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    @XmlElement( required = true )
    public Date getCreationDate() {
        return creationDate;
    }

    public void setCreationDate(Date creationDate) {
        this.creationDate = creationDate;
    }

    @XmlElement( required = true )
    public Date getTripDate() {
        return tripDate;
    }

    public void setTripDate(Date tripDate) {
        this.tripDate = tripDate;
    }

    @XmlElement( required = true )
    public Integer getNumberStops() {
        return numberStops;
    }

    public void setNumberStops(Integer numberStops) {
        this.numberStops = numberStops;
    }

    @XmlElement( required = true )
    public Integer getOutboundReturnCode() {
        return outboundReturnCode;
    }

    public void setOutboundReturnCode(Integer outboundReturnCode) {
        this.outboundReturnCode = outboundReturnCode;
    }

    @XmlTransient
    public TripDTO getTrip() {
        return trip;
    }

    public void setTrip(TripDTO trip) {
        this.trip = trip;
    }

    @XmlElement( required = true )
    public Set<SegmentDTO> getSegments() {
        return segments;
    }

    public void setSegments(Set<SegmentDTO> segments) {
        if( segments != null )
        {
            for ( SegmentDTO segment : segments )
            {
                segment.setReview(this);
            }
        }
        this.segments = segments;
    }
}
