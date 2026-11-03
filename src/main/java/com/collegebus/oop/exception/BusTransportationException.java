package com.collegebus.oop.exception;

/**
 * Root checked exception for the College Bus Allocation domain.
 * Demonstrates Exception Handling hierarchy in Java.
 */
public class BusTransportationException extends Exception {

    private final String errorCode;

    public BusTransportationException(String message) {
        super(message);
        this.errorCode = "BUS_ERR_GENERAL";
    }

    public BusTransportationException(String errorCode, String message) {
        super(message);
        this.errorCode = errorCode;
    }

    public BusTransportationException(String errorCode, String message, Throwable cause) {
        super(message, cause);
        this.errorCode = errorCode;
    }

    public String getErrorCode() {
        return errorCode;
    }
}
