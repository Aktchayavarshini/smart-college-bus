package com.collegebus.oop.model;

import com.collegebus.oop.exception.InvalidDataException;
import com.collegebus.oop.interfaces.Displayable;

/**
 * Abstract Base Class representing any institutional motor vehicle.
 *
 * Demonstrates:
 * 1. Abstraction: Declares abstract methods that subclasses MUST define.
 * 2. Encapsulation: All state attributes are strictly private with validated getters/setters.
 */
public abstract class AbstractVehicle implements Displayable {

    private Long vehicleId;
    private String registrationNumber;
    private int capacity;
    private String status; // ACTIVE, MAINTENANCE, INACTIVE
    private double fuelEfficiencyKmPerLitre;

    /**
     * Default constructor.
     */
    public AbstractVehicle() {
        this.status = "ACTIVE";
        this.fuelEfficiencyKmPerLitre = 4.5;
    }

    /**
     * Parameterized constructor demonstrating data encapsulation and initialization.
     */
    public AbstractVehicle(Long vehicleId, String registrationNumber, int capacity, String status) {
        setVehicleId(vehicleId);
        setRegistrationNumber(registrationNumber);
        setCapacity(capacity);
        setStatus(status);
        this.fuelEfficiencyKmPerLitre = 4.5;
    }

    // ==========================================
    // ABSTRACT METHODS (Abstraction contract)
    // ==========================================

    /**
     * Identifies the category tier of the vehicle.
     * @return category string (e.g., DELUXE_AC_BUS, STANDARD_NON_AC_BUS)
     */
    public abstract String getVehicleCategory();

    /**
     * Calculates operational fuel and maintenance expenditure per kilometer.
     * Implemented polymorphically by concrete vehicle sub-types.
     * @return cost in INR per km
     */
    public abstract double calculateOperatingCostPerKm();

    /**
     * Returns comfort multiplier used for premium fare adjustments.
     * @return multiplier value (e.g. 1.0 for standard, 1.35 for AC)
     */
    public abstract double getComfortMultiplier();

    // ==========================================
    // CONCRETE METHODS (Shared reusable logic)
    // ==========================================

    public boolean isOperational() {
        return "ACTIVE".equalsIgnoreCase(this.status);
    }

    @Override
    public String getSummaryDetails() {
        return String.format("[%s] Reg: %s | Capacity: %d seats | Status: %s",
                getVehicleCategory(),
                this.registrationNumber != null ? this.registrationNumber : "UNREGISTERED",
                this.capacity,
                this.status);
    }

    // ==========================================
    // ENCAPSULATION: GETTERS AND VALIDATED SETTERS
    // ==========================================

    public Long getVehicleId() {
        return vehicleId;
    }

    public void setVehicleId(Long vehicleId) {
        this.vehicleId = vehicleId;
    }

    public String getRegistrationNumber() {
        return registrationNumber;
    }

    public void setRegistrationNumber(String registrationNumber) {
        if (registrationNumber == null || registrationNumber.trim().isEmpty()) {
            throw new InvalidDataException("registrationNumber", "Vehicle registration plate cannot be null or empty");
        }
        this.registrationNumber = registrationNumber.trim().toUpperCase();
    }

    public int getCapacity() {
        return capacity;
    }

    public void setCapacity(int capacity) {
        if (capacity <= 0 || capacity > 100) {
            throw new InvalidDataException("capacity", "Bus passenger capacity must be between 1 and 100 seats");
        }
        this.capacity = capacity;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        if (status == null || status.trim().isEmpty()) {
            this.status = "ACTIVE";
        } else {
            this.status = status.trim().toUpperCase();
        }
    }

    public double getFuelEfficiencyKmPerLitre() {
        return fuelEfficiencyKmPerLitre;
    }

    public void setFuelEfficiencyKmPerLitre(double fuelEfficiencyKmPerLitre) {
        if (fuelEfficiencyKmPerLitre <= 0) {
            throw new InvalidDataException("fuelEfficiency", "Fuel efficiency must be positive");
        }
        this.fuelEfficiencyKmPerLitre = fuelEfficiencyKmPerLitre;
    }
}
