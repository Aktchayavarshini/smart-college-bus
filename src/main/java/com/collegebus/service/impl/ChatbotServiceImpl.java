package com.collegebus.service.impl;

import com.collegebus.dto.ChatbotResponseDto;
import com.collegebus.entity.*;
import com.collegebus.repository.*;
import com.collegebus.service.ChatbotService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.util.*;

@Service
@Transactional(readOnly = true)
public class ChatbotServiceImpl implements ChatbotService {

    private final BusStopRepository busStopRepository;
    private final RouteRepository routeRepository;
    private final TripRepository tripRepository;
    private final BookingRepository bookingRepository;
    private final RouteStopRepository routeStopRepository;
    private final ExamTimetableRepository examTimetableRepository;

    public ChatbotServiceImpl(BusStopRepository busStopRepository,
                              RouteRepository routeRepository,
                              TripRepository tripRepository,
                              BookingRepository bookingRepository,
                              RouteStopRepository routeStopRepository,
                              ExamTimetableRepository examTimetableRepository) {
        this.busStopRepository = busStopRepository;
        this.routeRepository = routeRepository;
        this.tripRepository = tripRepository;
        this.bookingRepository = bookingRepository;
        this.routeStopRepository = routeStopRepository;
        this.examTimetableRepository = examTimetableRepository;
    }

    @Override
    public ChatbotResponseDto processUserQuery(String query) {
        if (query == null || query.trim().isEmpty()) {
            return new ChatbotResponseDto(
                    "Hello! I am Aadhi, your College Transportation Assistant. How can I help you today?",
                    Arrays.asList("Find bus to Pallavaram", "Check available seats", "List all routes", "Exam return buses"),
                    "/find-bus",
                    "Search Buses"
            );
        }

        String q = query.toLowerCase().trim();

        // 1. Greetings
        if (q.matches("^(hi|hello|hey|namaste|vanakkam|good morning|good afternoon|good evening).*")) {
            return new ChatbotResponseDto(
                    "Hello! I am Aadhi, your smart college bus assistant. I have live access to our CollegeBusDB database. I can help you find buses, inspect route stops, check remaining seats, or suggest alternative trips.",
                    Arrays.asList("Find bus to Pallavaram", "Buses for Tambaram", "Show all routes", "Check seats"),
                    "/find-bus",
                    "Find a Bus"
            );
        }

        // 2. Booking questions / guidance
        if (q.contains("how to book") || q.contains("book a seat") || q.contains("book seat") || q.contains("steps to book") || (q.contains("book") && q.contains("seat"))) {
            return new ChatbotResponseDto(
                    "Booking a seat is simple in 3 steps:\n" +
                    "1. Visit 'Find Bus' and select your Travel Date and Preferred Time Slot.\n" +
                    "2. Choose your Pickup and Drop-off stops to see matching buses with live seat availability.\n" +
                    "3. Click 'Book Seat', review your itinerary, and confirm! Remember, only one active confirmed booking is allowed per travel slot.",
                    Arrays.asList("Find bus now", "Can I cancel booking?", "What if bus is full?"),
                    "/find-bus",
                    "Proceed to Booking"
            );
        }

        // 3. Cancellation / Modification questions
        if (q.contains("cancel") || q.contains("modify") || q.contains("change booking")) {
            return new ChatbotResponseDto(
                    "You can cancel or modify your reservation at any time before the cutoff time from the 'My Bookings' page.\n" +
                    "• Cancellation instantly releases your seat for other passengers.\n" +
                    "• When modifying, the system safely reserves your new slot first before releasing the old one.",
                    Arrays.asList("Go to My Bookings", "Booking cutoff rules"),
                    "/my-bookings",
                    "Open My Bookings"
            );
        }

        // 4. Full bus or overflow query
        if (q.contains("full") || q.contains("overflow") || q.contains("no seats") || q.contains("request seat")) {
            return new ChatbotResponseDto(
                    "When a bus reaches maximum capacity:\n" +
                    "1. Our system automatically displays a 'Bus Full' indicator.\n" +
                    "2. You can click 'Request a Seat' to enter our priority admin waitlist.\n" +
                    "3. Or ask me to find alternative departure times or connecting routes!",
                    Arrays.asList("Find alternative for Pallavaram", "Show my pending requests"),
                    "/admin/seat-requests",
                    "Seat Request Status"
            );
        }

        // 5. Exam timetable & return bus queries
        if (q.contains("exam") || q.contains("test") || q.contains("return bus")) {
            List<ExamTimetable> upcomingExams = examTimetableRepository.findAll();
            StringBuilder reply = new StringBuilder("Our Exam Timetable integration recommends return buses matched to your exam end time:\n");
            for (ExamTimetable e : upcomingExams.stream().limit(3).toList()) {
                reply.append("• ").append(e.getSubjectName())
                     .append(" on ").append(e.getExamDate())
                     .append(" ends at ").append(e.getExamEndTime())
                     .append(" -> Return bus recommended at or after ").append(e.getExamEndTime()).append("\n");
            }
            return new ChatbotResponseDto(
                    reply.toString(),
                    Arrays.asList("View Exam Timetable", "View Academic Timetable"),
                    "/exam-timetable",
                    "View Exam Schedule & Buses"
            );
        }

        // 6. Routes query
        if (q.contains("route") || q.contains("all routes") || q.contains("list routes")) {
            List<Route> routes = routeRepository.findByRouteStatus("ACTIVE");
            StringBuilder reply = new StringBuilder("Here are the currently active routes in CollegeBusDB:\n");
            for (Route r : routes) {
                reply.append("• ").append(r.getRouteName()).append(": ").append(r.getSource()).append(" ➔ ").append(r.getDestination()).append("\n");
            }
            return new ChatbotResponseDto(
                    reply.toString(),
                    Arrays.asList("Stops for Route 101", "Find bus to Pallavaram", "Find bus to Velachery"),
                    "/find-bus",
                    "Search These Routes"
            );
        }

        // 7. Bus stops query
        if (q.contains("stop") || q.contains("pickup") || q.contains("location")) {
            List<BusStop> stops = busStopRepository.findByStopStatus("ACTIVE");
            StringBuilder reply = new StringBuilder("We have " + stops.size() + " approved bus stops across Chennai:\n");
            for (BusStop s : stops.stream().limit(8).toList()) {
                reply.append("• ").append(s.getStopName()).append(" (Area: ").append(s.getArea()).append(")\n");
            }
            if (stops.size() > 8) {
                reply.append("...and ").append(stops.size() - 8).append(" more.");
            }
            return new ChatbotResponseDto(
                    reply.toString(),
                    Arrays.asList("Buses at Pallavaram", "Buses at Tambaram", "Buses at Guindy"),
                    "/find-bus",
                    "Select Stop in Bus Search"
            );
        }

        // 8. Specific locality search (Pallavaram, Tambaram, Guindy, Velachery, Central, Porur, Chromepet, etc.)
        List<BusStop> matchedStops = busStopRepository.findAll().stream()
                .filter(s -> q.contains(s.getStopName().toLowerCase()) || q.contains(s.getArea().toLowerCase()))
                .toList();

        if (!matchedStops.isEmpty()) {
            BusStop targetStop = matchedStops.get(0);
            List<RouteStop> rStops = routeStopRepository.findByStop(targetStop);

            if (rStops.isEmpty()) {
                return new ChatbotResponseDto(
                        "Found stop '" + targetStop.getStopName() + "' in " + targetStop.getArea() + ", but no active route is currently mapped to it.",
                        Arrays.asList("List all routes", "Search other stops"),
                        "/find-bus",
                        "Browse Buses"
                );
            }

            StringBuilder reply = new StringBuilder("Database results for " + targetStop.getStopName() + " (" + targetStop.getArea() + "):\n\n");
            reply.append("Served by routes:\n");

            List<Trip> upcomingTrips = new ArrayList<>();
            for (RouteStop rs : rStops) {
                reply.append("• ").append(rs.getRoute().getRouteName()).append(" (Stop Sequence: #").append(rs.getStopSequence()).append(")\n");
                upcomingTrips.addAll(tripRepository.findAll().stream()
                        .filter(t -> t.getRoute().getRouteId().equals(rs.getRoute().getRouteId()) && "SCHEDULED".equalsIgnoreCase(t.getTripStatus()))
                        .toList());
            }

            if (!upcomingTrips.isEmpty()) {
                reply.append("\nUpcoming Scheduled Trips:\n");
                for (Trip t : upcomingTrips.stream().limit(3).toList()) {
                    long booked = bookingRepository.countByTripAndBookingStatus(t, "CONFIRMED");
                    int available = Math.max(0, t.getBus().getTotalSeats() - (int) booked);
                    reply.append("• ").append(t.getBus().getBusNumber())
                            .append(" on ").append(t.getTravelDate())
                            .append(" at ").append(t.getDepartureTime())
                            .append(" | Seats: ").append(available > 0 ? (available + " left") : "BUS FULL!")
                            .append("\n");

                    if (available <= 0) {
                        // Look for alternative trip on that date
                        List<Trip> alt = tripRepository.findAlternativeTripsOnRoute(t.getTravelDate(), t.getRoute(), t.getTripId());
                        if (!alt.isEmpty()) {
                            reply.append("   ↳ Alternative trip available: Bus ").append(alt.get(0).getBus().getBusNumber())
                                    .append(" at ").append(alt.get(0).getDepartureTime()).append("\n");
                        }
                    }
                }
            } else {
                reply.append("\nNo scheduled trips found right now for this route.");
            }

            return new ChatbotResponseDto(
                    reply.toString(),
                    Arrays.asList("Book this bus", "Check alternative routes", "Talk to Aadhi again"),
                    "/find-bus?pickup=" + targetStop.getStopId(),
                    "Book Bus for " + targetStop.getStopName()
            );
        }

        // 9. Default intelligent fallback with helpful suggestions
        return new ChatbotResponseDto(
                "I searched our CollegeBusDB database for \"" + query + "\". I can help you find buses by destination (e.g. Pallavaram, Tambaram, Guindy, Velachery), check available seats, or view exam return bus schedules.",
                Arrays.asList("Find bus to Pallavaram", "Find bus to Tambaram", "Show all routes", "Exam return buses"),
                "/find-bus",
                "Open Find Bus Page"
        );
    }
}
