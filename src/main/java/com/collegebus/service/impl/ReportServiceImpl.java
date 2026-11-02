package com.collegebus.service.impl;

import com.collegebus.dto.DemandReportDto;
import com.collegebus.entity.*;
import com.collegebus.repository.*;
import com.collegebus.service.ReportService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;

@Service
@Transactional(readOnly = true)
public class ReportServiceImpl implements ReportService {

    private final RouteRepository routeRepository;
    private final TripRepository tripRepository;
    private final BookingRepository bookingRepository;
    private final BusRepository busRepository;
    private final UserRepository userRepository;
    private final SeatRequestRepository seatRequestRepository;

    public ReportServiceImpl(RouteRepository routeRepository,
                             TripRepository tripRepository,
                             BookingRepository bookingRepository,
                             BusRepository busRepository,
                             UserRepository userRepository,
                             SeatRequestRepository seatRequestRepository) {
        this.routeRepository = routeRepository;
        this.tripRepository = tripRepository;
        this.bookingRepository = bookingRepository;
        this.busRepository = busRepository;
        this.userRepository = userRepository;
        this.seatRequestRepository = seatRequestRepository;
    }

    @Override
    public List<DemandReportDto> getRouteDemandReports() {
        List<Route> routes = routeRepository.findAll();
        List<DemandReportDto> reports = new ArrayList<>();

        for (Route route : routes) {
            List<Trip> trips = tripRepository.findAll().stream()
                    .filter(t -> t.getRoute().getRouteId().equals(route.getRouteId()))
                    .toList();

            int totalTrips = trips.size();
            int totalCapacity = trips.stream().mapToInt(t -> t.getBus().getTotalSeats()).sum();
            int totalBookings = 0;

            for (Trip trip : trips) {
                totalBookings += bookingRepository.countByTripAndBookingStatus(trip, "CONFIRMED");
            }

            double occupancy = totalCapacity > 0 ? ((double) totalBookings / totalCapacity) * 100.0 : 0.0;
            occupancy = Math.round(occupancy * 10.0) / 10.0;

            String demandLevel;
            String recommendation;

            if (occupancy >= 80.0) {
                demandLevel = "HIGH";
                recommendation = "High congestion detected! Recommend allocating an additional 50-seater bus or splitting the route into express batches.";
            } else if (occupancy >= 45.0) {
                demandLevel = "MODERATE";
                recommendation = "Optimal passenger load. Fleet capacity adequately meets current student & faculty demand.";
            } else {
                demandLevel = "LOW";
                recommendation = "Low passenger load. Consider combining with neighboring sector trips or downsizing vehicle to 30-seater.";
            }

            DemandReportDto dto = new DemandReportDto(
                    route.getRouteId(),
                    route.getRouteName(),
                    route.getSource(),
                    route.getDestination(),
                    totalTrips,
                    totalCapacity,
                    totalBookings,
                    occupancy,
                    demandLevel,
                    recommendation
            );

            reports.add(dto);
        }

        // Sort high demand first
        reports.sort(Comparator.comparingDouble(DemandReportDto::getOccupancyPercentage).reversed());
        return reports;
    }

    @Override
    public Map<String, Object> getOverallSystemMetrics() {
        Map<String, Object> metrics = new HashMap<>();

        long totalUsers = userRepository.count();
        long students = userRepository.countByRole("STUDENT");
        long teachers = userRepository.countByRole("TEACHER");
        long buses = busRepository.count();
        long routes = routeRepository.count();
        long trips = tripRepository.count();
        long totalBookings = bookingRepository.count();
        long confirmedBookings = bookingRepository.countByBookingStatus("CONFIRMED");
        long cancelledBookings = bookingRepository.countByBookingStatus("CANCELLED");
        long pendingRequests = seatRequestRepository.countByRequestStatus("PENDING");

        metrics.put("totalUsers", totalUsers);
        metrics.put("studentsCount", students);
        metrics.put("teachersCount", teachers);
        metrics.put("busesCount", buses);
        metrics.put("routesCount", routes);
        metrics.put("tripsCount", trips);
        metrics.put("totalBookings", totalBookings);
        metrics.put("confirmedBookings", confirmedBookings);
        metrics.put("cancelledBookings", cancelledBookings);
        metrics.put("pendingRequests", pendingRequests);

        return metrics;
    }

    @Override
    public List<Map<String, Object>> getFrequentlyFullTrips() {
        List<Trip> trips = tripRepository.findAll();
        List<Map<String, Object>> fullTrips = new ArrayList<>();

        for (Trip trip : trips) {
            long confirmed = bookingRepository.countByTripAndBookingStatus(trip, "CONFIRMED");
            int capacity = trip.getBus().getTotalSeats();
            double occupancy = capacity > 0 ? ((double) confirmed / capacity) * 100.0 : 0.0;

            if (occupancy >= 75.0) {
                Map<String, Object> map = new HashMap<>();
                map.put("tripId", trip.getTripId());
                map.put("busNumber", trip.getBus().getBusNumber());
                map.put("routeName", trip.getRoute().getRouteName());
                map.put("departureTime", trip.getDepartureTime());
                map.put("travelDate", trip.getTravelDate());
                map.put("confirmed", confirmed);
                map.put("capacity", capacity);
                map.put("occupancy", Math.round(occupancy * 10.0) / 10.0);
                fullTrips.add(map);
            }
        }

        fullTrips.sort((a, b) -> Double.compare((Double) b.get("occupancy"), (Double) a.get("occupancy")));
        return fullTrips;
    }
}
