package fineline.focal.common.security;

import fineline.focal.common.service.CommandService;
import fineline.focal.common.utils.StringUtils;
import fineline.focal.common.types.v1.UserSession;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class UserSessionManager
{
    private static final String USER_SESSION_ATTRIBUTE_NAME = "customUserSession";

    @PersistenceContext
    private EntityManager entityManager;
    private CommandService commandService;

    private String sessionCookieName = "FLSESSIONID";
    private String cookieDomain;

    public void initSession(String username, HttpServletRequest request, HttpServletResponse response) {
        UserSession session = createSession(username);
        initUserSession(session, request, response);
    }

    public void initUserSession(UserSession session, HttpServletRequest request, HttpServletResponse response) {
        addSessionCookie(sessionCookieName, session.getId(), response, false);
        request.getSession().setAttribute(USER_SESSION_ATTRIBUTE_NAME, session);
    }

    public void invalidateCurrentSession(HttpServletRequest request, HttpServletResponse response) {
        UserSession session = (UserSession)request.getSession().getAttribute(USER_SESSION_ATTRIBUTE_NAME);
        if (session != null) {
            commandService.inTransaction(new RemoveSessionCommand(session, entityManager));
        }
        removeSessionCookies(response);
    }

    public void removeSessionCookies(HttpServletResponse response) {
        deleteSessionCookie(sessionCookieName, response, false);
        deleteSessionCookie(sessionCookieName, response, true);
    }

    public Cookie createSessionCookie(UserSession session) {
        return createSessionCookie(sessionCookieName, session.getId(), -1, false);
    }

    protected Cookie createSessionCookie(String name, String value, int maxAge, boolean useCookieDomainIfAvailable) {
        Cookie sessionCookie = new Cookie(name, value);
        sessionCookie.setPath("/");
        sessionCookie.setMaxAge(maxAge);
        if (useCookieDomainIfAvailable && !StringUtils.isEmpty(cookieDomain)) {
            sessionCookie.setDomain(cookieDomain);
        }
        return sessionCookie;
    }

    public void addSessionCookie(String name, String value, HttpServletResponse response, boolean useCookieDomainIfAvailable) {
        response.addCookie(createSessionCookie(name, value, -1, useCookieDomainIfAvailable));
    }

    protected void deleteSessionCookie(String name, HttpServletResponse response, boolean useCookieDomainIfAvailable) {
        response.addCookie(createSessionCookie(name, "deleted", 0, useCookieDomainIfAvailable));
    }

    public UserSession createSession(String username) {
        UserSession session = new UserSession(username);
        commandService.inTransaction(new PersistSessionCommand(session, entityManager));
        return session;
    }

    public String getSessionCookieName() {
        return this.sessionCookieName;
    }

    public void setSessionCookieName(String sessionCookieName) {
        this.sessionCookieName = sessionCookieName;
    }

    public CommandService getCommandService() {
        return commandService;
    }
    public void setCommandService(CommandService commandService) {
        this.commandService = commandService;
    }

    public void setCookieDomain(String cookieDomain) {
        this.cookieDomain = cookieDomain;
    }

}
