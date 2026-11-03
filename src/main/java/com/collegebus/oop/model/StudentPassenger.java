package com.collegebus.oop.model;

import com.collegebus.oop.exception.InvalidDataException;

/**
 * Concrete Subclass representing an enrolled Student Commuter.
 *
 * Demonstrates:
 * 1. Inheritance: Extends AbstractPerson.
 * 2. Polymorphic Overriding: Specific role title, booking limit of 1, and student badge.
 * 3. Encapsulation: Protects student academic attributes.
 */
public class StudentPassenger extends AbstractPerson {

    private String rollNumber;
    private String department;
    private int academicYear;
    private int semester;
    private String studentType; // DAY_SCHOLAR, HOSTEL
    private String hostelName;

    public StudentPassenger() {
        super();
        this.studentType = "DAY_SCHOLAR";
    }

    public StudentPassenger(Long id, String fullName, String email, String phoneNumber,
                            String rollNumber, String department, int academicYear,
                            int semester, String studentType, String hostelName) {
        super(id, fullName, email, phoneNumber, "STUDENT");
        setRollNumber(rollNumber);
        this.department = department;
        setAcademicYear(academicYear);
        setSemester(semester);
        this.studentType = studentType != null ? studentType : "DAY_SCHOLAR";
        this.hostelName = hostelName;
    }

    // ==========================================
    // POLYMORPHIC METHOD OVERRIDING
    // ==========================================

    @Override
    public String getRoleTitle() {
        return "Student Commuter";
    }

    @Override
    public int getMaxSimultaneousBookings() {
        return 1; // Strict policy: 1 active seat reservation at a time
    }

    @Override
    public String getIdentityBadge() {
        return String.format("ROLL: %s | %s (Yr %d, Sem %d)",
                this.rollNumber, this.department, this.academicYear, this.semester);
    }

    @Override
    public String getSummaryDetails() {
        return String.format("%s | Type: %s %s",
                super.getSummaryDetails(),
                this.studentType,
                "HOSTEL".equalsIgnoreCase(this.studentType) ? "(" + this.hostelName + ")" : "");
    }

    // ==========================================
    // ENCAPSULATION: GETTERS & SETTERS
    // ==========================================

    public String getRollNumber() {
        return rollNumber;
    }

    public void setRollNumber(String rollNumber) {
        if (rollNumber == null || rollNumber.trim().isEmpty()) {
            throw new InvalidDataException("rollNumber", "Student roll number cannot be empty");
        }
        this.rollNumber = rollNumber.trim().toUpperCase();
    }

    public String getDepartment() {
        return department;
    }

    public void setDepartment(String department) {
        this.department = department;
    }

    public int getAcademicYear() {
        return academicYear;
    }

    public void setAcademicYear(int academicYear) {
        if (academicYear < 1 || academicYear > 5) {
            throw new InvalidDataException("academicYear", "Academic year must be between 1 and 5");
        }
        this.academicYear = academicYear;
    }

    public int getSemester() {
        return semester;
    }

    public void setSemester(int semester) {
        if (semester < 1 || semester > 10) {
            throw new InvalidDataException("semester", "Semester must be between 1 and 10");
        }
        this.semester = semester;
    }

    public String getStudentType() {
        return studentType;
    }

    public void setStudentType(String studentType) {
        this.studentType = studentType;
    }

    public String getHostelName() {
        return hostelName;
    }

    public void setHostelName(String hostelName) {
        this.hostelName = hostelName;
    }
}
