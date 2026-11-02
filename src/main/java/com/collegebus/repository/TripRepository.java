package com.collegebus.repository;

import com.collegebus.entity.Route;
import com.collegebus.entity.Trip;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;

@Repository
public interface TripRepository extends JpaRepository<Trip, Long> {

    List<Trip> findByTravelDate(LocalDate travelDate);

    List<Trip> findByTravelDateAndTripStatus(LocalDate travelDate, String tripStatus);

    List<Trip> findByRouteAndTravelDate(Route route, LocalDate travelDate);

    @Query("SELECT t FROM Trip t WHERE t.travelDate = :travelDate AND t.departureTime >= :startTime AND t.departureTime <= :endTime AND t.tripStatus = 'SCHEDULED' ORDER BY t.departureTime ASC")
    List<Trip> findTripsByTimeSlot(
            @Param("travelDate") LocalDate travelDate,
            @Param("startTime") LocalTime startTime,
            @Param("endTime") LocalTime endTime);

    @Query("SELECT t FROM Trip t WHERE t.travelDate = :travelDate AND t.departureTime >= :afterTime AND t.tripStatus = 'SCHEDULED' ORDER BY t.departureTime ASC")
    List<Trip> findTripsAfterTime(
            @Param("travelDate") LocalDate travelDate,
            @Param("afterTime") LocalTime afterTime);

    @Query("SELECT t FROM Trip t WHERE t.travelDate = :travelDate AND t.route = :route AND t.tripId != :excludeTripId AND t.tripStatus = 'SCHEDULED' ORDER BY t.departureTime ASC")
    List<Trip> findAlternativeTripsOnRoute(
            @Param("travelDate") LocalDate travelDate,
            @Param("route") Route route,
            @Param("excludeTripId") Long excludeTripId);

    @Query("SELECT t FROM Trip t WHERE t.tripStatus = :tripStatus ORDER BY t.travelDate DESC, t.departureTime ASC")
    List<Trip> findByTripStatusOrderByDate(@Param("tripStatus") String tripStatus);
}
