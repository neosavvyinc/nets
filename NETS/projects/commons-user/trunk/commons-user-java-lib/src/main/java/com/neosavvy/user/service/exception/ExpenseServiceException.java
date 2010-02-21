package com.neosavvy.user.service.exception;

public class ExpenseServiceException extends Exception {
    public ExpenseServiceException(String message) {
        super(message);
    }

    public ExpenseServiceException(String message, Throwable cause) {
        super(message, cause);
    }
}
