package com.collegebus.controller.api;

import com.collegebus.dto.BusSearchDto;
import com.collegebus.dto.TripCardDto;
import com.collegebus.entity.Trip;
import com.collegebus.exception.ResourceNotFoundException;
import com.collegebus.service.BusStopService;
import com.collegebus.service.TripService;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.ResponseEntity;
import org.springframework.security.web.csrf.CsrfToken;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.time.LocalTime;
import java.time.ZoneId;
import java.util.List;
import java.util.Map;

/**
 * Public, read-only transit discovery API for the Next.js client.
 * Personal driver contact information is deliberately excluded from responses.
 * Booking and account mutations remain on authenticated MVC routes.
 */
@RestController
@RequestMapping("/api/v1")
public class TransitQueryApiController {

    private final TripService tripService;
    private final BusStopService busStopService;

    public TransitQueryApiController(TripService tripService, BusStopService busStopService) {
        this.tripService = tripService;
        this.busStopService = busStopService;
    }

    @GetMapping("/csrf")
    public ResponseEntity<Map<String, String>> csrfToken(CsrfToken token) {
        return ResponseEntity.ok(Map.of("headerName", token.getHeaderName(), "token", token.getToken()));
    }

    @GetMapping("/stops")
    public ResponseEntity<List<StopResponse>> getActiveStops() {
        List<StopResponse> stops = busStopService.getActiveStops().stream()
                .map(stop -> new StopResponse(
                        stop.getStopId(),
                        stop.getStopName(),
                        stop.getArea(),
                        stop.getLocationDescription()))
                .toList();
        return ResponseEntity.ok(stops);
    }

    @GetMapping("/trips")
    public ResponseEntity<List<TripResponse>> searchTrips(
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate travelDate,
            @RequestParam(defaultValue = "ALL") String preferredTimeSlot,
            @RequestParam(required = false) Long pickupStopId,
            @RequestParam(required = false) Long dropoffStopId) {

        if (travelDate.isBefore(LocalDate.now(ZoneId.of("Asia/Kolkata")))
                || (pickupStopId != null && pickupStopId.equals(dropoffStopId))
                || !isActiveStop(pickupStopId) || !isActiveStop(dropoffStopId)) {
            return ResponseEntity.badRequest().build();
        }

        BusSearchDto criteria = new BusSearchDto(
                travelDate, preferredTimeSlot, pickupStopId, dropoffStopId);
        return ResponseEntity.ok(tripService.searchTrips(criteria).stream()
                .map(TripResponse::from)
                .toList());
    }

    @GetMapping("/trips/{tripId}")
    public ResponseEntity<TripResponse> getTrip(
            @PathVariable Long tripId,
            @RequestParam(required = false) Long pickupStopId,
            @RequestParam(required = false) Long dropoffStopId) {
        if ((pickupStopId != null && pickupStopId.equals(dropoffStopId))
                || !isActiveStop(pickupStopId) || !isActiveStop(dropoffStopId)) {
            return ResponseEntity.badRequest().build();
        }
        Trip trip;
        try {
            trip = tripService.getTripById(tripId);
        } catch (ResourceNotFoundException ex) {
            return ResponseEntity.notFound().build();
        }
        if (!"SCHEDULED".equalsIgnoreCase(trip.getTripStatus())
                || !"ACTIVE".equalsIgnoreCase(trip.getBus().getBusStatus())
                || !"ACTIVE".equalsIgnoreCase(trip.getRoute().getRouteStatus())
                || !"ACTIVE".equalsIgnoreCase(trip.getDriver().getDriverStatus())) {
            return ResponseEntity.notFound().build();
        }
        TripCardDto card;
        if (pickupStopId != null || dropoffStopId != null) {
            card = tripService.searchTrips(new BusSearchDto(trip.getTravelDate(), "ALL", pickupStopId, dropoffStopId))
                    .stream().filter(candidate -> candidate.getTripId().equals(tripId)).findFirst().orElse(null);
            if (card == null) return ResponseEntity.notFound().build();
        } else {
            card = tripService.getTripCardById(tripId, null, null);
        }
        return ResponseEntity.ok(TripResponse.from(card));
    }

    private boolean isActiveStop(Long stopId) {
        if (stopId == null) {
            return true;
        }
        return busStopService.getActiveStops().stream()
                .anyMatch(stop -> stop.getStopId().equals(stopId));
    }

    public record StopResponse(Long id, String name, String area, String description) {}

    /** Stable, privacy-minimised public contract; never expose driver phone numbers. */
    public record TripResponse(
            Long tripId,
            String busNumber,
            String routeName,
            String source,
            String destination,
            LocalDate travelDate,
            LocalTime departureTime,
            LocalTime arrivalTime,
            Integer availableSeats,
            Integer totalSeats,
            String driverName,
            String pickupStopName,
            String dropoffStopName,
            Integer estimatedTravelMinutes) {

        static TripResponse from(TripCardDto trip) {
            return new TripResponse(
                    trip.getTripId(),
                    trip.getBusNumber(),
                    trip.getRouteName(),
                    trip.getSource(),
                    trip.getDestination(),
                    trip.getTravelDate(),
                    trip.getDepartureTime(),
                    trip.getArrivalTime(),
                    trip.getAvailableSeats(),
                    trip.getTotalSeats(),
                    trip.getDriverName(),
                    trip.getPickupStopName(),
                    trip.getDropoffStopName(),
                    trip.getEstimatedTravelMinutes());
        }
    }
}
