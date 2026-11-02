package com.collegebus.entity;

import jakarta.persistence.*;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.LocalDateTime;

@Entity
@Table(name = "exam_timetable")
public class ExamTimetable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "exam_id")
    private Long examId;

    @Column(name = "department", nullable = false, length = 100)
    private String department;

    @Column(name = "academic_year", nullable = false)
    private Integer academicYear;

    @Column(name = "semester", nullable = false)
    private Integer semester;

    @Column(name = "subject_name", nullable = false, length = 150)
    private String subjectName;

    @Column(name = "exam_date", nullable = false)
    private LocalDate examDate;

    @Column(name = "exam_start_time", nullable = false)
    private LocalTime examStartTime;

    @Column(name = "exam_end_time", nullable = false)
    private LocalTime examEndTime;

    @Column(name = "exam_type", nullable = false, length = 50)
    private String examType = "SEMESTER_FINAL";

    @Column(name = "created_at", nullable = false, updatable = false)
    private LocalDateTime createdAt = LocalDateTime.now();

    public ExamTimetable() {
    }

    public ExamTimetable(String department, Integer academicYear, Integer semester, String subjectName, LocalDate examDate, LocalTime examStartTime, LocalTime examEndTime, String examType) {
        this.department = department;
        this.academicYear = academicYear;
        this.semester = semester;
        this.subjectName = subjectName;
        this.examDate = examDate;
        this.examStartTime = examStartTime;
        this.examEndTime = examEndTime;
        this.examType = examType;
        this.createdAt = LocalDateTime.now();
    }

    @PrePersist
    protected void onCreate() {
        if (createdAt == null) createdAt = LocalDateTime.now();
    }

    public Long getExamId() {
        return examId;
    }

    public void setExamId(Long examId) {
        this.examId = examId;
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

    public String getSubjectName() {
        return subjectName;
    }

    public void setSubjectName(String subjectName) {
        this.subjectName = subjectName;
    }

    public LocalDate getExamDate() {
        return examDate;
    }

    public void setExamDate(LocalDate examDate) {
        this.examDate = examDate;
    }

    public LocalTime getExamStartTime() {
        return examStartTime;
    }

    public void setExamStartTime(LocalTime examStartTime) {
        this.examStartTime = examStartTime;
    }

    public LocalTime getExamEndTime() {
        return examEndTime;
    }

    public void setExamEndTime(LocalTime examEndTime) {
        this.examEndTime = examEndTime;
    }

    public String getExamType() {
        return examType;
    }

    public void setExamType(String examType) {
        this.examType = examType;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }
}
