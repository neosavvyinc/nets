package fineline.focal.common.storage;

/**
 * This class is a derivative work of Fineline via Tommy Odom.
 * The code herein cannot be distributed without first establishing prior written consent
 * from tommy.odom@gmail.com
 */
public class ResourceNotFoundException extends Exception
{
    private static final long serialVersionUID = 1L;

    public ResourceNotFoundException() {
        // TODO Auto-generated constructor stub
    }

    public ResourceNotFoundException(String message) {
        super(message);
        // TODO Auto-generated constructor stub
    }

    public ResourceNotFoundException(Throwable cause) {
        super(cause);
        // TODO Auto-generated constructor stub
    }

    public ResourceNotFoundException(String message, Throwable cause) {
        super(message, cause);
        // TODO Auto-generated constructor stub
    }

}
