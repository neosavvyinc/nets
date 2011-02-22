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

/**
 * Created by IntelliJ IDEA.
 * User: adamparrish
 * Date: 2/19/11
 * Time: 1:51 PM
 */
@Entity
@Table(
    name="RH_AIRPORT" ,
    uniqueConstraints = {
            @UniqueConstraint(columnNames = {"ID"})
    }
)
@EntityListeners(EntityListenerManager.class)
@XmlRootElement
public class AirportDTO {

    
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "rh_airport_seq")
    @SequenceGenerator(name = "rh_airport_seq", sequenceName = "rh_airport_seq", allocationSize=1)
    @Column(name="ID")
    private Integer id;

    @Column(name = "CODE")
    private String code;

    @Column(name = "LAT")
    private Integer latitude;

    @Column(name = "LON")
    private Integer longitude;

    @Column(name = "NAME")
    private String name;

    @Column(name = "COUNTRY_CODE")
    private String country;

    @Column(name = "STATE_PROV")
    private String stateOrProvinceCode;

    @Column(name = "CITY")
    private String cityName;

    @Column(name = "AIRPORT_WEBSITE")
    private String airportWebsite;

    @Column(name = "WIKI")
    private String wiki;

    @Column(name = "ADDITIONAL_SEARCH_PHRASES")
    private String additionalSearchPhrases;

    @Column(name = "CONSTRUCTED_NAME")
    private String constructedName;

    @XmlElement( required = true )
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    @XmlElement( required = true )
    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    @XmlElement( required = true )
    public Integer getLatitude() {
        return latitude;
    }

    public void setLatitude(Integer latitude) {
        this.latitude = latitude;
    }

    @XmlElement( required = true )
    public Integer getLongitude() {
        return longitude;
    }

    public void setLongitude(Integer longitude) {
        this.longitude = longitude;
    }

    @XmlElement( required = true )
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @XmlElement( required = true )
    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    @XmlElement( required = true )
    public String getStateOrProvinceCode() {
        return stateOrProvinceCode;
    }

    public void setStateOrProvinceCode(String stateOrProvinceCode) {
        this.stateOrProvinceCode = stateOrProvinceCode;
    }

    @XmlElement( required = true )
    public String getCityName() {
        return cityName;
    }

    public void setCityName(String cityName) {
        this.cityName = cityName;
    }

    @XmlElement( required = true )
    public String getAirportWebsite() {
        return airportWebsite;
    }

    public void setAirportWebsite(String airportWebsite) {
        this.airportWebsite = airportWebsite;
    }

    @XmlElement( required = true )
    public String getWiki() {
        return wiki;
    }

    public void setWiki(String wiki) {
        this.wiki = wiki;
    }

    @XmlElement( required = true )
    public String getAdditionalSearchPhrases() {
        return additionalSearchPhrases;
    }

    public void setAdditionalSearchPhrases(String additionalSearchPhrases) {
        this.additionalSearchPhrases = additionalSearchPhrases;
    }

    @XmlElement( required = true )
    public String getConstructedName() {
        return constructedName;
    }

    public void setConstructedName(String constructedName) {
        this.constructedName = constructedName;
    }
}
