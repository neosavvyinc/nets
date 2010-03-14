package fineline.focal.common.security;

import java.io.IOException;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import fineline.focal.common.types.v1.UserSession;
import fineline.focal.common.utils.StringUtils;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.preauth.PreAuthenticatedAuthenticationToken;
import org.springframework.security.authentication.AuthenticationDetailsSource;
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource;
import org.springframework.security.web.authentication.preauth.AbstractPreAuthenticatedProcessingFilter;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.transaction.annotation.Transactional;

@Transactional
public class UserSessionPreAuthenticatedProcessingFilter extends AbstractPreAuthenticatedProcessingFilter {
    @PersistenceContext
    private EntityManager entityManager;
    private UserSessionManager sessionManager;
    private String paramName = null;
    private AuthenticationDetailsSource authenticationDetailsSource = new WebAuthenticationDetailsSource();
    private AuthenticationManager authenticationManager;
    
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        UserSession UserSession = getUserSession((HttpServletRequest)request);
        
        if (UserSession != null && auth != null && !UserSession.getUsername().equals(getUsername(auth.getPrincipal()))) {
            // If the username for the current Session does not match the current Java session (JSESSIONID cookie) username,
            // then the user has logged out and logged back in as a different user.  Null out the authentication in the session so the user will be re-authenticated.
            SecurityContextHolder.getContext().setAuthentication(null);
            auth = null;
        }
        
        if (auth == null) {
            doAuthenticate((HttpServletRequest)request, (HttpServletResponse)response, UserSession);
        }
        
        chain.doFilter(request, response);
    }
    
    // Copied from AbstractPreAuthenticatedProcessingFilter and modified
    private void doAuthenticate(HttpServletRequest request, HttpServletResponse response, UserSession UserSession) {
        Authentication authResult = null;
        
        if (UserSession == null) {
            if (logger.isDebugEnabled()) {
                logger.debug("No user session ID found in request");
            }
            return;     
        }

        Object principal = UserSession.getUsername();
        Object credentials = getPreAuthenticatedCredentials(request);

        if (logger.isDebugEnabled()) {
            logger.debug("preAuthenticatedPrincipal = " + principal + ", trying to authenticate");
        }

        try {
            PreAuthenticatedAuthenticationToken authRequest = new PreAuthenticatedAuthenticationToken(principal, credentials);
            authRequest.setDetails(authenticationDetailsSource.buildDetails(request));
            authResult = authenticationManager.authenticate(authRequest);
            successfulAuthentication(request, response, authResult, UserSession);
        } catch (AuthenticationException failed) {
            unsuccessfulAuthentication(request, response, failed);
        }
    }
    
    protected void successfulAuthentication(HttpServletRequest request, HttpServletResponse response, Authentication authResult, UserSession userSession) {
        super.successfulAuthentication(request, response, authResult);
        
        sessionManager.initUserSession(userSession, request, response);
    }
    
    private String getUsername(Object principal) {
        if (principal instanceof String) {
            return (String)principal;
        }
        else if (principal instanceof UserDetails) {
           return ((UserDetails)principal).getUsername();
        }
        return null;
    }
    
    private UserSession getUserSession(HttpServletRequest request) {
        // First try getting the sessionId from a query param, then try getting it from a cookie
        String sessionId = null;
        if (paramName != null) {
            sessionId = request.getParameter(paramName);
        }
        if (StringUtils.isEmpty(sessionId)) {
            Cookie sessionCookie = CookieHelper.getCookie(request, sessionManager.getSessionCookieName());
            if (sessionCookie != null) {
                sessionId = sessionCookie.getValue();
            }
        }
        if (StringUtils.isEmpty(sessionId)) {
            return null;
        }
        Query query = entityManager.createQuery("SELECT s FROM UserSession s WHERE s.id=:sessionId");
        query.setParameter("sessionId", sessionId);
        List<UserSession> results = query.getResultList();
        if (results == null || results.size() == 0) {
            return null;
        }
        return results.get(0);
    }
    
    
    
    @Override
    protected Object getPreAuthenticatedPrincipal(HttpServletRequest request) {
        return getUserSession(request).getUsername();
    }

    @Override
    protected Object getPreAuthenticatedCredentials(HttpServletRequest request) {
        return "N/A";
    }

    public String getParamName() {
        return paramName;
    }
    public void setParamName(String paramName) {
        this.paramName = paramName;
    }
    
    public void setAuthenticationManager(AuthenticationManager authenticationManager) {
        this.authenticationManager = authenticationManager;
        super.setAuthenticationManager(authenticationManager);
    }

    public UserSessionManager getSessionManager() {
        return sessionManager;
    }

    public void setSessionManager(UserSessionManager sessionManager) {
        this.sessionManager = sessionManager;
    }

}
