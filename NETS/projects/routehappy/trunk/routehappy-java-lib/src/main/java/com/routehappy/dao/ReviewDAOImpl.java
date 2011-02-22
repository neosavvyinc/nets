package com.routehappy.dao; /*************************************************************************
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

import com.routehappy.dto.ReviewDTO;
import com.routehappy.dto.TripDTO;

/**
 * Created by IntelliJ IDEA.
 * User: adamparrish
 * Date: 2/19/11
 * Time: 10:29 AM
 */
public class ReviewDAOImpl extends BaseDAO implements ReviewDAO {
    public ReviewDTO saveReview(ReviewDTO review) {
        if (review.getId() == null) {
            getEntityManager().persist(review);
        }
        else {
		    review = getEntityManager().merge(review);
        }

        getEntityManager().flush();
        return review;
    }

    public TripDTO saveTrip(TripDTO trip) {
        if (trip.getId() == null) {
            getEntityManager().persist(trip);
        }
        else {
            trip = getEntityManager().merge(trip);
        }

        getEntityManager().flush();
        return trip;
    }
}
