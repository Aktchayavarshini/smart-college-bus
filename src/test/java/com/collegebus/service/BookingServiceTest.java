package com.collegebus.service;

import com.collegebus.dto.BookingRequestDto;
import com.collegebus.entity.*;
import com.collegebus.exception.BookingException;
import com.collegebus.repository.*;
import com.collegebus.service.impl.BookingServiceImpl;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class BookingServiceTest {

    @Mock
    private BookingRepository bookingRepository;

    @Mock
    private TripRepository tripRepository;

    @Mock
    private BusStopRepository busStopRepository;

    @Mock
    private RouteStopRepository routeStopRepository;

    @InjectMocks
    private BookingServiceImpl bookingService;

    private User studentUser;
    private Bus bus;
    private Route route;
    private Driver driver;
    private Trip trip;
    private BusStop stop1;
    private BusStop stop2;
    private RouteStop routeStop1;
    private RouteStop routeStop2;

    @BeforeEach
    void setUp() {
        studentUser = new User("Mukesh K", "student@collegebus.edu", "pass123", "9840123456", "STUDENT");
        studentUser.setUserId(1L);

        bus = new Bus("BUS-101", "TN-09-CB-1001", 50, "NON_AC", "ACTIVE");
        bus.setBusId(1L);

        route = new Route("Route 101", "Pallavaram", "College Campus", "Via Tambaram", "ACTIVE");
        route.setRouteId(1L);

        driver = new Driver("R. Murugan", "9840112233", "LIC123", "ACTIVE");
        driver.setDriverId(1L);

        trip = new Trip(bus, route, driver, LocalDate.now().plusDays(1), LocalTime.of(7, 0), LocalTime.of(7, 55), "REGULAR", "SCHEDULED", LocalTime.of(6, 30));
        trip.setTripId(10L);

        stop1 = new BusStop("Pallavaram Bus Stand", "GST Road", "Pallavaram", "ACTIVE");
        stop1.setStopId(101L);

        stop2 = new BusStop("College Main Campus", "Main Gate", "Campus", "ACTIVE");
        stop2.setStopId(102L);

        routeStop1 = new RouteStop(route, stop1, 1, 0);
        routeStop2 = new RouteStop(route, stop2, 2, 50);
    }

    @Test
    void testBookSeat_Success() {
        BookingRequestDto dto = new BookingRequestDto(10L, 101L, 102L);

        when(tripRepository.findByIdForUpdate(10L)).thenReturn(Optional.of(trip));
        when(bookingRepository.findActiveBookingForUserOnTrip(studentUser, trip)).thenReturn(Optional.empty());
        when(busStopRepository.findById(101L)).thenReturn(Optional.of(stop1));
        when(busStopRepository.findById(102L)).thenReturn(Optional.of(stop2));
        when(routeStopRepository.findByRouteAndStop(route, stop1)).thenReturn(Optional.of(routeStop1));
        when(routeStopRepository.findByRouteAndStop(route, stop2)).thenReturn(Optional.of(routeStop2));
        when(bookingRepository.countByTripAndBookingStatus(trip, "CONFIRMED")).thenReturn(10L);

        Booking savedBooking = new Booking(studentUser, trip, stop1, stop2, "Pallavaram", "Campus", "CONFIRMED");
        savedBooking.setBookingId(501L);
        when(bookingRepository.save(any(Booking.class))).thenReturn(savedBooking);

        Booking result = bookingService.bookSeat(studentUser, dto);

        assertNotNull(result);
        assertEquals(501L, result.getBookingId());
        assertEquals("CONFIRMED", result.getBookingStatus());
        verify(bookingRepository, times(1)).save(any(Booking.class));
    }

    @Test
    void testBookSeat_FullBus_ThrowsException() {
        BookingRequestDto dto = new BookingRequestDto(10L, 101L, 102L);

        when(tripRepository.findByIdForUpdate(10L)).thenReturn(Optional.of(trip));
        when(bookingRepository.findActiveBookingForUserOnTrip(studentUser, trip)).thenReturn(Optional.empty());
        when(busStopRepository.findById(101L)).thenReturn(Optional.of(stop1));
        when(busStopRepository.findById(102L)).thenReturn(Optional.of(stop2));
        when(routeStopRepository.findByRouteAndStop(route, stop1)).thenReturn(Optional.of(routeStop1));
        when(routeStopRepository.findByRouteAndStop(route, stop2)).thenReturn(Optional.of(routeStop2));
        // Capacity is 50, booked is 50
        when(bookingRepository.countByTripAndBookingStatus(trip, "CONFIRMED")).thenReturn(50L);

        assertThrows(BookingException.class, () -> bookingService.bookSeat(studentUser, dto));
        verify(bookingRepository, never()).save(any(Booking.class));
    }

    @Test
    void testBookSeat_DuplicateBooking_ThrowsException() {
        BookingRequestDto dto = new BookingRequestDto(10L, 101L, 102L);

        when(tripRepository.findByIdForUpdate(10L)).thenReturn(Optional.of(trip));
        Booking existingBooking = new Booking(studentUser, trip, stop1, stop2, "Pallavaram", "Campus", "CONFIRMED");
        existingBooking.setBookingId(200L);
        when(bookingRepository.findActiveBookingForUserOnTrip(studentUser, trip)).thenReturn(Optional.of(existingBooking));

        assertThrows(BookingException.class, () -> bookingService.bookSeat(studentUser, dto));
        verify(bookingRepository, never()).save(any(Booking.class));
    }

    @Test
    void testCancelBooking_Success() {
        Booking booking = new Booking(studentUser, trip, stop1, stop2, "Pallavaram", "Campus", "CONFIRMED");
        booking.setBookingId(300L);

        when(bookingRepository.findById(300L)).thenReturn(Optional.of(booking));
        when(tripRepository.findByIdForUpdate(10L)).thenReturn(Optional.of(trip));
        when(bookingRepository.save(any(Booking.class))).thenAnswer(invocation -> invocation.getArgument(0));

        Booking cancelled = bookingService.cancelBooking(300L, studentUser);

        assertEquals("CANCELLED", cancelled.getBookingStatus());
        verify(bookingRepository, times(1)).save(booking);
    }
}

