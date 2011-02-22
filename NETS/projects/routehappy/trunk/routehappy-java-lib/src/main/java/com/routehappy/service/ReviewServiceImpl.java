package com.routehappy.service; /*************************************************************************
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
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.HashSet;

/**
 * Created by IntelliJ IDEA.
 * User: adamparrish
 * Date: 2/19/11
 * Time: 4:09 PM
 */
@Transactional
public class ReviewServiceImpl implements ReviewService {

    private ReviewDAO reviewDAO;

    public ReviewDAO getReviewDAO() {
        return reviewDAO;
    }

    public void setReviewDAO(ReviewDAO reviewDAO) {
        this.reviewDAO = reviewDAO;
    }

    public String saveReview(TripDTO trip) {

        try {
            if( trip.getCreateDate() == null )
            {
                trip.setCreateDate( new Date() );
            }

            if( trip.getReviews() != null )
            {
                for ( ReviewDTO reviewDTO : trip.getReviews() )
                {
                    if( reviewDTO.getCreationDate() == null )
                    {
                        reviewDTO.setCreationDate( new Date() );
                    }
                }
            }

            getReviewDAO().saveTrip( trip );
        }
        catch (Exception e)
        {
            return "false";
        }

        return "true";
    }
}
