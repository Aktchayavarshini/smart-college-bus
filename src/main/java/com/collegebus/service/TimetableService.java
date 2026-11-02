package com.collegebus.service;

import com.collegebus.dto.ExamRecommendationDto;
import com.collegebus.entity.AcademicTimetable;
import com.collegebus.entity.ExamTimetable;

import java.time.LocalDate;
import java.util.List;

public interface TimetableService {

    List<AcademicTimetable> getAcademicTimetable(String department, Integer academicYear, Integer semester);

    List<AcademicTimetable> getAllAcademicTimetables();

    List<ExamTimetable> getExamTimetable(String department, Integer academicYear, Integer semester);

    List<ExamTimetable> getAllExamTimetables();

    List<ExamRecommendationDto> getExamBusRecommendations(String department, Integer academicYear, Integer semester);

    AcademicTimetable saveAcademicTimetable(AcademicTimetable timetable);

    ExamTimetable saveExamTimetable(ExamTimetable exam);
}
