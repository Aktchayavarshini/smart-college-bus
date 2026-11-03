package com.collegebus.oop.service;

import com.collegebus.oop.exception.DuplicateBookingException;
import com.collegebus.oop.exception.SeatNotAvailableException;
import com.collegebus.oop.model.AbstractPerson;
import com.collegebus.oop.model.AbstractVehicle;
import com.collegebus.oop.model.CollegeBus;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Service Manager orchestrating OOP Allocation Logic and Demonstrations.
 *
 * Demonstrates:
 * 1. Compile-Time Polymorphism (Method Overloading): Three overloaded variants of allocateSeat().
 * 2. Runtime Polymorphism (Dynamic Method Dispatch): Dispatches vehicle cost & fare logic based
 *    on concrete runtime subclass type.
 * 3. Custom Exception Handling: Throws SeatNotAvailableException and DuplicateBookingException.
 */
public class BusAllocationManager {

    // Simulates active passenger reservations tracking: email -> list of bus numbers
    private final Map<String, List<String>> activePassengerBookings = new HashMap<>();

    // ==========================================
    // METHOD OVERLOADING (COMPILE-TIME POLYMORPHISM)
    // ==========================================

    /**
     * Overload 1: Basic seat allocation with default stops.
     */
    public synchronized boolean allocateSeat(CollegeBus bus, AbstractPerson passenger)
            throws SeatNotAvailableException, DuplicateBookingException {
        return allocateSeat(bus, passenger, "Campus Main Gate", "Terminus Hub");
    }

    /**
     * Overload 2: Seat allocation with explicit pickup and drop-off stops.
     */
    public synchronized boolean allocateSeat(CollegeBus bus, AbstractPerson passenger,
                                             String pickupStop, String dropoffStop)
            throws SeatNotAvailableException, DuplicateBookingException {
        return allocateSeat(bus, passenger, pickupStop, dropoffStop, false);
    }

    /**
     * Overload 3: Full seat allocation with priority waitlist override flag.
     */
    public synchronized boolean allocateSeat(CollegeBus bus, AbstractPerson passenger,
                                             String pickupStop, String dropoffStop,
                                             boolean priorityWaitlist)
            throws SeatNotAvailableException, DuplicateBookingException {

        // 1. Verify passenger active booking quota
        List<String> userBookings = activePassengerBookings.computeIfAbsent(passenger.getEmail(), k -> new ArrayList<>());
        if (userBookings.size() >= passenger.getMaxSimultaneousBookings() && !priorityWaitlist) {
            throw new DuplicateBookingException(passenger.getEmail(), "2026-11-03", "08:00 AM");
        }

        // 2. Verify seat availability on bus
        if (!bus.hasAvailableSeats()) {
            throw new SeatNotAvailableException(bus.getBusNumber(), 1, bus.getAvailableSeats());
        }

        // 3. Atomically reserve seat
        boolean reserved = bus.reserveSeat();
        if (reserved) {
            userBookings.add(bus.getBusNumber());
        }
        return reserved;
    }

    // ==========================================
    // DYNAMIC METHOD DISPATCH (RUNTIME POLYMORPHISM)
    // ==========================================

    /**
     * Computes total operational metrics for a fleet of vehicles polymorphically.
     * Dynamic method dispatch automatically invokes the subclass's overridden implementation!
     *
     * @param fleet list of abstract vehicle instances
     * @param journeyDistanceKm distance traveled
     * @return summary map containing fleet expenditure and metrics
     */
    public Map<String, Object> analyzeFleetOperations(List<AbstractVehicle> fleet, double journeyDistanceKm) {
        double totalFleetCost = 0.0;
        int totalFleetSeats = 0;
        List<String> vehicleReports = new ArrayList<>();

        for (AbstractVehicle vehicle : fleet) {
            // Polymorphic dispatch: invokes AirConditionedBus vs StandardCollegeBus calculateOperatingCostPerKm()
            double unitCostPerKm = vehicle.calculateOperatingCostPerKm();
            double tripCost = unitCostPerKm * journeyDistanceKm;
            totalFleetCost += tripCost;
            totalFleetSeats += vehicle.getCapacity();

            String report = String.format("%s | Cost/km: Rs. %.2f | Trip (%s km): Rs. %.2f | Comfort: %.2fx",
                    vehicle.getVehicleCategory(),
                    unitCostPerKm,
                    journeyDistanceKm,
                    tripCost,
                    vehicle.getComfortMultiplier());
            vehicleReports.add(report);
        }

        Map<String, Object> result = new HashMap<>();
        result.put("totalFleetCost", totalFleetCost);
        result.put("totalFleetSeats", totalFleetSeats);
        result.put("vehicleReports", vehicleReports);
        return result;
    }

    /**
     * Releases an allocated seat and clears reservation record.
     */
    public synchronized boolean releaseSeat(CollegeBus bus, AbstractPerson passenger) {
        List<String> bookings = activePassengerBookings.get(passenger.getEmail());
        if (bookings != null && bookings.remove(bus.getBusNumber())) {
            return bus.releaseSeat();
        }
        return false;
    }

    public void clearAllReservations() {
        activePassengerBookings.clear();
    }
}
