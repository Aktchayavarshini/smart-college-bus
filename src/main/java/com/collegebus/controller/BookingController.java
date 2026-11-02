package com.collegebus.controller;

import com.collegebus.dto.BookingRequestDto;
import com.collegebus.dto.SeatRequestDto;
import com.collegebus.dto.TripCardDto;
import com.collegebus.entity.*;
import com.collegebus.exception.BookingException;
import com.collegebus.service.*;
import jakarta.validation.Valid;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
public class BookingController {

    private final BookingService bookingService;
    private final TripService tripService;
    private final BusStopService busStopService;
    private final UserService userService;
    private final SeatRequestService seatRequestService;

    public BookingController(BookingService bookingService,
                             TripService tripService,
                             BusStopService busStopService,
                             UserService userService,
                             SeatRequestService seatRequestService) {
        this.bookingService = bookingService;
        this.tripService = tripService;
        this.busStopService = busStopService;
        this.userService = userService;
        this.seatRequestService = seatRequestService;
    }

    @GetMapping("/booking/confirm")
    public String bookingConfirmPage(@RequestParam("tripId") Long tripId,
                                     @RequestParam("pickupStopId") Long pickupStopId,
                                     @RequestParam("dropoffStopId") Long dropoffStopId,
                                     Model model) {
        User user = userService.getAuthenticatedUser();
        TripCardDto card = tripService.getTripCardById(tripId, pickupStopId, dropoffStopId);
        BusStop pickup = busStopService.getStopById(pickupStopId);
        BusStop dropoff = busStopService.getStopById(dropoffStopId);

        model.addAttribute("currentUser", user);
        model.addAttribute("trip", card);
        model.addAttribute("pickup", pickup);
        model.addAttribute("dropoff", dropoff);
        model.addAttribute("bookingRequest", new BookingRequestDto(tripId, pickupStopId, dropoffStopId));
        return "booking-confirm";
    }

    @PostMapping("/booking/create")
    public String createBooking(@Valid @ModelAttribute("bookingRequest") BookingRequestDto dto,
                                RedirectAttributes redirectAttributes) {
        User user = userService.getAuthenticatedUser();
        try {
            Booking booking = bookingService.bookSeat(user, dto);
            redirectAttributes.addFlashAttribute("successMessage",
                    "Seat successfully booked on Bus " + booking.getTrip().getBus().getBusNumber() + "! Your Booking ID is #" + booking.getBookingId());
            return "redirect:/my-bookings";
        } catch (BookingException e) {
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
            return "redirect:/find-bus";
        }
    }

    @PostMapping("/booking/cancel/{id}")
    public String cancelBooking(@PathVariable("id") Long bookingId,
                                RedirectAttributes redirectAttributes) {
        User user = userService.getAuthenticatedUser();
        try {
            bookingService.cancelBooking(bookingId, user);
            redirectAttributes.addFlashAttribute("successMessage", "Booking #" + bookingId + " has been cancelled. Your seat is released.");
        } catch (BookingException e) {
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
        }
        return "redirect:/my-bookings";
    }

    @GetMapping("/booking/modify/{id}")
    public String modifyBookingPage(@PathVariable("id") Long bookingId, Model model) {
        User user = userService.getAuthenticatedUser();
        Booking booking = bookingService.getBookingById(bookingId);

        model.addAttribute("currentUser", user);
        model.addAttribute("currentBooking", booking);
        model.addAttribute("stops", busStopService.getActiveStops());
        return "booking-modify";
    }

    @PostMapping("/booking/modify/{id}")
    public String modifyBooking(@PathVariable("id") Long currentBookingId,
                                @ModelAttribute BookingRequestDto newDto,
                                RedirectAttributes redirectAttributes) {
        User user = userService.getAuthenticatedUser();
        try {
            Booking newBooking = bookingService.modifyBooking(currentBookingId, newDto, user);
            redirectAttributes.addFlashAttribute("successMessage",
                    "Booking successfully updated! New Booking ID is #" + newBooking.getBookingId() + " on Bus " + newBooking.getTrip().getBus().getBusNumber());
            return "redirect:/my-bookings";
        } catch (BookingException e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Modification failed: " + e.getMessage() + ". Your previous booking remains intact.");
            return "redirect:/my-bookings";
        }
    }

    @GetMapping("/my-bookings")
    public String myBookings(Model model) {
        User user = userService.getAuthenticatedUser();
        List<Booking> active = bookingService.getActiveBookingsForUser(user);
        List<SeatRequest> requests = seatRequestService.getRequestsByUser(user);

        model.addAttribute("currentUser", user);
        model.addAttribute("bookings", active);
        model.addAttribute("seatRequests", requests);
        return "my-bookings";
    }

    @GetMapping("/booking-history")
    public String bookingHistory(Model model) {
        User user = userService.getAuthenticatedUser();
        List<Booking> history = bookingService.getBookingHistoryForUser(user);

        model.addAttribute("currentUser", user);
        model.addAttribute("bookings", history);
        return "booking-history";
    }

    @PostMapping("/seat-request/new")
    public String createSeatRequest(@Valid @ModelAttribute SeatRequestDto dto,
                                    RedirectAttributes redirectAttributes) {
        User user = userService.getAuthenticatedUser();
        try {
            SeatRequest req = seatRequestService.createRequest(user, dto);
            redirectAttributes.addFlashAttribute("successMessage",
                    "Seat request #" + req.getRequestId() + " submitted! The transport administrator will review your request if seats become available.");
            return "redirect:/my-bookings";
        } catch (BookingException e) {
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
            return "redirect:/find-bus";
        }
    }
}
