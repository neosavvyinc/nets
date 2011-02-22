package com.routehappy.review; /*************************************************************************
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

import com.routehappy.dao.ReviewDAO;
import com.routehappy.dto.*;
import org.apache.batik.dom.util.TriplyIndexedTable;
import org.junit.Assert;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.annotation.Rollback;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.AbstractTransactionalJUnit4SpringContextTests;

import java.util.Date;
import java.util.HashSet;

/**
 * Created by IntelliJ IDEA.
 * User: adamparrish
 * Date: 2/19/11
 * Time: 10:05 AM
 */
@ContextConfiguration(locations = {
        "classpath:testSecurityContext.xml"
        })
public class ReviewDAOTest extends AbstractTransactionalJUnit4SpringContextTests {

    @Autowired
    private ReviewDAO dao;


    public ReviewDAO getDao() {
        return dao;
    }

    public void setDao(ReviewDAO dao) {
        this.dao = dao;
    }

    @Test
    public void testSave()
    {
        deleteFromTables("RH_REVIEW");
        deleteFromTables("RH_TRIP");
        deleteFromTables("RH_REVIEW_SEGMENT");
        deleteFromTables("RH_AIRLINE");
        deleteFromTables("RH_AIRPORT");
        deleteFromTables("RH_REVIEW_OPTIONAL_RATINGS");

        TripDTO trip = new TripDTO();
        trip.setCreateDate(new Date());
        trip.setDescription("Sample description");
        trip.setId(1);
        trip.setPartyCode("p");
        trip.setReason("r");

        SegmentDTO segmentDTO = new SegmentDTO();
        segmentDTO.setCabinCode(1);
        segmentDTO.setId(1);
        segmentDTO.setRating(2);
        segmentDTO.setRatingAirportDest(3);
        segmentDTO.setRatingAirportOrig(5);
        segmentDTO.setSegment(1);
        segmentDTO.setTripDate(new Date());

        OptionalRatingsDTO ratingsDTO = new OptionalRatingsDTO();
        ratingsDTO.setAirportLoung(9);
        ratingsDTO.setArrivalBaggageClaim(7);
        ratingsDTO.setArrivalBaggageHandling(4);
        ratingsDTO.setArrivalGettingOffPlane(3);
        ratingsDTO.setArrivalImmigrationCustoms(3);
        ratingsDTO.setDepartureAirportFoodShop(2);
        ratingsDTO.setDepartureCheckinSecurity(4);
        ratingsDTO.setDepartureGateAndBoarding(4);
        ratingsDTO.setFirstFlightAirplainComfort(4);


        ReviewDTO testReview = new ReviewDTO();
        testReview.setCreationDate(new Date());
        testReview.setId(1);
        testReview.setNumberStops(1);
        testReview.setOutboundReturnCode(0);
        testReview.setTripDate(new Date());
        testReview.setTrip(trip);
        testReview.setOptionalRatings(ratingsDTO);


        AirlineDTO airlineDTO = new AirlineDTO();
        airlineDTO.setAirlineName("Adam's Airline");
        airlineDTO.setDisplayedName("Adam's wicked awesome airline");
        airlineDTO.setId(1);
        airlineDTO.setNumRoutes(2382);

        HashSet<ReviewDTO> reviewDTOs = new HashSet<ReviewDTO>();
        HashSet<SegmentDTO> segmentDTOs = new HashSet<SegmentDTO>();
        reviewDTOs.add(testReview);
        segmentDTOs.add(segmentDTO);
        trip.setReviews(reviewDTOs);

        testReview.setSegments(segmentDTOs);
        segmentDTO.setReview( testReview );
        segmentDTO.setAirline( airlineDTO );

        AirportDTO destAirport = new AirportDTO();
        destAirport.setAdditionalSearchPhrases("Test Phrase");
        destAirport.setAirportWebsite("http://blah.com");
        destAirport.setCityName("Brooklyn");
        destAirport.setCode("BKL");
        destAirport.setConstructedName("Constructedname?");
        destAirport.setCountry("USA");
        destAirport.setId(1);
        destAirport.setLatitude(49);
        destAirport.setLongitude(89);
        destAirport.setName("Brooklyn downtown nonexistent airport");
        destAirport.setStateOrProvinceCode("NY");
        destAirport.setWiki("http://bk.wiki.com");

        AirportDTO origAirport = new AirportDTO();
        origAirport.setAdditionalSearchPhrases("Test Phrase 2");
        origAirport.setAirportWebsite("http://blah.com 2");
        origAirport.setCityName("Brooklyn 2");
        origAirport.setCode("BKL");
        origAirport.setConstructedName("Constructedname? 2");
        origAirport.setCountry("USA");
        origAirport.setId(2);
        origAirport.setLatitude(49);
        origAirport.setLongitude(89);
        origAirport.setName("Brooklyn downtown nonexistent airport 2");
        origAirport.setStateOrProvinceCode("NY");
        origAirport.setWiki("http://bk.wiki.com 2");

        segmentDTO.setAirportDest( destAirport );
        segmentDTO.setAirportOrig( origAirport );

        dao.saveTrip( trip );

        int numRowsSaved = countRowsInTable("RH_REVIEW");
        Assert.assertEquals("Should be one row in the table", numRowsSaved, 1);

        int numRowsTripSaved = countRowsInTable("RH_TRIP");
        Assert.assertEquals("Should be one row in the table", numRowsTripSaved, 1);

        int numRowsSegmentSaved = countRowsInTable("RH_REVIEW_SEGMENT");
        Assert.assertEquals("Should be one row in the table", numRowsSegmentSaved, 1);

        int numRowsAirlineSaved = countRowsInTable("RH_AIRLINE");
        Assert.assertEquals("Should be one row in the table", numRowsAirlineSaved, 1);

        int numRowsAirportSaved = countRowsInTable("RH_AIRPORT");
        Assert.assertEquals("Should be one row in the table", numRowsAirportSaved, 2);

        int numOptionaRatingsSaved = countRowsInTable("RH_REVIEW_OPTIONAL_RATINGS");
        Assert.assertEquals("Should be one row in the table", numOptionaRatingsSaved, 1);

    }


}
