package com.neosavvy.user.service;

import com.neosavvy.user.dto.companyManagement.SecurityWrapperDTO;
import com.neosavvy.user.dto.companyManagement.UserDTO;
import com.neosavvy.user.dto.mobile.DashboardData;
import org.eclipse.persistence.sessions.factories.SessionManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;

import javax.ws.rs.PathParam;
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

    private ExpenseService expenseService;

    private UserService userService;

    private AuthenticationManager authManager;

    public SecurityWrapperDTO login(@PathParam("username") String username, @PathParam("password") String password) {
        Authentication authentication = authManager.authenticate(new UsernamePasswordAuthenticationToken(username, password));
        SecurityContextHolder.getContext().setAuthentication(authentication);
        /**
         * Should this be done as mentioned here:
         * http://jira.springframework.org/browse/SPR-4175 with a request scoped bean?
         *
         * TODO, sessionManager.initSession(userName, request, response);
         */
        return userService.getUserDetails();
    }


    public boolean logout() {
        SecurityContextHolder.clearContext();
        /**
         * TODO, sessionManager.invalidateCurrentSession(request, response);
         */
        return true;
    }

    public DashboardData findDashboardData(@PathParam("username") String username, @PathParam("password") String password) {

        SecurityContextHolder.getContext().setAuthentication(new UsernamePasswordAuthenticationToken(username, password));

        DashboardData dashboardData = new DashboardData();
        UserDTO user = new UserDTO();
        user.setUsername( username );

        dashboardData.setNumberExpenseReportsApproved( 0 );//expenseService.findExpenseReportsAwaitingApproval( user ).size() );
        dashboardData.setNumberExpenseReportsAwaitingApproval( expenseService.findExpenseReportsAwaitingApproval( user ).size() );
        dashboardData.setNumberExpenseReportsAwaitingReconciliation( 0 );//expenseService.findExpenseReportsAwaitingApproval( user ).size() );
        dashboardData.setNumberExpenseReportsDeclined( 0 );//expenseService.findDeclinedExpenseReportsForUser( user ).size() );
        dashboardData.setNumberExpenseReportsOpened( expenseService.findOpenExpenseReportsForUser( user ).size() );
        dashboardData.setNumberExpenseReportsReconciled( 0 );

        return dashboardData;
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
}
