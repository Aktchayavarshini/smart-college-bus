package com.collegebus.repository;

import com.collegebus.entity.AcademicTimetable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface AcademicTimetableRepository extends JpaRepository<AcademicTimetable, Long> {

    List<AcademicTimetable> findByDepartmentAndAcademicYearAndSemesterOrderByDayOfWeekAscStartTimeAsc(
            String department, Integer academicYear, Integer semester);

    List<AcademicTimetable> findByDepartmentAndSemesterAndDayOfWeek(
            String department, Integer semester, String dayOfWeek);

    List<AcademicTimetable> findByTimetableStatus(String timetableStatus);
}
