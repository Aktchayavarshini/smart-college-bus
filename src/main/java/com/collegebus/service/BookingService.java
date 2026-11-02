package com.collegebus.service;

import com.collegebus.dto.BookingRequestDto;
import com.collegebus.entity.Booking;
import com.collegebus.entity.User;

import java.util.List;

public interface BookingService {

    Booking bookSeat(User user, BookingRequestDto requestDto);

    Booking cancelBooking(Long bookingId, User currentUser);

    Booking modifyBooking(Long currentBookingId, BookingRequestDto newBookingDto, User currentUser);

    List<Booking> getActiveBookingsForUser(User user);

    List<Booking> getBookingHistoryForUser(User user);

    Booking getBookingById(Long id);

    List<Booking> getAllBookings();

    long countTotalBookings();

    long countConfirmedBookings();

    long countCancelledBookings();
}
