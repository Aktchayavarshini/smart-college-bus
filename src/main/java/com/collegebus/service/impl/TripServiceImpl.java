package com.collegebus.service.impl;

import com.collegebus.dto.BusSearchDto;
import com.collegebus.dto.TripCardDto;
import com.collegebus.entity.*;
import com.collegebus.exception.ResourceNotFoundException;
import com.collegebus.repository.*;
import com.collegebus.service.TripService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.Optional;

@Service
@Transactional
public class TripServiceImpl implements TripService {

    private final TripRepository tripRepository;
    private final BusRepository busRepository;
    private final RouteRepository routeRepository;
    private final DriverRepository driverRepository;
    private final BookingRepository bookingRepository;
    private final RouteStopRepository routeStopRepository;
    private final BusStopRepository busStopRepository;

    public TripServiceImpl(TripRepository tripRepository,
                           BusRepository busRepository,
                           RouteRepository routeRepository,
                           DriverRepository driverRepository,
                           BookingRepository bookingRepository,
                           RouteStopRepository routeStopRepository,
                           BusStopRepository busStopRepository) {
        this.tripRepository = tripRepository;
        this.busRepository = busRepository;
        this.routeRepository = routeRepository;
        this.driverRepository = driverRepository;
        this.bookingRepository = bookingRepository;
        this.routeStopRepository = routeStopRepository;
        this.busStopRepository = busStopRepository;
    }

    @Override
    @Transactional(readOnly = true)
    public List<Trip> getAllTrips() {
        return tripRepository.findAll();
    }

    @Override
    @Transactional(readOnly = true)
    public Trip getTripById(Long id) {
        return tripRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Trip not found with ID: " + id));
    }

    @Override
    @Transactional(readOnly = true)
    public TripCardDto getTripCardById(Long id, Long pickupStopId, Long dropoffStopId) {
        Trip trip = getTripById(id);
        return convertToTripCardDto(trip, pickupStopId, dropoffStopId);
    }

    @Override
    public Trip saveTrip(Trip trip) {
        return tripRepository.save(trip);
    }

    @Override
    public Trip createTrip(Long busId, Long routeId, Long driverId, LocalDate travelDate,
                           String departureTime, String arrivalTime, String tripType, String cutoffTime) {
        Bus bus = busRepository.findById(busId)
                .orElseThrow(() -> new ResourceNotFoundException("Bus not found with ID: " + busId));
        Route route = routeRepository.findById(routeId)
                .orElseThrow(() -> new ResourceNotFoundException("Route not found with ID: " + routeId));
        Driver driver = driverRepository.findById(driverId)
                .orElseThrow(() -> new ResourceNotFoundException("Driver not found with ID: " + driverId));

        Trip trip = new Trip();
        trip.setBus(bus);
        trip.setRoute(route);
        trip.setDriver(driver);
        trip.setTravelDate(travelDate != null ? travelDate : LocalDate.now().plusDays(1));
        trip.setDepartureTime(LocalTime.parse(departureTime));
        if (arrivalTime != null && !arrivalTime.trim().isEmpty()) {
            trip.setArrivalTime(LocalTime.parse(arrivalTime));
        }
        trip.setTripType(tripType != null ? tripType : "REGULAR");
        trip.setTripStatus("SCHEDULED");
        trip.setBookingCutoffTime(cutoffTime != null && !cutoffTime.trim().isEmpty()
                ? LocalTime.parse(cutoffTime)
                : trip.getDepartureTime().minusMinutes(30));

        return tripRepository.save(trip);
    }

    @Override
    public Trip updateTrip(Long id, Long busId, Long routeId, Long driverId, LocalDate travelDate,
                           String departureTime, String arrivalTime, String tripType, String cutoffTime, String tripStatus) {
        Trip trip = getTripById(id);
        if (busId != null) {
            trip.setBus(busRepository.findById(busId)
                    .orElseThrow(() -> new ResourceNotFoundException("Bus not found: " + busId)));
        }
        if (routeId != null) {
            trip.setRoute(routeRepository.findById(routeId)
                    .orElseThrow(() -> new ResourceNotFoundException("Route not found: " + routeId)));
        }
        if (driverId != null) {
            trip.setDriver(driverRepository.findById(driverId)
                    .orElseThrow(() -> new ResourceNotFoundException("Driver not found: " + driverId)));
        }
        if (travelDate != null) trip.setTravelDate(travelDate);
        if (departureTime != null && !departureTime.isEmpty()) trip.setDepartureTime(LocalTime.parse(departureTime));
        if (arrivalTime != null && !arrivalTime.isEmpty()) trip.setArrivalTime(LocalTime.parse(arrivalTime));
        if (tripType != null) trip.setTripType(tripType);
        if (cutoffTime != null && !cutoffTime.isEmpty()) trip.setBookingCutoffTime(LocalTime.parse(cutoffTime));
        if (tripStatus != null) trip.setTripStatus(tripStatus);

        return tripRepository.save(trip);
    }

    @Override
    public void cancelTrip(Long tripId) {
        Trip trip = getTripById(tripId);
        trip.setTripStatus("CANCELLED");
        tripRepository.save(trip);
    }

    @Override
    @Transactional(readOnly = true)
    public List<TripCardDto> searchTrips(BusSearchDto searchDto) {
        LocalDate date = searchDto.getTravelDate() != null ? searchDto.getTravelDate() : LocalDate.now();
        List<Trip> scheduledTrips = tripRepository.findByTravelDateAndTripStatus(date, "SCHEDULED");

        // Filter by preferred time slot if provided
        String slot = searchDto.getPreferredTimeSlot();
        if (slot != null && !slot.trim().isEmpty() && !"ALL".equalsIgnoreCase(slot)) {
            LocalTime slotTime = parseSlotToTime(slot);
            if (slotTime != null) {
                LocalTime startWindow = slotTime.minusMinutes(45);
                LocalTime endWindow = slotTime.plusMinutes(45);
                scheduledTrips = scheduledTrips.stream()
                        .filter(t -> !t.getDepartureTime().isBefore(startWindow) && !t.getDepartureTime().isAfter(endWindow))
                        .toList();
            }
        }

        List<TripCardDto> matchedTrips = new ArrayList<>();

        for (Trip trip : scheduledTrips) {
            // Check pickup and dropoff stop sequence if specified
            boolean stopsMatch = true;
            Integer travelMinutes = 0;

            if (searchDto.getPickupStopId() != null && searchDto.getDropoffStopId() != null) {
                Optional<BusStop> pickupStop = busStopRepository.findById(searchDto.getPickupStopId());
                Optional<BusStop> dropoffStop = busStopRepository.findById(searchDto.getDropoffStopId());

                if (pickupStop.isPresent() && dropoffStop.isPresent()) {
                    Optional<RouteStop> pRouteStop = routeStopRepository.findByRouteAndStop(trip.getRoute(), pickupStop.get());
                    Optional<RouteStop> dRouteStop = routeStopRepository.findByRouteAndStop(trip.getRoute(), dropoffStop.get());

                    if (pRouteStop.isPresent() && dRouteStop.isPresent()) {
                        // Ensure pickup stop comes strictly before dropoff stop
                        if (pRouteStop.get().getStopSequence() < dRouteStop.get().getStopSequence()) {
                            travelMinutes = Math.abs(dRouteStop.get().getEstimatedTravelMinutes() - pRouteStop.get().getEstimatedTravelMinutes());
                            stopsMatch = true;
                        } else {
                            stopsMatch = false;
                        }
                    } else {
                        stopsMatch = false;
                    }
                }
            } else if (searchDto.getPickupStopId() != null) {
                Optional<BusStop> pickupStop = busStopRepository.findById(searchDto.getPickupStopId());
                if (pickupStop.isPresent()) {
                    stopsMatch = routeStopRepository.findByRouteAndStop(trip.getRoute(), pickupStop.get()).isPresent();
                }
            } else if (searchDto.getDropoffStopId() != null) {
                Optional<BusStop> dropoffStop = busStopRepository.findById(searchDto.getDropoffStopId());
                if (dropoffStop.isPresent()) {
                    stopsMatch = routeStopRepository.findByRouteAndStop(trip.getRoute(), dropoffStop.get()).isPresent();
                }
            }

            if (stopsMatch) {
                TripCardDto card = convertToTripCardDto(trip, searchDto.getPickupStopId(), searchDto.getDropoffStopId());
                if (travelMinutes > 0) {
                    card.setEstimatedTravelMinutes(travelMinutes);
                }
                matchedTrips.add(card);
            }
        }

        matchedTrips.sort(Comparator.comparing(TripCardDto::getDepartureTime));
        return matchedTrips;
    }

    @Override
    @Transactional(readOnly = true)
    public List<TripCardDto> findAlternativeTrips(Long tripId) {
        Trip currentTrip = getTripById(tripId);
        List<Trip> alternatives = tripRepository.findAlternativeTripsOnRoute(
                currentTrip.getTravelDate(),
                currentTrip.getRoute(),
                currentTrip.getTripId()
        );

        List<TripCardDto> result = new ArrayList<>();
        for (Trip trip : alternatives) {
            result.add(convertToTripCardDto(trip, null, null));
        }
        return result;
    }

    @Override
    @Transactional(readOnly = true)
    public long countTotalTrips() {
        return tripRepository.count();
    }

    private TripCardDto convertToTripCardDto(Trip trip, Long pickupStopId, Long dropoffStopId) {
        TripCardDto dto = new TripCardDto();
        dto.setTripId(trip.getTripId());
        dto.setBusNumber(trip.getBus().getBusNumber());
        dto.setRegistrationNumber(trip.getBus().getRegistrationNumber());
        dto.setTotalSeats(trip.getBus().getTotalSeats());

        long confirmedBookings = bookingRepository.countByTripAndBookingStatus(trip, "CONFIRMED");
        dto.setBookedSeats((int) confirmedBookings);
        int availableSeats = Math.max(0, trip.getBus().getTotalSeats() - (int) confirmedBookings);
        dto.setAvailableSeats(availableSeats);

        dto.setRouteId(trip.getRoute().getRouteId());
        dto.setRouteName(trip.getRoute().getRouteName());
        dto.setSource(trip.getRoute().getSource());
        dto.setDestination(trip.getRoute().getDestination());
        dto.setTravelDate(trip.getTravelDate());
        dto.setDepartureTime(trip.getDepartureTime());
        dto.setArrivalTime(trip.getArrivalTime());
        dto.setTripType(trip.getTripType());
        dto.setTripStatus(trip.getTripStatus());
        dto.setBookingCutoffTime(trip.getBookingCutoffTime());
        dto.setDriverName(trip.getDriver().getDriverName());
        dto.setDriverPhone(trip.getDriver().getPhoneNumber());

        if (pickupStopId != null) {
            busStopRepository.findById(pickupStopId).ifPresent(s -> {
                dto.setPickupStopId(s.getStopId());
                dto.setPickupStopName(s.getStopName());
            });
        }
        if (dropoffStopId != null) {
            busStopRepository.findById(dropoffStopId).ifPresent(s -> {
                dto.setDropoffStopId(s.getStopId());
                dto.setDropoffStopName(s.getStopName());
            });
        }

        return dto;
    }

    private LocalTime parseSlotToTime(String slot) {
        try {
            if (slot.contains(":")) {
                String[] parts = slot.split(":");
                int hour = Integer.parseInt(parts[0]);
                int minute = Integer.parseInt(parts[1].split(" ")[0]);
                if (slot.toUpperCase().contains("PM") && hour < 12) {
                    hour += 12;
                } else if (slot.toUpperCase().contains("AM") && hour == 12) {
                    hour = 0;
                }
                return LocalTime.of(hour, minute);
            }
        } catch (Exception e) {
            // fallback
        }
        return null;
    }
}
