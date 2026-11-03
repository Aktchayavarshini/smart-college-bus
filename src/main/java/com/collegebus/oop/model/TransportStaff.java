package com.collegebus.oop.model;

import com.collegebus.oop.exception.InvalidDataException;

/**
 * Concrete Subclass representing Transportation Operations Staff / Bus Drivers.
 *
 * Demonstrates:
 * 1. Inheritance: Extends AbstractPerson.
 * 2. Polymorphic Overriding: Specialized role semantics (booking limit 0).
 * 3. Encapsulation: Commercial driving license and operational shifts.
 */
public class TransportStaff extends AbstractPerson {

    private String licenseNumber;
    private int experienceYears;
    private String dutyShift; // MORNING, EVENING, FULL_DAY

    public TransportStaff() {
        super();
        this.dutyShift = "MORNING";
    }

    public TransportStaff(Long id, String fullName, String email, String phoneNumber,
                          String licenseNumber, int experienceYears, String dutyShift) {
        super(id, fullName, email, phoneNumber, "DRIVER");
        setLicenseNumber(licenseNumber);
        setExperienceYears(experienceYears);
        this.dutyShift = dutyShift != null ? dutyShift : "MORNING";
    }

    @Override
    public String getRoleTitle() {
        return "Transport Operations Staff";
    }

    @Override
    public int getMaxSimultaneousBookings() {
        return 0; // Operating staff manage fleet rather than book passenger seats
    }

    @Override
    public String getIdentityBadge() {
        return String.format("LIC: %s | %d yrs exp | Shift: %s",
                this.licenseNumber, this.experienceYears, this.dutyShift);
    }

    public String getLicenseNumber() {
        return licenseNumber;
    }

    public void setLicenseNumber(String licenseNumber) {
        if (licenseNumber == null || licenseNumber.trim().isEmpty()) {
            throw new InvalidDataException("licenseNumber", "Heavy vehicle driving license cannot be empty");
        }
        this.licenseNumber = licenseNumber.trim().toUpperCase();
    }

    public int getExperienceYears() {
        return experienceYears;
    }

    public void setExperienceYears(int experienceYears) {
        if (experienceYears < 0) {
            throw new InvalidDataException("experienceYears", "Experience years cannot be negative");
        }
        this.experienceYears = experienceYears;
    }

    public String getDutyShift() {
        return dutyShift;
    }

    public void setDutyShift(String dutyShift) {
        this.dutyShift = dutyShift;
    }
}
