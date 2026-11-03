package com.collegebus.oop.interfaces;

/**
 * Interface defining the contract for any bookable asset or vehicle.
 * Demonstrates Abstraction by specifying mandatory behavioral contracts
 * without exposing internal implementation details.
 */
public interface Bookable {

    /**
     * Checks if at least one seat is currently available for allocation.
     * @return true if available seats > 0, false otherwise
     */
    boolean hasAvailableSeats();

    /**
     * Gets the current remaining available seats.
     * @return count of free seats
     */
    int getAvailableSeats();

    /**
     * Attempts to reserve a single seat.
     * @return true if reservation succeeded, false if vehicle is full
     */
    boolean reserveSeat();

    /**
     * Releases a previously reserved seat, restoring capacity.
     * @return true if release succeeded, false if already at maximum capacity
     */
    boolean releaseSeat();

    /**
     * Obtains a formatted summary of current reservation metrics.
     * @return summary string
     */
    String getReservationDetails();
}
