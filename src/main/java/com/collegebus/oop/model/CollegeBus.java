package com.collegebus.oop.model;

import com.collegebus.oop.exception.InvalidDataException;
import com.collegebus.oop.interfaces.Bookable;
import com.collegebus.oop.interfaces.FareCalculable;

/**
 * Concrete domain class representing an institutional college transport bus.
 *
 * Demonstrates:
 * 1. Inheritance: Extends AbstractVehicle.
 * 2. Abstraction: Implements Bookable and FareCalculable interfaces.
 * 3. Encapsulation: Protects seat allocation invariants.
 * 4. Polymorphism: Method Overloading (calculateFare) and Method Overriding.
 */
public class CollegeBus extends AbstractVehicle implements Bookable, FareCalculable {

    private String busNumber;
    private String routeName;
    private int bookedSeats;
    private double baseFarePerKm;

    public CollegeBus() {
        super();
        this.bookedSeats = 0;
        this.baseFarePerKm = 2.0; // Standard Rs. 2.0 per km
    }

    public CollegeBus(Long vehicleId, String busNumber, String registrationNumber, int capacity, String routeName) {
        super(vehicleId, registrationNumber, capacity, "ACTIVE");
        setBusNumber(busNumber);
        this.routeName = routeName;
        this.bookedSeats = 0;
        this.baseFarePerKm = 2.0;
    }

    // ==========================================
    // INHERITED ABSTRACT METHOD IMPLEMENTATIONS
    // ==========================================

    @Override
    public String getVehicleCategory() {
        return "COLLEGE_BUS";
    }

    @Override
    public double calculateOperatingCostPerKm() {
        // Average diesel price 95 INR / 4.5 km per litre = ~21.11 INR/km
        return 95.0 / getFuelEfficiencyKmPerLitre();
    }

    @Override
    public double getComfortMultiplier() {
        return 1.0;
    }

    // ==========================================
    // BOOKABLE INTERFACE CONTRACT
    // ==========================================

    @Override
    public boolean hasAvailableSeats() {
        return getAvailableSeats() > 0;
    }

    @Override
    public int getAvailableSeats() {
        return Math.max(0, getCapacity() - this.bookedSeats);
    }

    @Override
    public synchronized boolean reserveSeat() {
        if (hasAvailableSeats()) {
            this.bookedSeats++;
            return true;
        }
        return false;
    }

    @Override
    public synchronized boolean releaseSeat() {
        if (this.bookedSeats > 0) {
            this.bookedSeats--;
            return true;
        }
        return false;
    }

    @Override
    public String getReservationDetails() {
        return String.format("Bus '%s' | Total: %d | Booked: %d | Free: %d",
                this.busNumber, getCapacity(), this.bookedSeats, getAvailableSeats());
    }

    // ==========================================
    // FARECALCULABLE: METHOD OVERLOADING (COMPILE-TIME POLYMORPHISM)
    // ==========================================

    /**
     * Overload 1: Basic fare calculation based on distance.
     */
    @Override
    public double calculateFare(double distanceKm) {
        return Math.max(10.0, distanceKm * this.baseFarePerKm * getComfortMultiplier());
    }

    /**
     * Overload 2: Distance + Peak-Hour rush multiplier.
     */
    @Override
    public double calculateFare(double distanceKm, boolean peakHour) {
        double standard = calculateFare(distanceKm);
        return peakHour ? standard * 1.20 : standard;
    }

    /**
     * Overload 3: Distance + Peak-Hour + Faculty Concession discount.
     */
    @Override
    public double calculateFare(double distanceKm, boolean peakHour, boolean facultyConcession) {
        double fare = calculateFare(distanceKm, peakHour);
        return facultyConcession ? fare * 0.70 : fare; // 30% concession
    }

    // ==========================================
    // METHOD OVERRIDING (RUNTIME POLYMORPHISM)
    // ==========================================

    @Override
    public String getSummaryDetails() {
        return String.format("[%s] No: %s | Route: %s | %s",
                getVehicleCategory(),
                this.busNumber,
                this.routeName != null ? this.routeName : "Unassigned",
                getReservationDetails());
    }

    // ==========================================
    // ENCAPSULATION: GETTERS AND SETTERS
    // ==========================================

    public String getBusNumber() {
        return busNumber;
    }

    public void setBusNumber(String busNumber) {
        if (busNumber == null || busNumber.trim().isEmpty()) {
            throw new InvalidDataException("busNumber", "Bus identifier (e.g. BUS-101) cannot be empty");
        }
        this.busNumber = busNumber.trim().toUpperCase();
    }

    public String getRouteName() {
        return routeName;
    }

    public void setRouteName(String routeName) {
        this.routeName = routeName;
    }

    public int getBookedSeats() {
        return bookedSeats;
    }

    public void setBookedSeats(int bookedSeats) {
        if (bookedSeats < 0 || bookedSeats > getCapacity()) {
            throw new InvalidDataException("bookedSeats",
                    String.format("Booked seats (%d) cannot exceed total capacity (%d) or be negative", bookedSeats, getCapacity()));
        }
        this.bookedSeats = bookedSeats;
    }

    public double getBaseFarePerKm() {
        return baseFarePerKm;
    }

    public void setBaseFarePerKm(double baseFarePerKm) {
        if (baseFarePerKm < 0) {
            throw new InvalidDataException("baseFarePerKm", "Base fare cannot be negative");
        }
        this.baseFarePerKm = baseFarePerKm;
    }
}
