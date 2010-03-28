package fineline.focal.common.http;

import javax.servlet.http.HttpServletRequest;

/**
 * This class is a derivative work of Fineline via Tommy Odom.
 * The code herein cannot be distributed without first establishing prior written consent
 * from tommy.odom@gmail.com
 */
public class HttpUtils {
    private static ThreadLocal<HttpServletRequest> httpRequest = new ThreadLocal<HttpServletRequest>();

    /**
     * Returns the portion of the request URL up through the context path. This
     * does not include a trailing slash.
     *
     * @param request
     *            The current HTTP request
     * @return The URL of the current request up through the context path
     */
    public static String getContextUrl() {
        StringBuilder builder = new StringBuilder();

        HttpServletRequest request = getHttpRequest();
        builder.append(request.isSecure() ? "https://" : "http://");
        builder.append(request.getServerName());
        builder.append(":");
        builder.append(request.getServerPort());
        builder.append(request.getContextPath());

        return builder.toString();
    }

    /**
     * Stores the HttpServletRequest in a thread local
     *
     * @param request
     *            The HttpServletRequest to store
     */
    public static void setHttpRequest(HttpServletRequest request) {
        httpRequest.set(request);
    }

    /**
     * Retrieves the HttpServletRequest for the thread from the thread local
     *
     * @return The current HttpServletRequest for this thread
     * @throws RuntimeException
     *             If the HttpServletRequest has not been set on the thread
     *             local for this thread
     */
    public static HttpServletRequest getHttpRequest() {
        HttpServletRequest request = httpRequest.get();

        if (request == null) {
            throw new RuntimeException(
                    "The thread local value has not been set for the HttpServletRequest.  "
                            + "Please ensure you are calling this within the context of an HTTP request and that the HttpServletRequestFilter servlet filter is configured in your web.xml");
        }

        return request;
    }
}
