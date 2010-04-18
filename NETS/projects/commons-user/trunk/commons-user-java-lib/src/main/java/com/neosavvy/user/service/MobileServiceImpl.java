package com.neosavvy.user.service;

import com.neosavvy.user.dto.companyManagement.SecurityWrapperDTO;
import com.neosavvy.user.dto.companyManagement.UserDTO;
import com.neosavvy.user.dto.mobile.DashboardData;
import com.neosavvy.user.service.exception.MobileServiceException;
import fineline.focal.common.http.HttpUtils;
import fineline.focal.common.security.UserSessionManager;
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

    public SecurityWrapperDTO login(@FormParam("username") String username, @FormParam("password") String password) {
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

    public DashboardData findDashboardData() {

        UserDetails userDetails = findUserDetailsOrThrowException();


        DashboardData dashboardData = new DashboardData();
        UserDTO user = new UserDTO();
        user.setUsername( userDetails.getUsername() );

        dashboardData.setNumberExpenseReportsApproved( expenseService.findExpenseReportsApproved( user ).size() );
        dashboardData.setNumberExpenseReportsAwaitingApproval( expenseService.findExpenseReportsAwaitingApproval( user ).size() );
        dashboardData.setNumberExpenseReportsAwaitingReconciliation( expenseService.findReimbursedReportsForUser( user ).size() );
        dashboardData.setNumberExpenseReportsDeclined( expenseService.findDeclinedExpenseReportsForUser( user ).size() );
        dashboardData.setNumberExpenseReportsOpened( expenseService.findOpenExpenseReportsForUser( user ).size() );
        dashboardData.setNumberExpenseReportsReconciled( expenseService.findExpenseReportsReconciled( user ).size() );

        logger.debug(dashboardData.toString());

        return dashboardData;
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
