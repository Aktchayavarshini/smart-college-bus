package com.collegebus.entity;

import jakarta.persistence.*;
import java.time.LocalTime;

@Entity
@Table(name = "academic_timetable")
public class AcademicTimetable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "timetable_id")
    private Long timetableId;

    @Column(name = "department", nullable = false, length = 100)
    private String department;

    @Column(name = "academic_year", nullable = false)
    private Integer academicYear;

    @Column(name = "semester", nullable = false)
    private Integer semester;

    @Column(name = "day_of_week", nullable = false, length = 20)
    private String dayOfWeek; // MONDAY, TUESDAY, etc.

    @Column(name = "start_time", nullable = false)
    private LocalTime startTime;

    @Column(name = "end_time", nullable = false)
    private LocalTime endTime;

    @Column(name = "subject_name", nullable = false, length = 150)
    private String subjectName;

    @Column(name = "timetable_status", nullable = false, length = 30)
    private String timetableStatus = "ACTIVE";

    public AcademicTimetable() {
    }

    public AcademicTimetable(String department, Integer academicYear, Integer semester, String dayOfWeek, LocalTime startTime, LocalTime endTime, String subjectName, String timetableStatus) {
        this.department = department;
        this.academicYear = academicYear;
        this.semester = semester;
        this.dayOfWeek = dayOfWeek;
        this.startTime = startTime;
        this.endTime = endTime;
        this.subjectName = subjectName;
        this.timetableStatus = timetableStatus;
    }

    public Long getTimetableId() {
        return timetableId;
    }

    public void setTimetableId(Long timetableId) {
        this.timetableId = timetableId;
    }

    public String getDepartment() {
        return department;
    }

    public void setDepartment(String department) {
        this.department = department;
    }

    public Integer getAcademicYear() {
        return academicYear;
    }

    public void setAcademicYear(Integer academicYear) {
        this.academicYear = academicYear;
    }

    public Integer getSemester() {
        return semester;
    }

    public void setSemester(Integer semester) {
        this.semester = semester;
    }

    public String getDayOfWeek() {
        return dayOfWeek;
    }

    public void setDayOfWeek(String dayOfWeek) {
        this.dayOfWeek = dayOfWeek;
    }

    public LocalTime getStartTime() {
        return startTime;
    }

    public void setStartTime(LocalTime startTime) {
        this.startTime = startTime;
    }

    public LocalTime getEndTime() {
        return endTime;
    }

    public void setEndTime(LocalTime endTime) {
        this.endTime = endTime;
    }

    public String getSubjectName() {
        return subjectName;
    }

    public void setSubjectName(String subjectName) {
        this.subjectName = subjectName;
    }

    public String getTimetableStatus() {
        return timetableStatus;
    }

    public void setTimetableStatus(String timetableStatus) {
        this.timetableStatus = timetableStatus;
    }
}
