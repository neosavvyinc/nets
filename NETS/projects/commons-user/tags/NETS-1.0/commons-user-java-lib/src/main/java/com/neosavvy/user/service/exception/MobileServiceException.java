package com.neosavvy.user.service.exception;

import javax.ws.rs.WebApplicationException;
import javax.ws.rs.core.Response;
/*************************************************************************
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

/**
 * User: adamparrish
 * Date: Apr 11, 2010
 * Time: 7:09:11 PM
 */
public class MobileServiceException extends WebApplicationException {

    private Integer mobileServiceExceptionId;
    private String defaultExceptionString;

    public MobileServiceException(Integer mobileServiceExceptionId, String defaultExceptionString, Response.Status status ) {
        super(status);
        this.defaultExceptionString = defaultExceptionString;
        this.mobileServiceExceptionId = mobileServiceExceptionId;
    }

    public String getDefaultExceptionString() {
        return defaultExceptionString;
    }

    public Integer getMobileServiceExceptionId() {
        return mobileServiceExceptionId;
    }
}
