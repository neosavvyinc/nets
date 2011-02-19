package com.neosavvy.user.service;

import com.neosavvy.user.dto.companyManagement.SecurityWrapperDTO;
import com.neosavvy.user.dto.mobile.DashboardData;
import com.neosavvy.user.dto.mobile.StatusDashboardData;
import com.neosavvy.user.dto.project.ExpenseItem;
import com.neosavvy.user.dto.project.ExpenseReportStatus;
import fineline.focal.common.types.v1.StorageServiceFileRef;
import org.springframework.context.annotation.Scope;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;

import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.MultivaluedMap;
import java.util.List;
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


    @POST
    @Consumes({MediaType.APPLICATION_FORM_URLENCODED,MediaType.MULTIPART_FORM_DATA})
    @Produces({MediaType.APPLICATION_JSON})
    @Path("/dashboardlogin")
    public SecurityWrapperDTO login(@FormParam("username") String username, @FormParam("password") String password);


    @GET
    @Produces({MediaType.APPLICATION_JSON})
    @Path("/dashboardlogout")
    public boolean logout();

    @POST
    @Consumes({MediaType.APPLICATION_JSON})
    @Produces({MediaType.TEXT_PLAIN})
    @Path("/savereceipt")
    public String associateReceiptUploadWithUser(StorageServiceFileRef fileRef);


    @GET
    @Produces({MediaType.APPLICATION_JSON})
    @Path("/dashboard")
    public DashboardData findDashboardData();

    @GET
    @Produces({MediaType.APPLICATION_JSON})
    @Path("/statusDashboard/{status}")
    public List<StatusDashboardData> findStatusDashboardData(@PathParam("status") String status );

    @GET
    @Produces({MediaType.APPLICATION_JSON})
    @Path("/expenseItemDrilldown/{expenseReportId}")
    public List<ExpenseItem> findExpenseItemsForReportId(@PathParam("expenseReportId") long id);
    
}
