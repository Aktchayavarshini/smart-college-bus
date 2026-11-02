package com.collegebus.repository;

import com.collegebus.entity.Booking;
import com.collegebus.entity.Trip;
import com.collegebus.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@Repository
public interface BookingRepository extends JpaRepository<Booking, Long> {

    List<Booking> findByUserOrderByBookingDateDesc(User user);

    List<Booking> findByUserAndBookingStatusOrderByBookingDateDesc(User user, String bookingStatus);

    List<Booking> findByTrip(Trip trip);

    List<Booking> findByTripAndBookingStatus(Trip trip, String bookingStatus);

    long countByTripAndBookingStatus(Trip trip, String bookingStatus);

    long countByBookingStatus(String bookingStatus);

    @Query("SELECT b FROM Booking b WHERE b.user = :user AND b.trip.travelDate = :travelDate AND b.bookingStatus = 'CONFIRMED'")
    List<Booking> findActiveBookingsForUserOnDate(@Param("user") User user, @Param("travelDate") LocalDate travelDate);

    @Query("SELECT b FROM Booking b WHERE b.user = :user AND b.trip = :trip AND b.bookingStatus = 'CONFIRMED'")
    Optional<Booking> findActiveBookingForUserOnTrip(@Param("user") User user, @Param("trip") Trip trip);

    @Query("SELECT b FROM Booking b ORDER BY b.bookingDate DESC")
    List<Booking> findAllOrderByDateDesc();
}
