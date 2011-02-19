package flex.messaging.io;

import fineline.focal.common.security.UserSessionManager;
import flex.messaging.FlexContext;
import flex.messaging.MessageBroker;
import flex.messaging.security.LoginCommand;
import org.springframework.flex.config.MessageBrokerConfigProcessor;
import org.springframework.flex.security3.SpringSecurityLoginCommand;
import org.springframework.security.authentication.AuthenticationManager;

import javax.servlet.ServletConfig;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.security.Principal;
import java.util.List;

public class CustomFlexLoginCommand extends SpringSecurityLoginCommand {
    private UserSessionManager sessionManager;

    public CustomFlexLoginCommand(AuthenticationManager authManager) {
        super(authManager);
    }

    @Override
    public Principal doAuthentication(String username, Object credentials) {
        Principal auth = super.doAuthentication(username, credentials);

        if (auth != null) {
            sessionManager.initSession(username, getRequest(), getResponse());
        }

        return auth;
    }

    @Override
    public boolean logout(Principal principal) {
        super.logout(principal);
        sessionManager.invalidateCurrentSession(getRequest(), getResponse());
        return true;
    }

    private HttpServletRequest getRequest() {
        return FlexContext.getHttpRequest();
    }

    private HttpServletResponse getResponse() {
        return FlexContext.getHttpResponse();
    }

    public UserSessionManager getSessionManager() {
        return sessionManager;
    }

    public void setSessionManager(UserSessionManager sessionManager) {
        this.sessionManager = sessionManager;
    }
}
