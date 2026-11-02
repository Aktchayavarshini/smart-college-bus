package com.collegebus.service;

import com.collegebus.dto.BusSearchDto;
import com.collegebus.dto.TripCardDto;
import com.collegebus.entity.Trip;

import java.time.LocalDate;
import java.util.List;

public interface TripService {

    List<Trip> getAllTrips();

    Trip getTripById(Long id);

    TripCardDto getTripCardById(Long id, Long pickupStopId, Long dropoffStopId);

    Trip saveTrip(Trip trip);

    Trip createTrip(Long busId, Long routeId, Long driverId, LocalDate travelDate,
                    String departureTime, String arrivalTime, String tripType, String cutoffTime);

    Trip updateTrip(Long id, Long busId, Long routeId, Long driverId, LocalDate travelDate,
                    String departureTime, String arrivalTime, String tripType, String cutoffTime, String tripStatus);

    void cancelTrip(Long tripId);

    List<TripCardDto> searchTrips(BusSearchDto searchDto);

    List<TripCardDto> findAlternativeTrips(Long tripId);

    long countTotalTrips();
}
