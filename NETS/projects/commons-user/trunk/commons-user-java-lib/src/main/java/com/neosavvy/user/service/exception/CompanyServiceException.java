package com.neosavvy.user.service.exception;

/**
 * Created by IntelliJ IDEA.
 * User: lgleason
 * Date: Dec 14, 2009
 * Time: 2:44:26 PM
 */
public class CompanyServiceException extends RuntimeException{

    public CompanyServiceException(String message) {
        super(message);
    }

    public CompanyServiceException(String message, Exception cause) {
        super(message, cause);
    }    
}
