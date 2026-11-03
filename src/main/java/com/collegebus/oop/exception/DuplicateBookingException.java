package com.collegebus.oop.exception;

/**
 * Custom checked exception thrown when a passenger attempts to create a secondary active booking
 * for a travel slot where they already hold a confirmed reservation.
 */
public class DuplicateBookingException extends BusTransportationException {

    private final String userEmail;
    private final String travelDate;
    private final String departureSlot;

    public DuplicateBookingException(String userEmail, String travelDate, String departureSlot) {
        super("DUPLICATE_BOOKING", 
              String.format("User '%s' already holds an active booking for date %s, slot %s. Duplicate bookings are prohibited.", 
                            userEmail, travelDate, departureSlot));
        this.userEmail = userEmail;
        this.travelDate = travelDate;
        this.departureSlot = departureSlot;
    }

    public String getUserEmail() {
        return userEmail;
    }

    public String getTravelDate() {
        return travelDate;
    }

    public String getDepartureSlot() {
        return departureSlot;
    }
}
