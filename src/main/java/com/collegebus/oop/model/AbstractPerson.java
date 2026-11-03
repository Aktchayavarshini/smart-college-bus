package com.collegebus.oop.model;

import com.collegebus.oop.exception.InvalidDataException;
import com.collegebus.oop.interfaces.Displayable;

/**
 * Abstract Base Class representing any stakeholder in the transit ecosystem.
 *
 * Demonstrates:
 * 1. Abstraction: Declares abstract methods defining role identity and booking quotas.
 * 2. Encapsulation: Strict data hiding for contact information, credentials, and state.
 * 3. Inheritance Base: Parent for StudentPassenger, FacultyPassenger, and TransportStaff.
 */
public abstract class AbstractPerson implements Displayable {

    private Long id;
    private String fullName;
    private String email;
    private String phoneNumber;
    private String role; // STUDENT, TEACHER, ADMIN, DRIVER
    private String accountStatus; // ACTIVE, INACTIVE

    public AbstractPerson() {
        this.accountStatus = "ACTIVE";
    }

    public AbstractPerson(Long id, String fullName, String email, String phoneNumber, String role) {
        this.id = id;
        setFullName(fullName);
        setEmail(email);
        setPhoneNumber(phoneNumber);
        this.role = role;
        this.accountStatus = "ACTIVE";
    }

    // ==========================================
    // ABSTRACT METHODS (Abstraction contract)
    // ==========================================

    /**
     * Returns the formal academic or operational role title.
     * @return role title string
     */
    public abstract String getRoleTitle();

    /**
     * Determines maximum simultaneous active bookings permitted for this role.
     * Students = 1, Faculty = 2 (for official academic duties), Staff = 0.
     * @return maximum active booking limit
     */
    public abstract int getMaxSimultaneousBookings();

    /**
     * Returns an identification badge string for print passes and logs.
     * @return unique badge string
     */
    public abstract String getIdentityBadge();

    // ==========================================
    // CONCRETE METHODS
    // ==========================================

    public boolean isActive() {
        return "ACTIVE".equalsIgnoreCase(this.accountStatus);
    }

    /**
     * Masks the commuter's phone number for privacy preservation.
     * @return masked phone string (e.g. ******3456)
     */
    public String getMaskedPhone() {
        if (this.phoneNumber != null && this.phoneNumber.length() >= 4) {
            String lastFour = this.phoneNumber.substring(this.phoneNumber.length() - 4);
            return "******" + lastFour;
        }
        return "**********";
    }

    @Override
    public String getSummaryDetails() {
        return String.format("[%s] %s (%s) | Contact: %s | Status: %s",
                getRoleTitle(),
                this.fullName,
                this.email,
                getMaskedPhone(),
                this.accountStatus);
    }

    // ==========================================
    // ENCAPSULATION: VALIDATED GETTERS & SETTERS
    // ==========================================

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        if (fullName == null || fullName.trim().isEmpty()) {
            throw new InvalidDataException("fullName", "Person name cannot be null or empty");
        }
        this.fullName = fullName.trim();
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        if (email == null || !email.matches("^[A-Za-z0-9+_.-]+@(.+)$")) {
            throw new InvalidDataException("email", "Invalid email address format: " + email);
        }
        this.email = email.trim().toLowerCase();
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        if (phoneNumber == null || !phoneNumber.replaceAll("[^0-9]", "").matches("\\d{10}")) {
            throw new InvalidDataException("phoneNumber", "Phone number must contain exactly 10 digits");
        }
        this.phoneNumber = phoneNumber.trim();
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public String getAccountStatus() {
        return accountStatus;
    }

    public void setAccountStatus(String accountStatus) {
        this.accountStatus = accountStatus;
    }
}
