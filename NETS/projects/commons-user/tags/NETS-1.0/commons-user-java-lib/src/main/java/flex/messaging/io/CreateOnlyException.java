package flex.messaging.io;

public class CreateOnlyException extends RuntimeException
{
    private static final long serialVersionUID = -879711513342543230L;

    public CreateOnlyException()
    {
        
    }

    public CreateOnlyException(String message)
    {
        super(message);        
    }

    public CreateOnlyException(Throwable cause)
    {
        super(cause);        
    }

    public CreateOnlyException(String message, Throwable cause)
    {
        super(message, cause);        
    }

}
