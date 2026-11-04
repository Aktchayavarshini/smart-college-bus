package com.collegebus.service.impl;

import com.collegebus.dto.BookingRequestDto;
import com.collegebus.entity.*;
import com.collegebus.exception.BookingException;
import com.collegebus.exception.ResourceNotFoundException;
import com.collegebus.repository.*;
import com.collegebus.service.BookingService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.List;
import java.time.ZoneId;

@Service
@Transactional
public class BookingServiceImpl implements BookingService {

    private final BookingRepository bookingRepository;
    private final TripRepository tripRepository;
    private final BusStopRepository busStopRepository;
    private final RouteStopRepository routeStopRepository;

    public BookingServiceImpl(BookingRepository bookingRepository,
                              TripRepository tripRepository,
                              BusStopRepository busStopRepository,
                              RouteStopRepository routeStopRepository) {
        this.bookingRepository = bookingRepository;
        this.tripRepository = tripRepository;
        this.busStopRepository = busStopRepository;
        this.routeStopRepository = routeStopRepository;
    }

    @Override
    @Transactional(isolation = Isolation.SERIALIZABLE)
    public Booking bookSeat(User user, BookingRequestDto dto) {
        Trip trip = tripRepository.findByIdForUpdate(dto.getTripId())
                .orElseThrow(() -> new ResourceNotFoundException("Trip not found with ID: " + dto.getTripId()));

        if (!"SCHEDULED".equalsIgnoreCase(trip.getTripStatus())) {
            throw new BookingException("This trip is not available for booking (Status: " + trip.getTripStatus() + ")");
        }
        if (!"ACTIVE".equalsIgnoreCase(trip.getBus().getBusStatus())
                || !"ACTIVE".equalsIgnoreCase(trip.getRoute().getRouteStatus())
                || !"ACTIVE".equalsIgnoreCase(trip.getDriver().getDriverStatus())) {
            throw new BookingException("This trip is unavailable because its bus, route, or driver is not active.");
        }

        // Campus operations use India Standard Time regardless of the hosting server's timezone.
        ZoneId campusZone = ZoneId.of("Asia/Kolkata");
        LocalDate today = LocalDate.now(campusZone);
        LocalTime nowTime = LocalTime.now(campusZone);
        if (trip.getTravelDate().isBefore(today)) {
            throw new BookingException("Cannot book seats for past dates (" + trip.getTravelDate() + ").");
        }
        if (trip.getTravelDate().isEqual(today) && nowTime.isAfter(trip.getBookingCutoffTime())) {
            throw new BookingException("Booking cutoff time (" + trip.getBookingCutoffTime() + ") has passed for this trip.");
        }

        // Check duplicate booking for the user on the same trip
        bookingRepository.findActiveBookingForUserOnTrip(user, trip).ifPresent(existing -> {
            throw new BookingException("You already have an active confirmed booking (#" + existing.getBookingId() + ") for this trip.");
        });

        // Validate pickup and dropoff stops
        BusStop pickup = busStopRepository.findById(dto.getPickupStopId())
                .orElseThrow(() -> new ResourceNotFoundException("Pickup stop not found: " + dto.getPickupStopId()));
        BusStop dropoff = busStopRepository.findById(dto.getDropoffStopId())
                .orElseThrow(() -> new ResourceNotFoundException("Dropoff stop not found: " + dto.getDropoffStopId()));

        RouteStop pStop = routeStopRepository.findByRouteAndStop(trip.getRoute(), pickup)
                .orElseThrow(() -> new BookingException("Selected pickup stop '" + pickup.getStopName() + "' is not on this bus route."));
        RouteStop dStop = routeStopRepository.findByRouteAndStop(trip.getRoute(), dropoff)
                .orElseThrow(() -> new BookingException("Selected dropoff stop '" + dropoff.getStopName() + "' is not on this bus route."));

        if (pStop.getStopSequence() >= dStop.getStopSequence()) {
            throw new BookingException("Invalid stop selection: Pickup stop must precede Dropoff stop in the route direction.");
        }
        if (!"ACTIVE".equalsIgnoreCase(pickup.getStopStatus())
                || !"ACTIVE".equalsIgnoreCase(dropoff.getStopStatus())) {
            throw new BookingException("Selected pickup and drop-off stops must both be active.");
        }

        // Safe capacity check from confirmed bookings
        long confirmedCount = bookingRepository.countByTripAndBookingStatus(trip, "CONFIRMED");
        if (confirmedCount >= trip.getBus().getTotalSeats()) {
            throw new BookingException("Bus is full (" + confirmedCount + "/" + trip.getBus().getTotalSeats() + " seats booked). Please submit a Seat Request or choose an alternative trip.");
        }

        // Create booking
        Booking booking = new Booking();
        booking.setUser(user);
        booking.setTrip(trip);
        booking.setPickupStop(pickup);
        booking.setDropoffStop(dropoff);
        booking.setRequestedPickupText(dto.getRequestedPickupText() != null ? dto.getRequestedPickupText() : pickup.getStopName());
        booking.setRequestedDestinationText(dto.getRequestedDestinationText() != null ? dto.getRequestedDestinationText() : dropoff.getStopName());
        booking.setBookingStatus("CONFIRMED");
        booking.setBookingDate(LocalDateTime.now());
        booking.setUpdatedAt(LocalDateTime.now());

        return bookingRepository.save(booking);
    }

    @Override
    public Booking cancelBooking(Long bookingId, User currentUser) {
        Booking booking = getBookingById(bookingId);

        // Security check: Only owner or admin can cancel
        if (!booking.getUser().getUserId().equals(currentUser.getUserId()) && !"ADMIN".equalsIgnoreCase(currentUser.getRole())) {
            throw new BookingException("You are not authorized to cancel this booking.");
        }

        if ("CANCELLED".equalsIgnoreCase(booking.getBookingStatus())) {
            throw new BookingException("This booking is already cancelled.");
        }

        booking.setBookingStatus("CANCELLED");
        booking.setUpdatedAt(LocalDateTime.now());
        return bookingRepository.save(booking);
    }

    @Override
    @Transactional(isolation = Isolation.SERIALIZABLE)
    public Booking modifyBooking(Long currentBookingId, BookingRequestDto newBookingDto, User currentUser) {
        Booking currentBooking = getBookingById(currentBookingId);

        if (!currentBooking.getUser().getUserId().equals(currentUser.getUserId()) && !"ADMIN".equalsIgnoreCase(currentUser.getRole())) {
            throw new BookingException("You are not authorized to modify this booking.");
        }

        // Attempt new booking first without cancelling old booking
        Booking newBooking = bookSeat(currentUser, newBookingDto);

        // If new booking succeeded, safely mark the old booking as MODIFIED
        currentBooking.setBookingStatus("CANCELLED");
        currentBooking.setUpdatedAt(LocalDateTime.now());
        bookingRepository.save(currentBooking);

        return newBooking;
    }

    @Override
    @Transactional(readOnly = true)
    public List<Booking> getActiveBookingsForUser(User user) {
        return bookingRepository.findByUserAndBookingStatusOrderByBookingDateDesc(user, "CONFIRMED");
    }

    @Override
    @Transactional(readOnly = true)
    public List<Booking> getBookingHistoryForUser(User user) {
        return bookingRepository.findByUserOrderByBookingDateDesc(user);
    }

    @Override
    @Transactional(readOnly = true)
    public Booking getBookingById(Long id) {
        return bookingRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Booking not found with ID: " + id));
    }

    @Override
    @Transactional(readOnly = true)
    public List<Booking> getAllBookings() {
        return bookingRepository.findAllOrderByDateDesc();
    }

    @Override
    @Transactional(readOnly = true)
    public long countTotalBookings() {
        return bookingRepository.count();
    }

    @Override
    @Transactional(readOnly = true)
    public long countConfirmedBookings() {
        return bookingRepository.countByBookingStatus("CONFIRMED");
    }

    @Override
    @Transactional(readOnly = true)
    public long countCancelledBookings() {
        return bookingRepository.countByBookingStatus("CANCELLED");
    }
}
