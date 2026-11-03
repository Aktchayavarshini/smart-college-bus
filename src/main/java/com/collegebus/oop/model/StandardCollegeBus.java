package com.collegebus.oop.model;

/**
 * Concrete Subclass representing a Standard Non-AC College Bus.
 *
 * Demonstrates:
 * 1. Inheritance: StandardCollegeBus extends CollegeBus.
 * 2. Polymorphic Overriding: Specific operating costs and category indicators.
 * 3. Encapsulation: Attributes for emergency windows and seating configuration.
 */
public class StandardCollegeBus extends CollegeBus {

    private int emergencyExitCount;
    private boolean firstAidKitAvailable;

    public StandardCollegeBus() {
        super();
        this.emergencyExitCount = 2;
        this.firstAidKitAvailable = true;
    }

    public StandardCollegeBus(Long vehicleId, String busNumber, String registrationNumber,
                              int capacity, String routeName, int emergencyExitCount) {
        super(vehicleId, busNumber, registrationNumber, capacity, routeName);
        this.emergencyExitCount = emergencyExitCount;
        this.firstAidKitAvailable = true;
        setFuelEfficiencyKmPerLitre(4.8);
    }

    @Override
    public String getVehicleCategory() {
        return "STANDARD_NON_AC_BUS";
    }

    @Override
    public double calculateOperatingCostPerKm() {
        // Standard diesel consumption without compressor overhead
        return 95.0 / getFuelEfficiencyKmPerLitre();
    }

    @Override
    public double getComfortMultiplier() {
        return 1.0;
    }

    public int getEmergencyExitCount() {
        return emergencyExitCount;
    }

    public void setEmergencyExitCount(int emergencyExitCount) {
        this.emergencyExitCount = emergencyExitCount;
    }

    public boolean isFirstAidKitAvailable() {
        return firstAidKitAvailable;
    }

    public void setFirstAidKitAvailable(boolean firstAidKitAvailable) {
        this.firstAidKitAvailable = firstAidKitAvailable;
    }
}
