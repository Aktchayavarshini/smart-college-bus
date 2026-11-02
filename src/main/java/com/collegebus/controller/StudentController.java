package com.collegebus.controller;

import com.collegebus.entity.Booking;
import com.collegebus.entity.SeatRequest;
import com.collegebus.entity.Student;
import com.collegebus.entity.User;
import com.collegebus.service.BookingService;
import com.collegebus.service.SeatRequestService;
import com.collegebus.service.TimetableService;
import com.collegebus.service.UserService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequestMapping("/student")
public class StudentController {

    private final UserService userService;
    private final BookingService bookingService;
    private final SeatRequestService seatRequestService;
    private final TimetableService timetableService;

    public StudentController(UserService userService,
                             BookingService bookingService,
                             SeatRequestService seatRequestService,
                             TimetableService timetableService) {
        this.userService = userService;
        this.bookingService = bookingService;
        this.seatRequestService = seatRequestService;
        this.timetableService = timetableService;
    }

    @GetMapping("/dashboard")
    public String dashboard(Model model) {
        User user = userService.getAuthenticatedUser();
        Student student = userService.getStudentByUser(user).orElse(null);
        List<Booking> activeBookings = bookingService.getActiveBookingsForUser(user);
        List<Booking> allBookings = bookingService.getBookingHistoryForUser(user);
        List<SeatRequest> requests = seatRequestService.getRequestsByUser(user);

        model.addAttribute("currentUser", user);
        model.addAttribute("student", student);
        model.addAttribute("activeBookings", activeBookings);
        model.addAttribute("bookingHistory", allBookings);
        model.addAttribute("seatRequests", requests);
        model.addAttribute("totalBookingsCount", allBookings.size());
        model.addAttribute("activeBookingsCount", activeBookings.size());

        if (student != null) {
            model.addAttribute("examRecommendations",
                    timetableService.getExamBusRecommendations(student.getDepartment(), student.getAcademicYear(), student.getSemester()));
        }

        return "student-dashboard";
    }
}
