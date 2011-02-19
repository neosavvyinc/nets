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
import com.routehappy.dto.ReviewDTO;
import com.routehappy.dto.SegmentDTO;
import com.routehappy.dto.TripDTO;
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

        TripDTO trip = new TripDTO();
        trip.setCreateDate(new Date());
        trip.setDescription("Sample description");
        trip.setId(1);
        trip.setPartyCode('p');
        trip.setReason('r');

        SegmentDTO segmentDTO = new SegmentDTO();
        segmentDTO.setCabinCode(1);
        segmentDTO.setId(1);
        segmentDTO.setRating('a');
        segmentDTO.setRatingAirportDest('A');
        segmentDTO.setRatingAirportOrig('4');
        segmentDTO.setSegment(1);
        segmentDTO.setTripDate(new Date());

        ReviewDTO testReview = new ReviewDTO();
        testReview.setCreationDate(new Date());
        testReview.setId(1);
        testReview.setNumberStops(1);
        testReview.setOutboundReturnCode(0);
        testReview.setTripDate(new Date());
        testReview.setTrip(trip);

        HashSet<ReviewDTO> reviewDTOs = new HashSet<ReviewDTO>();
        HashSet<SegmentDTO> segmentDTOs = new HashSet<SegmentDTO>();
        reviewDTOs.add(testReview);
        segmentDTOs.add(segmentDTO);
        trip.setReviews(reviewDTOs);
        testReview.setSegments(segmentDTOs);
        segmentDTO.setReview( testReview );

        dao.saveReview( testReview );

        int numRowsSaved = countRowsInTable("RH_REVIEW");
        Assert.assertEquals("Should be one row in the table", numRowsSaved, 1);

        int numRowsTripSaved = countRowsInTable("RH_TRIP");
        Assert.assertEquals("Should be one row in the table", numRowsTripSaved, 1);

        int numRowsSegmentSaved = countRowsInTable("RH_REVIEW_SEGMENT");
        Assert.assertEquals("Should be one row in the table", numRowsSegmentSaved, 1);
    }


}
