package com.collegebus.dto;

import java.time.LocalDate;
import java.time.LocalTime;

public class ExamRecommendationDto {

    private Long examId;
    private String subjectName;
    private String department;
    private Integer semester;
    private LocalDate examDate;
    private LocalTime examStartTime;
    private LocalTime examEndTime;
    private String examType;
    private TripCardDto recommendedTrip;
    private boolean hasRecommendation;

    public ExamRecommendationDto() {
    }

    public Long getExamId() {
        return examId;
    }

    public void setExamId(Long examId) {
        this.examId = examId;
    }

    public String getSubjectName() {
        return subjectName;
    }

    public void setSubjectName(String subjectName) {
        this.subjectName = subjectName;
    }

    public String getDepartment() {
        return department;
    }

    public void setDepartment(String department) {
        this.department = department;
    }

    public Integer getSemester() {
        return semester;
    }

    public void setSemester(Integer semester) {
        this.semester = semester;
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

    public TripCardDto getRecommendedTrip() {
        return recommendedTrip;
    }

    public void setRecommendedTrip(TripCardDto recommendedTrip) {
        this.recommendedTrip = recommendedTrip;
        this.hasRecommendation = (recommendedTrip != null);
    }

    public boolean isHasRecommendation() {
        return hasRecommendation;
    }

    public void setHasRecommendation(boolean hasRecommendation) {
        this.hasRecommendation = hasRecommendation;
    }
}
