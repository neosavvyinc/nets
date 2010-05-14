package com.neosavvy.user.service;

import com.neosavvy.user.dto.companyManagement.SecurityWrapperDTO;
import com.neosavvy.user.dto.companyManagement.UserDTO;
import com.neosavvy.user.dto.mobile.DashboardData;
import com.neosavvy.user.dto.mobile.StatusDashboardData;
import com.neosavvy.user.dto.project.ExpenseReportStatus;
import com.neosavvy.user.service.exception.MobileServiceException;
import fineline.focal.common.http.HttpUtils;
import fineline.focal.common.security.UserSessionManager;
import fineline.focal.common.types.v1.StorageServiceFileRef;
import fineline.focal.common.types.v1.UserSession;
import org.eclipse.persistence.sessions.factories.SessionManager;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.ws.rs.FormParam;
import javax.ws.rs.PathParam;
import javax.ws.rs.core.Response;
import java.util.ArrayList;
import java.util.Date;
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
 * Time: 9:18:32 PM
 */
public class MobileServiceImpl implements MobileService {

    private static final Logger logger = LoggerFactory.getLogger(MobileServiceImpl.class);

    private ExpenseService expenseService;

    private UserService userService;

    private AuthenticationManager authManager;

    private UserSessionManager sessionManager;

    public SecurityWrapperDTO login(String username, String password) {
        Authentication authentication = authManager.authenticate(new UsernamePasswordAuthenticationToken(username, password));
        SecurityContextHolder.getContext().setAuthentication(authentication);

        HttpServletRequest req = HttpUtils.getHttpRequest();
        HttpServletResponse resp = HttpUtils.getHttpResponse();

        sessionManager.initSession(username, req, resp);
        UserSession session = (UserSession)req.getSession().getAttribute(UserSessionManager.USER_SESSION_ATTRIBUTE_NAME);

        SecurityWrapperDTO securityWrapper = userService.getUserDetails();
        securityWrapper.setSessionId(session.getId());

        return securityWrapper;
    }


    public boolean logout() {
        SecurityContextHolder.clearContext();
        HttpServletRequest request = HttpUtils.getHttpRequest();
        HttpServletResponse response = HttpUtils.getHttpResponse();
        sessionManager.invalidateCurrentSession(request, response);
        return true;
    }

    public String associateReceiptUploadWithUser(StorageServiceFileRef fileRef) {
        UserDetails userDetails = findUserDetailsOrThrowException();

        UserDTO user = new UserDTO();
        user.setUsername( userDetails.getUsername() );

        userService.associateReceiptUploadWithUser( user, fileRef);
        return "true";
    }

    public DashboardData findDashboardData() {

        UserDetails userDetails = findUserDetailsOrThrowException();


        DashboardData dashboardData = new DashboardData();
        UserDTO user = new UserDTO();
        user.setUsername( userDetails.getUsername() );

        dashboardData.setNumberApprovedExpenses( expenseService.findExpenseReportsByStatus( user, ExpenseReportStatus.APPROVED ).size() );
        dashboardData.setNumberApprovingExpenses( expenseService.findExpenseReportsByStatus( user, ExpenseReportStatus.APPROVING).size() );
        dashboardData.setNumberDeclinedExpenses( expenseService.findExpenseReportsByStatus( user, ExpenseReportStatus.DECLINED).size() );
        dashboardData.setNumberOpenExpenses( expenseService.findExpenseReportsByStatus( user, ExpenseReportStatus.OPEN).size() );
        dashboardData.setNumberReimbursedmentReceivedExpenses( expenseService.findExpenseReportsByStatus( user, ExpenseReportStatus.REIMBURSEMENT_RECEIVED).size() );
        dashboardData.setNumberReimbursmentSentExpenses( expenseService.findExpenseReportsByStatus( user, ExpenseReportStatus.REIMBURSEMENT_SENT).size() );
        dashboardData.setNumberSubmittedExpenses( expenseService.findExpenseReportsByStatus( user, ExpenseReportStatus.SUBMITTED).size() );
        
        logger.debug(dashboardData.toString());

        return dashboardData;
    }

    public List<StatusDashboardData> findStatusDashboardData(String status) {

        ExpenseReportStatus reportStatus = ExpenseReportStatus.valueOf(status);

        ArrayList<StatusDashboardData> statusInfo = new ArrayList<StatusDashboardData>();

        StatusDashboardData data1 = new StatusDashboardData();
        data1.setExpenseReportEndDate(new Date());
        data1.setExpenseReportStartDate(new Date());
        data1.setExpenseReportLastActivityDate(new Date());
        data1.setExpenseReportLocation("Raleigh Fool!");
        data1.setExpenseReportName("Drinkin' hard");
        data1.setExpenseReportTotal(500.00);

        StatusDashboardData data2 = new StatusDashboardData();
        data2.setExpenseReportEndDate(new Date());
        data2.setExpenseReportStartDate(new Date());
        data2.setExpenseReportLastActivityDate(new Date());
        data2.setExpenseReportLocation("Raleigh Fool!");
        data2.setExpenseReportName("Makin' deals");
        data2.setExpenseReportTotal(500.00);


        StatusDashboardData data3 = new StatusDashboardData();
        data3.setExpenseReportEndDate(new Date());
        data3.setExpenseReportStartDate(new Date());
        data3.setExpenseReportLastActivityDate(new Date());
        data3.setExpenseReportLocation("Raleigh Fool!");
        data3.setExpenseReportName("Hirin' Strippers");
        data3.setExpenseReportTotal(500.00);

        statusInfo.add(data1);
        statusInfo.add(data2);
        statusInfo.add(data3);

        return statusInfo;
    }

    private UserDetails findUserDetailsOrThrowException() {
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        UserDetails userDetails = null;
        if( principal instanceof UserDetails)
            userDetails = (UserDetails) principal;
        else if( principal instanceof String )
            System.out.println(principal.toString());

        if ( userDetails == null )
        {
            throw new MobileServiceException(100,"User details can not be null", Response.Status.UNAUTHORIZED);
        }
        return userDetails;
    }

    public ExpenseService getExpenseService() {
        return expenseService;
    }

    public void setExpenseService(ExpenseService expenseService) {
        this.expenseService = expenseService;
    }

    public UserService getUserService() {
        return userService;
    }

    public void setUserService(UserService userService) {
        this.userService = userService;
    }

    public AuthenticationManager getAuthManager() {
        return authManager;
    }

    public void setAuthManager(AuthenticationManager authManager) {
        this.authManager = authManager;
    }

    public UserSessionManager getSessionManager() {
        return sessionManager;
    }

    public void setSessionManager(UserSessionManager sessionManager) {
        this.sessionManager = sessionManager;
    }
}
