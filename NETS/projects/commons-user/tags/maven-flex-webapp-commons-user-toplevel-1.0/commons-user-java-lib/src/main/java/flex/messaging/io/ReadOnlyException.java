package flex.messaging.io;

public class ReadOnlyException extends RuntimeException
{
    private static final long serialVersionUID = 6654222921835233720L;

    public ReadOnlyException()
    {
        
    }

    public ReadOnlyException(String message)
    {
        super(message);
    }

    public ReadOnlyException(Throwable cause)
    {
        super(cause);
    }

    public ReadOnlyException(String message, Throwable cause)
    {
        super(message, cause);
    }

}
