package com.collegebus.controller;

import com.collegebus.dto.BusSearchDto;
import com.collegebus.dto.TripCardDto;
import com.collegebus.dto.UserRegistrationDto;
import com.collegebus.entity.*;
import com.collegebus.service.*;
import jakarta.validation.Valid;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.time.LocalDate;
import java.time.ZoneId;
import java.util.List;

@Controller
public class HomeController {

    private final UserService userService;
    private final BusService busService;
    private final RouteService routeService;
    private final BusStopService busStopService;
    private final TripService tripService;
    private final ReportService reportService;

    public HomeController(UserService userService,
                          BusService busService,
                          RouteService routeService,
                          BusStopService busStopService,
                          TripService tripService,
                          ReportService reportService) {
        this.userService = userService;
        this.busService = busService;
        this.routeService = routeService;
        this.busStopService = busStopService;
        this.tripService = tripService;
        this.reportService = reportService;
    }

    @GetMapping("/")
    public String index(Model model) {
        model.addAttribute("currentUser", userService.getAuthenticatedUser());
        model.addAttribute("totalBuses", busService.countTotalBuses());
        model.addAttribute("totalRoutes", routeService.countTotalRoutes());
        model.addAttribute("totalStops", busStopService.countTotalStops());
        model.addAttribute("totalTrips", tripService.countTotalTrips());
        model.addAttribute("routes", routeService.getActiveRoutes());
        model.addAttribute("stops", busStopService.getActiveStops());
        return "index";
    }

    @GetMapping("/login")
    public String loginPage(@RequestParam(value = "error", required = false) String error,
                            @RequestParam(value = "logout", required = false) String logout,
                            Model model) {
        if (userService.getAuthenticatedUser() != null) {
            User user = userService.getAuthenticatedUser();
            if ("ADMIN".equals(user.getRole())) return "redirect:/admin/dashboard";
            if ("TEACHER".equals(user.getRole())) return "redirect:/teacher/dashboard";
            return "redirect:/student/dashboard";
        }
        if (error != null) {
            model.addAttribute("errorMessage", "Invalid email or password. Please verify your credentials.");
        }
        if (logout != null) {
            model.addAttribute("successMessage", "You have been logged out successfully.");
        }
        return "login";
    }

    @GetMapping("/register")
    public String registerPage(Model model) {
        if (userService.getAuthenticatedUser() != null) {
            return "redirect:/";
        }
        if (!model.containsAttribute("userDto")) {
            model.addAttribute("userDto", new UserRegistrationDto());
        }
        return "register";
    }

    @PostMapping("/register")
    public String registerUser(@Valid @ModelAttribute("userDto") UserRegistrationDto userDto,
                               BindingResult result,
                               RedirectAttributes redirectAttributes) {
        if (result.hasErrors()) {
            redirectAttributes.addFlashAttribute("org.springframework.validation.BindingResult.userDto", result);
            redirectAttributes.addFlashAttribute("userDto", userDto);
            return "redirect:/register";
        }

        try {
            userService.registerUser(userDto);
            redirectAttributes.addFlashAttribute("successMessage", "Registration successful! You can now log in with your email.");
            return "redirect:/login";
        } catch (IllegalArgumentException e) {
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
            redirectAttributes.addFlashAttribute("userDto", userDto);
            return "redirect:/register";
        }
    }

    @GetMapping("/calendar")
    public String monthlyCalendar(Model model) {
        model.addAttribute("currentUser", userService.getAuthenticatedUser());
        model.addAttribute("minDate", LocalDate.now(ZoneId.of("Asia/Kolkata")));
        return "calendar";
    }

    @GetMapping("/select-slot")
    public String selectTimeSlot(@RequestParam(value = "date", required = false) String dateStr,
                                 Model model) {
        LocalDate travelDate = (dateStr != null && !dateStr.isEmpty()) ? LocalDate.parse(dateStr) : LocalDate.now();
        if (travelDate.isBefore(LocalDate.now())) {
            model.addAttribute("errorMessage", "Cannot select past travel dates.");
            travelDate = LocalDate.now();
        }
        model.addAttribute("travelDate", travelDate);
        model.addAttribute("currentUser", userService.getAuthenticatedUser());
        return "select-slot";
    }

    @GetMapping("/find-bus")
    public String findBusPage(@ModelAttribute BusSearchDto searchDto,
                              Model model) {
        // Enforce Date & Time Selection before displaying matching buses
        if (searchDto.getTravelDate() == null || searchDto.getPreferredTimeSlot() == null || searchDto.getPreferredTimeSlot().isEmpty()) {
            return "redirect:/calendar";
        }

        if (searchDto.getTravelDate().isBefore(LocalDate.now())) {
            model.addAttribute("errorMessage", "Travel date cannot be in the past.");
            searchDto.setTravelDate(LocalDate.now());
        }

        List<TripCardDto> matchingTrips = tripService.searchTrips(searchDto);

        model.addAttribute("currentUser", userService.getAuthenticatedUser());
        model.addAttribute("searchDto", searchDto);
        model.addAttribute("trips", matchingTrips);
        model.addAttribute("stops", busStopService.getActiveStops());
        return "find-bus";
    }

    @GetMapping("/bus-details/{tripId}")
    public String busDetails(@PathVariable("tripId") Long tripId,
                             @RequestParam(value = "pickup", required = false) Long pickupStopId,
                             @RequestParam(value = "dropoff", required = false) Long dropoffStopId,
                             Model model) {
        Trip trip = tripService.getTripById(tripId);
        if (!"SCHEDULED".equalsIgnoreCase(trip.getTripStatus())
                || !"ACTIVE".equalsIgnoreCase(trip.getBus().getBusStatus())
                || !"ACTIVE".equalsIgnoreCase(trip.getRoute().getRouteStatus())
                || !"ACTIVE".equalsIgnoreCase(trip.getDriver().getDriverStatus())
                || trip.getTravelDate().isBefore(LocalDate.now(ZoneId.of("Asia/Kolkata")))) {
            return "redirect:/calendar";
        }
        TripCardDto card = tripService.getTripCardById(tripId, pickupStopId, dropoffStopId);
        List<RouteStop> routeStops = routeService.getRouteStops(trip.getRoute().getRouteId());
        List<TripCardDto> alternativeTrips = tripService.findAlternativeTrips(tripId);

        model.addAttribute("currentUser", userService.getAuthenticatedUser());
        model.addAttribute("trip", card);
        model.addAttribute("rawTrip", trip);
        model.addAttribute("routeStops", routeStops);
        model.addAttribute("alternatives", alternativeTrips);
        model.addAttribute("stops", busStopService.getActiveStops());
        return "bus-details";
    }

    @GetMapping("/profile")
    public String profilePage(Model model) {
        User user = userService.getAuthenticatedUser();
        if (user == null) return "redirect:/login";

        model.addAttribute("currentUser", user);
        if ("STUDENT".equalsIgnoreCase(user.getRole())) {
            userService.getStudentByUser(user).ifPresent(s -> model.addAttribute("student", s));
        } else if ("TEACHER".equalsIgnoreCase(user.getRole())) {
            userService.getTeacherByUser(user).ifPresent(t -> model.addAttribute("teacher", t));
        }
        return "profile";
    }

    @PostMapping("/profile/update")
    public String updateProfile(@RequestParam("fullName") String fullName,
                                @RequestParam("phoneNumber") String phoneNumber,
                                RedirectAttributes redirectAttributes) {
        User user = userService.getAuthenticatedUser();
        if (user == null) return "redirect:/login";

        userService.updateUserProfile(user.getEmail(), fullName, phoneNumber);
        redirectAttributes.addFlashAttribute("successMessage", "Profile updated successfully!");
        return "redirect:/profile";
    }

    @GetMapping("/access-denied")
    public String accessDenied(Model model) {
        model.addAttribute("currentUser", userService.getAuthenticatedUser());
        return "error";
    }
}
