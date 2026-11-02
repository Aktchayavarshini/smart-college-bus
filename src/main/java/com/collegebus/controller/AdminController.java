package com.collegebus.controller;

import com.collegebus.dto.DemandReportDto;
import com.collegebus.entity.*;
import com.collegebus.service.*;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/admin")
public class AdminController {

    private final UserService userService;
    private final BusService busService;
    private final RouteService routeService;
    private final BusStopService busStopService;
    private final DriverService driverService;
    private final TripService tripService;
    private final BookingService bookingService;
    private final SeatRequestService seatRequestService;
    private final ReportService reportService;

    public AdminController(UserService userService,
                           BusService busService,
                           RouteService routeService,
                           BusStopService busStopService,
                           DriverService driverService,
                           TripService tripService,
                           BookingService bookingService,
                           SeatRequestService seatRequestService,
                           ReportService reportService) {
        this.userService = userService;
        this.busService = busService;
        this.routeService = routeService;
        this.busStopService = busStopService;
        this.driverService = driverService;
        this.tripService = tripService;
        this.bookingService = bookingService;
        this.seatRequestService = seatRequestService;
        this.reportService = reportService;
    }

    @GetMapping("/dashboard")
    public String dashboard(Model model) {
        Map<String, Object> metrics = reportService.getOverallSystemMetrics();
        List<DemandReportDto> highDemandRoutes = reportService.getRouteDemandReports().stream().limit(3).toList();
        List<SeatRequest> pendingRequests = seatRequestService.getPendingRequests();
        List<Booking> recentBookings = bookingService.getAllBookings().stream().limit(5).toList();

        model.addAttribute("currentUser", userService.getAuthenticatedUser());
        model.addAttribute("metrics", metrics);
        model.addAttribute("highDemandRoutes", highDemandRoutes);
        model.addAttribute("pendingRequests", pendingRequests);
        model.addAttribute("recentBookings", recentBookings);
        return "admin/dashboard";
    }

    // =====================================================================
    // 1. BUS MANAGEMENT
    // =====================================================================
    @GetMapping("/buses")
    public String busesPage(Model model) {
        model.addAttribute("currentUser", userService.getAuthenticatedUser());
        model.addAttribute("buses", busService.getAllBuses());
        model.addAttribute("newBus", new Bus());
        return "admin/buses";
    }

    @PostMapping("/buses/add")
    public String addBus(@ModelAttribute Bus bus, RedirectAttributes redirectAttributes) {
        try {
            busService.saveBus(bus);
            redirectAttributes.addFlashAttribute("successMessage", "Bus " + bus.getBusNumber() + " added successfully!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Failed to add bus: " + e.getMessage());
        }
        return "redirect:/admin/buses";
    }

    @PostMapping("/buses/edit/{id}")
    public String editBus(@PathVariable("id") Long id, @ModelAttribute Bus bus, RedirectAttributes redirectAttributes) {
        try {
            busService.updateBus(id, bus);
            redirectAttributes.addFlashAttribute("successMessage", "Bus updated successfully!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Update failed: " + e.getMessage());
        }
        return "redirect:/admin/buses";
    }

    @PostMapping("/buses/toggle/{id}")
    public String toggleBus(@PathVariable("id") Long id, RedirectAttributes redirectAttributes) {
        busService.toggleBusStatus(id);
        redirectAttributes.addFlashAttribute("successMessage", "Bus status toggled successfully!");
        return "redirect:/admin/buses";
    }

    // =====================================================================
    // 2. ROUTE & STOP MANAGEMENT
    // =====================================================================
    @GetMapping("/routes")
    public String routesPage(Model model) {
        model.addAttribute("currentUser", userService.getAuthenticatedUser());
        model.addAttribute("routes", routeService.getAllRoutes());
        model.addAttribute("allStops", busStopService.getActiveStops());
        model.addAttribute("newRoute", new Route());
        return "admin/routes";
    }

    @PostMapping("/routes/add")
    public String addRoute(@ModelAttribute Route route, RedirectAttributes redirectAttributes) {
        try {
            routeService.saveRoute(route);
            redirectAttributes.addFlashAttribute("successMessage", "Route " + route.getRouteName() + " created successfully!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Route creation failed: " + e.getMessage());
        }
        return "redirect:/admin/routes";
    }

    @PostMapping("/routes/edit/{id}")
    public String editRoute(@PathVariable("id") Long id, @ModelAttribute Route route, RedirectAttributes redirectAttributes) {
        try {
            routeService.updateRoute(id, route);
            redirectAttributes.addFlashAttribute("successMessage", "Route updated successfully!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Route update failed: " + e.getMessage());
        }
        return "redirect:/admin/routes";
    }

    @PostMapping("/routes/toggle/{id}")
    public String toggleRoute(@PathVariable("id") Long id, RedirectAttributes redirectAttributes) {
        routeService.toggleRouteStatus(id);
        redirectAttributes.addFlashAttribute("successMessage", "Route status toggled!");
        return "redirect:/admin/routes";
    }

    @GetMapping("/routes/{id}/stops")
    public String routeStopsPage(@PathVariable("id") Long routeId, Model model) {
        Route route = routeService.getRouteById(routeId);
        List<RouteStop> routeStops = routeService.getRouteStops(routeId);

        model.addAttribute("currentUser", userService.getAuthenticatedUser());
        model.addAttribute("route", route);
        model.addAttribute("routeStops", routeStops);
        model.addAttribute("allStops", busStopService.getActiveStops());
        return "admin/route-stops";
    }

    @PostMapping("/routes/{id}/stops/assign")
    public String assignStopToRoute(@PathVariable("id") Long routeId,
                                    @RequestParam("stopId") Long stopId,
                                    @RequestParam("sequence") Integer sequence,
                                    @RequestParam("estimatedMinutes") Integer estimatedMinutes,
                                    RedirectAttributes redirectAttributes) {
        try {
            routeService.assignStopToRoute(routeId, stopId, sequence, estimatedMinutes);
            redirectAttributes.addFlashAttribute("successMessage", "Stop assigned to route with sequence #" + sequence);
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Failed to assign stop: " + e.getMessage());
        }
        return "redirect:/admin/routes/" + routeId + "/stops";
    }

    @PostMapping("/routes/stops/remove/{routeStopId}")
    public String removeStopFromRoute(@PathVariable("routeStopId") Long routeStopId,
                                      @RequestParam("routeId") Long routeId,
                                      RedirectAttributes redirectAttributes) {
        routeService.removeStopFromRoute(routeStopId);
        redirectAttributes.addFlashAttribute("successMessage", "Stop removed from route sequence.");
        return "redirect:/admin/routes/" + routeId + "/stops";
    }

    // =====================================================================
    // 3. BUS STOP MANAGEMENT
    // =====================================================================
    @GetMapping("/stops")
    public String stopsPage(Model model) {
        model.addAttribute("currentUser", userService.getAuthenticatedUser());
        model.addAttribute("stops", busStopService.getAllStops());
        model.addAttribute("newStop", new BusStop());
        return "admin/stops";
    }

    @PostMapping("/stops/add")
    public String addStop(@ModelAttribute BusStop stop, RedirectAttributes redirectAttributes) {
        try {
            busStopService.saveStop(stop);
            redirectAttributes.addFlashAttribute("successMessage", "Stop " + stop.getStopName() + " added successfully!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Stop addition failed: " + e.getMessage());
        }
        return "redirect:/admin/stops";
    }

    @PostMapping("/stops/edit/{id}")
    public String editStop(@PathVariable("id") Long id, @ModelAttribute BusStop stop, RedirectAttributes redirectAttributes) {
        try {
            busStopService.updateStop(id, stop);
            redirectAttributes.addFlashAttribute("successMessage", "Stop updated successfully!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Stop update failed: " + e.getMessage());
        }
        return "redirect:/admin/stops";
    }

    @PostMapping("/stops/toggle/{id}")
    public String toggleStop(@PathVariable("id") Long id, RedirectAttributes redirectAttributes) {
        busStopService.toggleStopStatus(id);
        redirectAttributes.addFlashAttribute("successMessage", "Stop status toggled!");
        return "redirect:/admin/stops";
    }

    // =====================================================================
    // 4. DRIVER MANAGEMENT
    // =====================================================================
    @GetMapping("/drivers")
    public String driversPage(Model model) {
        model.addAttribute("currentUser", userService.getAuthenticatedUser());
        model.addAttribute("drivers", driverService.getAllDrivers());
        model.addAttribute("newDriver", new Driver());
        return "admin/drivers";
    }

    @PostMapping("/drivers/add")
    public String addDriver(@ModelAttribute Driver driver, RedirectAttributes redirectAttributes) {
        try {
            driverService.saveDriver(driver);
            redirectAttributes.addFlashAttribute("successMessage", "Driver " + driver.getDriverName() + " added successfully!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Driver addition failed: " + e.getMessage());
        }
        return "redirect:/admin/drivers";
    }

    @PostMapping("/drivers/edit/{id}")
    public String editDriver(@PathVariable("id") Long id, @ModelAttribute Driver driver, RedirectAttributes redirectAttributes) {
        try {
            driverService.updateDriver(id, driver);
            redirectAttributes.addFlashAttribute("successMessage", "Driver updated successfully!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Driver update failed: " + e.getMessage());
        }
        return "redirect:/admin/drivers";
    }

    @PostMapping("/drivers/toggle/{id}")
    public String toggleDriver(@PathVariable("id") Long id, RedirectAttributes redirectAttributes) {
        driverService.toggleDriverStatus(id);
        redirectAttributes.addFlashAttribute("successMessage", "Driver status toggled!");
        return "redirect:/admin/drivers";
    }

    // =====================================================================
    // 5. TRIP MANAGEMENT
    // =====================================================================
    @GetMapping("/trips")
    public String tripsPage(Model model) {
        model.addAttribute("currentUser", userService.getAuthenticatedUser());
        model.addAttribute("trips", tripService.getAllTrips());
        model.addAttribute("buses", busService.getActiveBuses());
        model.addAttribute("routes", routeService.getActiveRoutes());
        model.addAttribute("drivers", driverService.getActiveDrivers());
        return "admin/trips";
    }

    @PostMapping("/trips/create")
    public String createTrip(@RequestParam("busId") Long busId,
                             @RequestParam("routeId") Long routeId,
                             @RequestParam("driverId") Long driverId,
                             @RequestParam("travelDate") @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate travelDate,
                             @RequestParam("departureTime") String departureTime,
                             @RequestParam(value = "arrivalTime", required = false) String arrivalTime,
                             @RequestParam("tripType") String tripType,
                             @RequestParam(value = "cutoffTime", required = false) String cutoffTime,
                             RedirectAttributes redirectAttributes) {
        try {
            tripService.createTrip(busId, routeId, driverId, travelDate, departureTime, arrivalTime, tripType, cutoffTime);
            redirectAttributes.addFlashAttribute("successMessage", "Trip scheduled successfully for " + travelDate + " at " + departureTime);
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Trip creation failed: " + e.getMessage());
        }
        return "redirect:/admin/trips";
    }

    @PostMapping("/trips/cancel/{id}")
    public String cancelTrip(@PathVariable("id") Long id, RedirectAttributes redirectAttributes) {
        tripService.cancelTrip(id);
        redirectAttributes.addFlashAttribute("successMessage", "Trip #" + id + " has been cancelled.");
        return "redirect:/admin/trips";
    }

    // =====================================================================
    // 6. BOOKING MANAGEMENT
    // =====================================================================
    @GetMapping("/bookings")
    public String bookingsPage(Model model) {
        model.addAttribute("currentUser", userService.getAuthenticatedUser());
        model.addAttribute("bookings", bookingService.getAllBookings());
        return "admin/bookings";
    }

    // =====================================================================
    // 7. SEAT REQUEST MANAGEMENT
    // =====================================================================
    @GetMapping("/seat-requests")
    public String seatRequestsPage(Model model) {
        model.addAttribute("currentUser", userService.getAuthenticatedUser());
        model.addAttribute("requests", seatRequestService.getAllRequests());
        model.addAttribute("pendingCount", seatRequestService.countPendingRequests());
        return "admin/seat-requests";
    }

    @PostMapping("/seat-requests/approve/{id}")
    public String approveSeatRequest(@PathVariable("id") Long id, RedirectAttributes redirectAttributes) {
        User admin = userService.getAuthenticatedUser();
        try {
            seatRequestService.approveRequest(id, admin);
            redirectAttributes.addFlashAttribute("successMessage", "Seat request #" + id + " APPROVED! Seat reserved safely.");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Approval failed: " + e.getMessage());
        }
        return "redirect:/admin/seat-requests";
    }

    @PostMapping("/seat-requests/reject/{id}")
    public String rejectSeatRequest(@PathVariable("id") Long id, RedirectAttributes redirectAttributes) {
        User admin = userService.getAuthenticatedUser();
        try {
            seatRequestService.rejectRequest(id, admin);
            redirectAttributes.addFlashAttribute("successMessage", "Seat request #" + id + " REJECTED.");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Rejection failed: " + e.getMessage());
        }
        return "redirect:/admin/seat-requests";
    }

    // =====================================================================
    // 8. PASSENGER-DEMAND REPORTS
    // =====================================================================
    @GetMapping("/reports")
    public String reportsPage(Model model) {
        List<DemandReportDto> reports = reportService.getRouteDemandReports();
        Map<String, Object> metrics = reportService.getOverallSystemMetrics();
        List<Map<String, Object>> fullTrips = reportService.getFrequentlyFullTrips();

        model.addAttribute("currentUser", userService.getAuthenticatedUser());
        model.addAttribute("reports", reports);
        model.addAttribute("metrics", metrics);
        model.addAttribute("fullTrips", fullTrips);
        return "admin/reports";
    }
}
