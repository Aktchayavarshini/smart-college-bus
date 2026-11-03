package com.collegebus.oop.interfaces;

/**
 * Interface demonstrating Abstraction and Method Overloading (Compile-Time Polymorphism).
 * Defines overloaded methods for computing transit fares under varying conditions.
 */
public interface FareCalculable {

    /**
     * Standard fare calculation based solely on distance.
     * @param distanceKm travel distance in kilometers
     * @return calculated fare in INR
     */
    double calculateFare(double distanceKm);

    /**
     * Overloaded method: Fare calculation factoring in peak-hour traffic multipliers.
     * @param distanceKm travel distance in kilometers
     * @param peakHour flag indicating if the journey departs during peak traffic hours
     * @return calculated fare in INR
     */
    double calculateFare(double distanceKm, boolean peakHour);

    /**
     * Overloaded method: Fare calculation factoring in peak-hour and special institutional concession.
     * @param distanceKm travel distance in kilometers
     * @param peakHour flag indicating peak rush hour
     * @param facultyConcession flag indicating faculty/concession eligibility
     * @return calculated fare in INR
     */
    double calculateFare(double distanceKm, boolean peakHour, boolean facultyConcession);
}
