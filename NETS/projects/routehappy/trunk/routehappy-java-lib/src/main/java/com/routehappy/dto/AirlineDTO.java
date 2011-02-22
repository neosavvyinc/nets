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

/**
 * Created by IntelliJ IDEA.
 * User: adamparrish
 * Date: 2/19/11
 * Time: 1:50 PM
 */
@Entity
@Table(
    name="RH_AIRLINE" ,
    uniqueConstraints = {
            @UniqueConstraint(columnNames = {"ID"})
    }
)
@EntityListeners(EntityListenerManager.class)
@XmlRootElement
public class AirlineDTO {

    
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "rh_airline_seq")
    @SequenceGenerator(name = "rh_airline_seq", sequenceName = "rh_airline_seq", allocationSize=1)
    @Column(name="ID")
    private Integer id;

    @Column(name="AIRLINE_NAME")
    private String airlineName;

    @Column(name="DISPLAYED_NAME")
    private String displayedName;

    @Column(name="NUM_ROUTES")
    private Integer numRoutes;

    @XmlElement( required = true )
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    @XmlElement( required = true )
    public String getAirlineName() {
        return airlineName;
    }

    public void setAirlineName(String airlineName) {
        this.airlineName = airlineName;
    }

    @XmlElement( required = true )
    public String getDisplayedName() {
        return displayedName;
    }

    public void setDisplayedName(String displayedName) {
        this.displayedName = displayedName;
    }

    @XmlElement( required = true )
    public Integer getNumRoutes() {
        return numRoutes;
    }

    public void setNumRoutes(Integer numRoutes) {
        this.numRoutes = numRoutes;
    }
}
