package com.collegebus.oop.model;

/**
 * Concrete Subclass representing a climate-controlled Deluxe Air Conditioned College Bus.
 *
 * Demonstrates:
 * 1. Multi-Level Inheritance: AirConditionedBus extends CollegeBus extends AbstractVehicle.
 * 2. Runtime Polymorphism (Method Overriding): Overrides getVehicleCategory(),
 *    calculateOperatingCostPerKm(), and getComfortMultiplier().
 * 3. Encapsulation: Specific AC attributes like compressor tonnage and temperature setting.
 */
public class AirConditionedBus extends CollegeBus {

    private double targetTemperatureCelsius;
    private boolean wifiEnabled;
    private double acSurchargePercentage;

    public AirConditionedBus() {
        super();
        this.targetTemperatureCelsius = 22.0;
        this.wifiEnabled = true;
        this.acSurchargePercentage = 0.25; // 25% premium for AC
    }

    public AirConditionedBus(Long vehicleId, String busNumber, String registrationNumber,
                             int capacity, String routeName, double targetTemperatureCelsius) {
        super(vehicleId, busNumber, registrationNumber, capacity, routeName);
        this.targetTemperatureCelsius = targetTemperatureCelsius;
        this.wifiEnabled = true;
        this.acSurchargePercentage = 0.25;
        // AC buses typically have lower fuel efficiency due to HVAC compressor load
        setFuelEfficiencyKmPerLitre(3.5);
    }

    // ==========================================
    // RUNTIME POLYMORPHIC METHOD OVERRIDING
    // ==========================================

    @Override
    public String getVehicleCategory() {
        return "DELUXE_AC_BUS";
    }

    @Override
    public double calculateOperatingCostPerKm() {
        // Additional 20% fuel & HVAC maintenance surcharge
        return super.calculateOperatingCostPerKm() * 1.25;
    }

    @Override
    public double getComfortMultiplier() {
        return 1.35; // 35% comfort premium
    }

    @Override
    public double calculateFare(double distanceKm) {
        // Applies base fare plus AC surcharge
        double base = super.calculateFare(distanceKm);
        return base * (1.0 + this.acSurchargePercentage);
    }

    @Override
    public String getSummaryDetails() {
        return String.format("%s | HVAC: %.1f°C | WiFi: %s",
                super.getSummaryDetails(),
                this.targetTemperatureCelsius,
                this.wifiEnabled ? "Yes" : "No");
    }

    // ==========================================
    // ENCAPSULATION: GETTERS AND SETTERS
    // ==========================================

    public double getTargetTemperatureCelsius() {
        return targetTemperatureCelsius;
    }

    public void setTargetTemperatureCelsius(double targetTemperatureCelsius) {
        this.targetTemperatureCelsius = targetTemperatureCelsius;
    }

    public boolean isWifiEnabled() {
        return wifiEnabled;
    }

    public void setWifiEnabled(boolean wifiEnabled) {
        this.wifiEnabled = wifiEnabled;
    }

    public double getAcSurchargePercentage() {
        return acSurchargePercentage;
    }

    public void setAcSurchargePercentage(double acSurchargePercentage) {
        this.acSurchargePercentage = acSurchargePercentage;
    }
}
