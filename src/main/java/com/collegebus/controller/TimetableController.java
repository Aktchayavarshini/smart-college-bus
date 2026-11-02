package com.collegebus.controller;

import com.collegebus.dto.ExamRecommendationDto;
import com.collegebus.entity.AcademicTimetable;
import com.collegebus.entity.ExamTimetable;
import com.collegebus.entity.Student;
import com.collegebus.entity.User;
import com.collegebus.service.TimetableService;
import com.collegebus.service.UserService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
public class TimetableController {

    private final TimetableService timetableService;
    private final UserService userService;

    public TimetableController(TimetableService timetableService, UserService userService) {
        this.timetableService = timetableService;
        this.userService = userService;
    }

    @GetMapping("/academic-timetable")
    public String academicTimetable(@RequestParam(value = "department", required = false) String department,
                                    @RequestParam(value = "year", required = false) Integer year,
                                    @RequestParam(value = "semester", required = false) Integer semester,
                                    Model model) {
        User user = userService.getAuthenticatedUser();
        if (department == null && user != null && "STUDENT".equalsIgnoreCase(user.getRole())) {
            Student student = userService.getStudentByUser(user).orElse(null);
            if (student != null) {
                department = student.getDepartment();
                year = student.getAcademicYear();
                semester = student.getSemester();
            }
        }

        List<AcademicTimetable> list = timetableService.getAcademicTimetable(department, year, semester);

        model.addAttribute("currentUser", user);
        model.addAttribute("selectedDept", department);
        model.addAttribute("selectedYear", year);
        model.addAttribute("selectedSem", semester);
        model.addAttribute("timetables", list);
        return "academic-timetable";
    }

    @GetMapping("/exam-timetable")
    public String examTimetable(@RequestParam(value = "department", required = false) String department,
                                @RequestParam(value = "year", required = false) Integer year,
                                @RequestParam(value = "semester", required = false) Integer semester,
                                Model model) {
        User user = userService.getAuthenticatedUser();
        if (department == null && user != null && "STUDENT".equalsIgnoreCase(user.getRole())) {
            Student student = userService.getStudentByUser(user).orElse(null);
            if (student != null) {
                department = student.getDepartment();
                year = student.getAcademicYear();
                semester = student.getSemester();
            }
        }

        List<ExamRecommendationDto> recommendations = timetableService.getExamBusRecommendations(department, year, semester);
        List<ExamTimetable> allExams = timetableService.getExamTimetable(department, year, semester);

        model.addAttribute("currentUser", user);
        model.addAttribute("selectedDept", department);
        model.addAttribute("selectedYear", year);
        model.addAttribute("selectedSem", semester);
        model.addAttribute("recommendations", recommendations);
        model.addAttribute("exams", allExams);
        return "exam-timetable";
    }
}
