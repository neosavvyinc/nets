package com.neosavvy.security;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.security.Authentication;
import org.springframework.security.GrantedAuthority;
import org.springframework.security.GrantedAuthorityImpl;
import org.springframework.security.context.SecurityContextHolder;
import org.springframework.security.providers.preauth.PreAuthenticatedAuthenticationToken;

import java.util.logging.Logger;

/**
 * Created by IntelliJ IDEA.
 * User: tommyodom
 * Date: Jan 18, 2010
 * Time: 8:26:29 PM
 * To change this template use File | Settings | File Templates.
 */
public class RunAsExecutor {

    private String administratorUser;
    private String administratorPassword;
    private String administratorRole;

    public void runAsAdmin(Runnable runnable) {
        Authentication currentAuthentication = getCurrentAuthentication();
		try {
            setCurrentAuthentication(createAuthentication(administratorRole));
            runnable.run();            
		}
		catch (Throwable t) {
			throw new RuntimeException(t);
		}
        finally {
            setCurrentAuthentication(currentAuthentication);
        }
	}

    private Authentication getCurrentAuthentication() {
        if (SecurityContextHolder.getContext() == null) {
            return null;
        }

        return SecurityContextHolder.getContext().getAuthentication();
    }

    private void setCurrentAuthentication(Authentication auth) {
        SecurityContextHolder.getContext().setAuthentication(auth);
    }

    private Authentication createAuthentication(String role) {
        GrantedAuthority[] authorities = new GrantedAuthority[1];
        authorities[0] = new GrantedAuthorityImpl(role);
        PreAuthenticatedAuthenticationToken token = new PreAuthenticatedAuthenticationToken(administratorUser, administratorPassword, authorities);
        return token;
    }

    public String getAdministratorUser() {
        return administratorUser;
    }

    public void setAdministratorUser(String administratorUser) {
        this.administratorUser = administratorUser;
    }

    public String getAdministratorPassword() {
        return administratorPassword;
    }

    public void setAdministratorPassword(String administratorPassword) {
        this.administratorPassword = administratorPassword;
    }

    public String getAdministratorRole() {
        return administratorRole;
    }

    public void setAdministratorRole(String administratorRole) {
        this.administratorRole = administratorRole;
    }
}
