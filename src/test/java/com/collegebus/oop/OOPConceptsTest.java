package com.collegebus.oop;

import com.collegebus.oop.exception.DuplicateBookingException;
import com.collegebus.oop.exception.InvalidDataException;
import com.collegebus.oop.exception.SeatNotAvailableException;
import com.collegebus.oop.interfaces.Bookable;
import com.collegebus.oop.model.*;
import com.collegebus.oop.service.BusAllocationManager;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import java.util.Arrays;
import java.util.List;
import java.util.Map;

import static org.junit.jupiter.api.Assertions.*;

@DisplayName("OOP Core Concepts Test Suite")
class OOPConceptsTest {

    private BusAllocationManager allocationManager;

    @BeforeEach
    void setUp() {
        allocationManager = new BusAllocationManager();
        allocationManager.clearAllReservations();
    }

    // ====================================================
    // 1. ENCAPSULATION TESTS
    // ====================================================
    @Test
    @DisplayName("Encapsulation: Protects state and rejects illegal capacity values")
    void testEncapsulation_CapacityBoundaryValidation() {
        CollegeBus bus = new CollegeBus();

        // Valid boundary
        bus.setCapacity(50);
        assertEquals(50, bus.getCapacity());

        // Invalid negative capacity
        assertThrows(InvalidDataException.class, () -> bus.setCapacity(-5));

        // Invalid zero capacity
        assertThrows(InvalidDataException.class, () -> bus.setCapacity(0));

        // Invalid excessive capacity
        assertThrows(InvalidDataException.class, () -> bus.setCapacity(150));
    }

    @Test
    @DisplayName("Encapsulation: Validates email regex and masks phone numbers")
    void testEncapsulation_PersonDataIntegrity() {
        StudentPassenger student = new StudentPassenger();
        student.setPhoneNumber("9876543210");
        assertEquals("******3210", student.getMaskedPhone());

        assertThrows(InvalidDataException.class, () -> student.setEmail("not-an-email"));
        assertThrows(InvalidDataException.class, () -> student.setPhoneNumber("123")); // not 10 digits
    }

    // ====================================================
    // 2. INHERITANCE TESTS
    // ====================================================
    @Test
    @DisplayName("Inheritance: Concrete classes inherit and specialize base behaviors")
    void testInheritance_VehicleAndPersonHierarchies() {
        AirConditionedBus acBus = new AirConditionedBus(1L, "BUS-AC-101", "TN-01-AC-1234", 45, "Route 1", 21.0);
        assertTrue(acBus instanceof CollegeBus);
        assertTrue(acBus instanceof AbstractVehicle);
        assertEquals("DELUXE_AC_BUS", acBus.getVehicleCategory());

        StandardCollegeBus stdBus = new StandardCollegeBus(2L, "BUS-STD-102", "TN-01-ST-5678", 55, "Route 2", 3);
        assertTrue(stdBus instanceof CollegeBus);
        assertEquals("STANDARD_NON_AC_BUS", stdBus.getVehicleCategory());

        StudentPassenger student = new StudentPassenger(10L, "Mukesh", "mukesh@college.edu", "9876543210",
                "2025IT01", "IT", 3, 5, "DAY_SCHOLAR", null);
        assertTrue(student instanceof AbstractPerson);
        assertEquals("Student Commuter", student.getRoleTitle());
    }

    // ====================================================
    // 3. POLYMORPHISM TESTS
    // ====================================================
    @Test
    @DisplayName("Polymorphism: Compile-Time Method Overloading on calculateFare")
    void testPolymorphism_CompileTimeMethodOverloading() {
        CollegeBus bus = new CollegeBus();
        bus.setCapacity(50);
        bus.setBaseFarePerKm(2.0);

        double dist = 20.0;
        // Overload 1
        double fareStandard = bus.calculateFare(dist);
        assertEquals(40.0, fareStandard, 0.001);

        // Overload 2: Peak Hour +20%
        double farePeak = bus.calculateFare(dist, true);
        assertEquals(48.0, farePeak, 0.001);

        // Overload 3: Peak Hour + Faculty Concession (30% discount on peak fare)
        double fareConcession = bus.calculateFare(dist, true, true);
        assertEquals(33.6, fareConcession, 0.001);
    }

    @Test
    @DisplayName("Polymorphism: Runtime Dynamic Method Dispatch on Vehicle fleet")
    void testPolymorphism_RuntimeDynamicMethodDispatch() {
        StandardCollegeBus std = new StandardCollegeBus(1L, "BUS-1", "TN-01", 55, "R1", 2);
        AirConditionedBus ac = new AirConditionedBus(2L, "BUS-2", "TN-02", 40, "R2", 21.0);

        List<AbstractVehicle> fleet = Arrays.asList(std, ac);
        Map<String, Object> report = allocationManager.analyzeFleetOperations(fleet, 20.0);

        assertNotNull(report);
        assertEquals(95, (Integer) report.get("totalFleetSeats"));
        assertTrue((Double) report.get("totalFleetCost") > 0);
    }

    // ====================================================
    // 4. ABSTRACTION TESTS
    // ====================================================
    @Test
    @DisplayName("Abstraction: Bookable interface reserves and releases capacity")
    void testAbstraction_BookableContract() {
        Bookable bookableBus = new CollegeBus(1L, "BUS-TEST", "TN-01-TEST", 2, "Test Route");
        assertEquals(2, bookableBus.getAvailableSeats());
        assertTrue(bookableBus.hasAvailableSeats());

        assertTrue(bookableBus.reserveSeat());
        assertEquals(1, bookableBus.getAvailableSeats());

        assertTrue(bookableBus.reserveSeat());
        assertEquals(0, bookableBus.getAvailableSeats());
        assertFalse(bookableBus.hasAvailableSeats());

        // Further reservation must fail cleanly
        assertFalse(bookableBus.reserveSeat());

        // Releasing seat restores availability
        assertTrue(bookableBus.releaseSeat());
        assertEquals(1, bookableBus.getAvailableSeats());
        assertTrue(bookableBus.hasAvailableSeats());
    }

    // ====================================================
    // 5. EXCEPTION HANDLING TESTS
    // ====================================================
    @Test
    @DisplayName("Exception Handling: Throws SeatNotAvailableException on full bus")
    void testExceptionHandling_SeatNotAvailableException() {
        CollegeBus miniBus = new CollegeBus(1L, "BUS-MINI", "TN-01-M", 1, "Short Route");
        StudentPassenger p1 = new StudentPassenger(1L, "P1", "p1@college.edu", "9876543210", "R1", "IT", 2, 4, "DAY_SCHOLAR", null);
        StudentPassenger p2 = new StudentPassenger(2L, "P2", "p2@college.edu", "9876543211", "R2", "IT", 2, 4, "DAY_SCHOLAR", null);

        assertDoesNotThrow(() -> allocationManager.allocateSeat(miniBus, p1));

        SeatNotAvailableException ex = assertThrows(SeatNotAvailableException.class, () ->
                allocationManager.allocateSeat(miniBus, p2));
        assertEquals("BUS-MINI", ex.getBusNumber());
        assertEquals(0, ex.getAvailableSeats());
    }

    @Test
    @DisplayName("Exception Handling: Throws DuplicateBookingException on second active booking")
    void testExceptionHandling_DuplicateBookingException() {
        CollegeBus bus1 = new CollegeBus(1L, "BUS-1", "TN-01", 50, "Route 1");
        CollegeBus bus2 = new CollegeBus(2L, "BUS-2", "TN-02", 50, "Route 2");
        StudentPassenger student = new StudentPassenger(1L, "Student", "student@college.edu", "9876543210", "R1", "IT", 2, 4, "DAY_SCHOLAR", null);

        assertDoesNotThrow(() -> allocationManager.allocateSeat(bus1, student));

        DuplicateBookingException ex = assertThrows(DuplicateBookingException.class, () ->
                allocationManager.allocateSeat(bus2, student));
        assertEquals("student@college.edu", ex.getUserEmail());
    }
}
