package com.collegebus.controller;

import com.collegebus.entity.Booking;
import com.collegebus.entity.SeatRequest;
import com.collegebus.entity.Teacher;
import com.collegebus.entity.User;
import com.collegebus.service.BookingService;
import com.collegebus.service.SeatRequestService;
import com.collegebus.service.UserService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequestMapping("/teacher")
public class TeacherController {

    private final UserService userService;
    private final BookingService bookingService;
    private final SeatRequestService seatRequestService;

    public TeacherController(UserService userService,
                             BookingService bookingService,
                             SeatRequestService seatRequestService) {
        this.userService = userService;
        this.bookingService = bookingService;
        this.seatRequestService = seatRequestService;
    }

    @GetMapping("/dashboard")
    public String dashboard(Model model) {
        User user = userService.getAuthenticatedUser();
        Teacher teacher = userService.getTeacherByUser(user).orElse(null);
        List<Booking> activeBookings = bookingService.getActiveBookingsForUser(user);
        List<Booking> allBookings = bookingService.getBookingHistoryForUser(user);
        List<SeatRequest> requests = seatRequestService.getRequestsByUser(user);

        model.addAttribute("currentUser", user);
        model.addAttribute("teacher", teacher);
        model.addAttribute("activeBookings", activeBookings);
        model.addAttribute("bookingHistory", allBookings);
        model.addAttribute("seatRequests", requests);
        model.addAttribute("totalBookingsCount", allBookings.size());
        model.addAttribute("activeBookingsCount", activeBookings.size());

        return "teacher-dashboard";
    }
}
