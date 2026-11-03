package com.collegebus.oop.model;

import com.collegebus.oop.exception.InvalidDataException;

/**
 * Concrete Subclass representing a Teaching Faculty Commuter.
 *
 * Demonstrates:
 * 1. Inheritance: Extends AbstractPerson.
 * 2. Polymorphic Overriding: Specific role title, booking limit of 2, and faculty badge.
 * 3. Encapsulation: Employee ID and designation data protection.
 */
public class FacultyPassenger extends AbstractPerson {

    private String employeeId;
    private String department;
    private String designation;

    public FacultyPassenger() {
        super();
    }

    public FacultyPassenger(Long id, String fullName, String email, String phoneNumber,
                            String employeeId, String department, String designation) {
        super(id, fullName, email, phoneNumber, "TEACHER");
        setEmployeeId(employeeId);
        this.department = department;
        this.designation = designation;
    }

    @Override
    public String getRoleTitle() {
        return "Faculty Passenger";
    }

    @Override
    public int getMaxSimultaneousBookings() {
        return 2; // Faculty allowed up to 2 simultaneous bookings for academic and lab duties
    }

    @Override
    public String getIdentityBadge() {
        return String.format("EMP: %s | %s (%s)",
                this.employeeId, this.designation, this.department);
    }

    public String getEmployeeId() {
        return employeeId;
    }

    public void setEmployeeId(String employeeId) {
        if (employeeId == null || employeeId.trim().isEmpty()) {
            throw new InvalidDataException("employeeId", "Faculty employee ID cannot be empty");
        }
        this.employeeId = employeeId.trim().toUpperCase();
    }

    public String getDepartment() {
        return department;
    }

    public void setDepartment(String department) {
        this.department = department;
    }

    public String getDesignation() {
        return designation;
    }

    public void setDesignation(String designation) {
        this.designation = designation;
    }
}
