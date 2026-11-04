package com.collegebus.controller.api;

import com.collegebus.dto.BusSearchDto;
import com.collegebus.dto.TripCardDto;
import com.collegebus.service.BusStopService;
import com.collegebus.service.TripService;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.ResponseEntity;
import org.springframework.security.web.csrf.CsrfToken;
import java.util.Map;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.List;

/**
 * Read-only transit discovery API for the Next.js client.
 * Booking and account mutations remain on the authenticated MVC routes
 * until the API authentication contract is introduced.
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
    public ResponseEntity<List<TripCardDto>> searchTrips(
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate travelDate,
            @RequestParam(defaultValue = "ALL") String preferredTimeSlot,
            @RequestParam(required = false) Long pickupStopId,
            @RequestParam(required = false) Long dropoffStopId) {

        if (travelDate.isBefore(LocalDate.now())) {
            return ResponseEntity.badRequest().build();
        }

        BusSearchDto criteria = new BusSearchDto(
                travelDate, preferredTimeSlot, pickupStopId, dropoffStopId);
        return ResponseEntity.ok(tripService.searchTrips(criteria));
    }

    @GetMapping("/trips/{tripId}")
    public ResponseEntity<TripCardDto> getTrip(
            @PathVariable Long tripId,
            @RequestParam(required = false) Long pickupStopId,
            @RequestParam(required = false) Long dropoffStopId) {
        return ResponseEntity.ok(
                tripService.getTripCardById(tripId, pickupStopId, dropoffStopId));
    }

    public record StopResponse(
            Long id,
            String name,
            String area,
            String description) {
    }
}
