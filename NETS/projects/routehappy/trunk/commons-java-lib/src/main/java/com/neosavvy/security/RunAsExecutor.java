package com.neosavvy.security;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.GrantedAuthorityImpl;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.preauth.PreAuthenticatedAuthenticationToken;

import java.util.ArrayList;
import java.util.List;
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
        List<GrantedAuthority> authorities = new ArrayList<GrantedAuthority>();
        authorities.add(new GrantedAuthorityImpl(role));
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
