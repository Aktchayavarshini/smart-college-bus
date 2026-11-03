package com.collegebus.oop.exception;

/**
 * Custom checked exception thrown when attempting to reserve a seat on a bus
 * that has reached its maximum passenger capacity.
 */
public class SeatNotAvailableException extends BusTransportationException {

    private final String busNumber;
    private final int requestedSeats;
    private final int availableSeats;

    public SeatNotAvailableException(String busNumber, int requestedSeats, int availableSeats) {
        super("SEAT_UNAVAILABLE", 
              String.format("Cannot allocate %d seat(s) on Bus '%s'. Remaining capacity: %d", 
                            requestedSeats, busNumber, availableSeats));
        this.busNumber = busNumber;
        this.requestedSeats = requestedSeats;
        this.availableSeats = availableSeats;
    }

    public String getBusNumber() {
        return busNumber;
    }

    public int getRequestedSeats() {
        return requestedSeats;
    }

    public int getAvailableSeats() {
        return availableSeats;
    }
}
