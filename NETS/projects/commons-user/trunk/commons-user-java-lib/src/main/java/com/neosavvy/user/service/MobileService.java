package com.neosavvy.user.service;

import com.neosavvy.user.dto.companyManagement.SecurityWrapperDTO;
import com.neosavvy.user.dto.mobile.DashboardData;
import org.springframework.context.annotation.Scope;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
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
 * Date: Apr 6, 2010
 * Time: 9:13:24 PM
 */
@Path("/mobile")
@Scope("singleton")
public interface MobileService {


    @GET
    @Produces({"application/json"})
    @Path("/dashboardlogin/{username}/{password}")
    public SecurityWrapperDTO login(@PathParam("username") String username, @PathParam("password") String password);


    @GET
    @Produces({"application/json"})
    @Path("/dashboardlogout")
    public boolean logout();

    @GET
    @Produces({"application/json"})
    @Path("/dashboard/{username}/{password}")
    public DashboardData findDashboardData(@PathParam("username") String username, @PathParam("password") String password);

    
}
