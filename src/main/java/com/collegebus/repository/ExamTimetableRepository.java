package com.collegebus.repository;

import com.collegebus.entity.ExamTimetable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.List;

@Repository
public interface ExamTimetableRepository extends JpaRepository<ExamTimetable, Long> {

    List<ExamTimetable> findByDepartmentAndAcademicYearAndSemesterOrderByExamDateAscExamStartTimeAsc(
            String department, Integer academicYear, Integer semester);

    List<ExamTimetable> findByExamDateOrderByExamStartTimeAsc(LocalDate examDate);

    List<ExamTimetable> findByExamDateGreaterThanEqualOrderByExamDateAscExamStartTimeAsc(LocalDate fromDate);
}
