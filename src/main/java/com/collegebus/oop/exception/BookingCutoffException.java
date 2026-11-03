package com.collegebus.oop.exception;

/**
 * Custom checked exception thrown when a booking or cancellation attempt
 * occurs after the scheduled operational cutoff time.
 */
public class BookingCutoffException extends BusTransportationException {

    private final String cutoffTime;

    public BookingCutoffException(String message, String cutoffTime) {
        super("BOOKING_CUTOFF_EXCEEDED", message);
        this.cutoffTime = cutoffTime;
    }

    public String getCutoffTime() {
        return cutoffTime;
    }
}
