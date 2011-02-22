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
 * Date: 2/21/11
 * Time: 12:19 AM
 */
@Entity
@Table(
    name="RH_REVIEW_OPTIONAL_RATINGS" ,
    uniqueConstraints = {
            @UniqueConstraint(columnNames = {"ID"})
    }
)
@EntityListeners(EntityListenerManager.class)
@XmlRootElement
public class OptionalRatingsDTO {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "rh_review_optional_rating_seq")
    @SequenceGenerator(name = "rh_review_optional_rating_seq", sequenceName = "rh_review_optional_rating_seq", allocationSize=1)
	@Column(name="RATING_ID")
    private Integer id;

    @Column(name = "DEPT_GET_AIRPORT")
    private Integer departureGettingToAirport;

    @Column(name = "DEPT_CHECKIN_SECURITY")
    private Integer departureCheckinSecurity;

    @Column(name = "DEPT_FOOD_SHOP")
    private Integer departureAirportFoodShop;

    @Column(name = "DEPT_GATE_BOARDING")
    private Integer departureGateAndBoarding;

    @Column(name = "AIRPORT_LOUGE")
    private Integer airportLoung;

    @Column(name = "FIRST_FLIGHT_COMFORT")
    private Integer firstFlightAirplainComfort;

    @Column(name = "FIRST_FLIGHT_CLEANLINESS")
    private Integer firstFlightCleanliness;

    @Column(name = "FIRST_FLIGHT_CABIN_CREW")
    private Integer firstFlightCabinCrew;

    @Column(name = "FIRST_FLIGHT_FOOD")
    private Integer firstFlightFood;

    @Column(name = "FIRST_FLIGHT_ENTERTAINMENT")
    private Integer firstFlightEntertainment;

    @Column(name = "ARRIVAL_GETTING_OFF_PLANE")
    private Integer arrivalGettingOffPlane;

    @Column(name = "ARRIVAL_BAGGAGE_CLAIM")
    private Integer arrivalBaggageClaim;

    @Column(name = "ARRIVAL_BAGGAGE_HANDLING")
    private Integer arrivalBaggageHandling;

    @Column(name = "ARRIVAL_IMMIGRATION_CUSTOMS")
    private Integer arrivalImmigrationCustoms;

    @Column(name = "LEAVING_AIRPORT")
    private Integer leavingAirport;

    @XmlElement( required = true )
    public Integer getDepartureGettingToAirport() {
        return departureGettingToAirport;
    }

    public void setDepartureGettingToAirport(Integer departureGettingToAirport) {
        this.departureGettingToAirport = departureGettingToAirport;
    }

    @XmlElement( required = true )
    public Integer getDepartureCheckinSecurity() {
        return departureCheckinSecurity;
    }

    public void setDepartureCheckinSecurity(Integer departureCheckinSecurity) {
        this.departureCheckinSecurity = departureCheckinSecurity;
    }

    @XmlElement( required = true )
    public Integer getDepartureAirportFoodShop() {
        return departureAirportFoodShop;
    }

    public void setDepartureAirportFoodShop(Integer departureAirportFoodShop) {
        this.departureAirportFoodShop = departureAirportFoodShop;
    }

    @XmlElement( required = true )
    public Integer getDepartureGateAndBoarding() {
        return departureGateAndBoarding;
    }

    public void setDepartureGateAndBoarding(Integer departureGateAndBoarding) {
        this.departureGateAndBoarding = departureGateAndBoarding;
    }

    @XmlElement( required = true )
    public Integer getAirportLoung() {
        return airportLoung;
    }

    public void setAirportLoung(Integer airportLoung) {
        this.airportLoung = airportLoung;
    }

    @XmlElement( required = true )
    public Integer getFirstFlightAirplainComfort() {
        return firstFlightAirplainComfort;
    }

    public void setFirstFlightAirplainComfort(Integer firstFlightAirplainComfort) {
        this.firstFlightAirplainComfort = firstFlightAirplainComfort;
    }

    @XmlElement( required = true )
    public Integer getFirstFlightCleanliness() {
        return firstFlightCleanliness;
    }

    public void setFirstFlightCleanliness(Integer firstFlightCleanliness) {
        this.firstFlightCleanliness = firstFlightCleanliness;
    }

    @XmlElement( required = true )
    public Integer getFirstFlightCabinCrew() {
        return firstFlightCabinCrew;
    }

    public void setFirstFlightCabinCrew(Integer firstFlightCabinCrew) {
        this.firstFlightCabinCrew = firstFlightCabinCrew;
    }

    @XmlElement( required = true )
    public Integer getFirstFlightFood() {
        return firstFlightFood;
    }

    public void setFirstFlightFood(Integer firstFlightFood) {
        this.firstFlightFood = firstFlightFood;
    }

    @XmlElement( required = true )
    public Integer getFirstFlightEntertainment() {
        return firstFlightEntertainment;
    }

    public void setFirstFlightEntertainment(Integer firstFlightEntertainment) {
        this.firstFlightEntertainment = firstFlightEntertainment;
    }

    @XmlElement( required = true )
    public Integer getArrivalGettingOffPlane() {
        return arrivalGettingOffPlane;
    }

    public void setArrivalGettingOffPlane(Integer arrivalGettingOffPlane) {
        this.arrivalGettingOffPlane = arrivalGettingOffPlane;
    }

    @XmlElement( required = true )
    public Integer getArrivalBaggageClaim() {
        return arrivalBaggageClaim;
    }

    public void setArrivalBaggageClaim(Integer arrivalBaggageClaim) {
        this.arrivalBaggageClaim = arrivalBaggageClaim;
    }

    @XmlElement( required = true )
    public Integer getArrivalBaggageHandling() {
        return arrivalBaggageHandling;
    }

    public void setArrivalBaggageHandling(Integer arrivalBaggageHandling) {
        this.arrivalBaggageHandling = arrivalBaggageHandling;
    }

    @XmlElement( required = true )
    public Integer getArrivalImmigrationCustoms() {
        return arrivalImmigrationCustoms;
    }

    public void setArrivalImmigrationCustoms(Integer arrivalImmigrationCustoms) {
        this.arrivalImmigrationCustoms = arrivalImmigrationCustoms;
    }

    @XmlElement( required = true )
    public Integer getLeavingAirport() {
        return leavingAirport;
    }

    public void setLeavingAirport(Integer leavingAirport) {
        this.leavingAirport = leavingAirport;
    }
}
