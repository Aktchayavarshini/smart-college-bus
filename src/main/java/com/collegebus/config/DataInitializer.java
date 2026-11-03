package com.collegebus.config;

import com.collegebus.entity.*;
import com.collegebus.repository.*;
import org.springframework.boot.CommandLineRunner;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.Arrays;
import java.util.List;

/**
 * Automatically seeds initial database records on application startup if empty.
 * Guarantees that whether running against local MySQL or in-memory presentation mode,
 * all test accounts, buses, routes, drivers, and trips are instantly available.
 */
@Component
public class DataInitializer implements CommandLineRunner {

    private final UserRepository userRepository;
    private final StudentRepository studentRepository;
    private final TeacherRepository teacherRepository;
    private final BusRepository busRepository;
    private final DriverRepository driverRepository;
    private final RouteRepository routeRepository;
    private final BusStopRepository busStopRepository;
    private final RouteStopRepository routeStopRepository;
    private final TripRepository tripRepository;
    private final AcademicTimetableRepository academicTimetableRepository;
    private final ExamTimetableRepository examTimetableRepository;
    private final PasswordEncoder passwordEncoder;

    public DataInitializer(UserRepository userRepository,
                           StudentRepository studentRepository,
                           TeacherRepository teacherRepository,
                           BusRepository busRepository,
                           DriverRepository driverRepository,
                           RouteRepository routeRepository,
                           BusStopRepository busStopRepository,
                           RouteStopRepository routeStopRepository,
                           TripRepository tripRepository,
                           AcademicTimetableRepository academicTimetableRepository,
                           ExamTimetableRepository examTimetableRepository,
                           PasswordEncoder passwordEncoder) {
        this.userRepository = userRepository;
        this.studentRepository = studentRepository;
        this.teacherRepository = teacherRepository;
        this.busRepository = busRepository;
        this.driverRepository = driverRepository;
        this.routeRepository = routeRepository;
        this.busStopRepository = busStopRepository;
        this.routeStopRepository = routeStopRepository;
        this.tripRepository = tripRepository;
        this.academicTimetableRepository = academicTimetableRepository;
        this.examTimetableRepository = examTimetableRepository;
        this.passwordEncoder = passwordEncoder;
    }

    @Override
    @Transactional
    public void run(String... args) {
        if (userRepository.count() > 0) {
            return; // Data already exists
        }

        System.out.println("[DATA-INIT] Seeding initial demonstration data into database...");

        // 1. Users & Profiles
        User admin = userRepository.save(new User("Transport Administrator", "admin@collegebus.edu",
                passwordEncoder.encode("Admin@123"), "9876543210", "ADMIN"));

        User studentUser = userRepository.save(new User("Mukesh K", "student@collegebus.edu",
                passwordEncoder.encode("Student@123"), "9876543211", "STUDENT"));
        studentRepository.save(new Student(studentUser, "2025IT0101", "Information Technology", 3, 5, "DAY_SCHOLAR", null));

        User hostelUser = userRepository.save(new User("Deepika R", "hostel@collegebus.edu",
                passwordEncoder.encode("Student@123"), "9876543212", "STUDENT"));
        studentRepository.save(new Student(hostelUser, "2025IT0102", "Information Technology", 3, 5, "HOSTEL", "Kaveri Block B"));

        User teacherUser = userRepository.save(new User("Dr. Arulmozhi Varman", "teacher@collegebus.edu",
                passwordEncoder.encode("Teacher@123"), "9876543213", "TEACHER"));
        teacherRepository.save(new Teacher(teacherUser, "EMP-CSE-402", "Computer Science", "Associate Professor"));

        // 2. Buses
        Bus bus1 = busRepository.save(new Bus("BUS-101", "TN-01-AB-1234", 50, "AC", "ACTIVE"));
        Bus bus2 = busRepository.save(new Bus("BUS-102", "TN-01-AB-5678", 55, "NON_AC", "ACTIVE"));
        Bus bus3 = busRepository.save(new Bus("BUS-103", "TN-02-CD-9012", 40, "NON_AC", "ACTIVE"));
        Bus bus4 = busRepository.save(new Bus("BUS-104", "TN-02-CD-3456", 35, "AC", "ACTIVE"));
        Bus bus5 = busRepository.save(new Bus("BUS-105", "TN-03-EF-7890", 50, "NON_AC", "ACTIVE"));

        // 3. Drivers
        Driver d1 = driverRepository.save(new Driver("Murugan K", "9840112233", "TN-02-DL-2015-7788", "ACTIVE"));
        Driver d2 = driverRepository.save(new Driver("Selvam P", "9840223344", "TN-02-DL-2018-9900", "ACTIVE"));
        Driver d3 = driverRepository.save(new Driver("Rajendran M", "9840334455", "TN-02-DL-2012-3344", "ACTIVE"));
        Driver d4 = driverRepository.save(new Driver("Senthil Kumar R", "9840445566", "TN-03-DL-2016-5566", "ACTIVE"));
        Driver d5 = driverRepository.save(new Driver("Balaji V", "9840556677", "TN-01-DL-2019-1122", "ACTIVE"));

        // 4. Routes
        Route r1 = routeRepository.save(new Route("Route 101 - Pallavaram Express", "Pallavaram", "Campus", "Corridor via GST Road", "ACTIVE"));
        Route r2 = routeRepository.save(new Route("Route 102 - Tambaram Corridor", "Tambaram", "Campus", "Corridor via Sanatorium & MIT", "ACTIVE"));
        Route r3 = routeRepository.save(new Route("Route 103 - Guindy Shuttle", "Guindy", "Campus", "Corridor via Kathipara", "ACTIVE"));
        Route r4 = routeRepository.save(new Route("Route 104 - Velachery Direct", "Velachery", "Campus", "Corridor via Vijayanagar", "ACTIVE"));
        Route r5 = routeRepository.save(new Route("Route 105 - Central Link", "Central", "Campus", "Corridor via Mount Road", "ACTIVE"));

        // 5. Bus Stops
        BusStop s1 = busStopRepository.save(new BusStop("Pallavaram Bus Stand", "GST Road", "Pallavaram", "ACTIVE"));
        BusStop s2 = busStopRepository.save(new BusStop("Chromepet MIT Gate", "GST Road", "Chromepet", "ACTIVE"));
        BusStop s3 = busStopRepository.save(new BusStop("Tambaram Sanatorium", "GST Road", "Tambaram", "ACTIVE"));
        BusStop s4 = busStopRepository.save(new BusStop("Tambaram West Terminus", "Mudichur Road", "Tambaram", "ACTIVE"));
        BusStop s5 = busStopRepository.save(new BusStop("Guindy Kathipara Junction", "Guindy Highway", "Guindy", "ACTIVE"));
        BusStop s6 = busStopRepository.save(new BusStop("Velachery Vijayanagar", "Velachery Main Road", "Velachery", "ACTIVE"));
        BusStop s7 = busStopRepository.save(new BusStop("Chennai Central Station", "EVR Periyar Salai", "Central", "ACTIVE"));
        BusStop s8 = busStopRepository.save(new BusStop("College Campus Main Gate", "Institution Campus", "Campus", "ACTIVE"));

        // 6. Route Stops
        routeStopRepository.save(new RouteStop(r1, s1, 1, 0));
        routeStopRepository.save(new RouteStop(r1, s2, 2, 10));
        routeStopRepository.save(new RouteStop(r1, s8, 3, 35));

        routeStopRepository.save(new RouteStop(r2, s4, 1, 0));
        routeStopRepository.save(new RouteStop(r2, s3, 2, 8));
        routeStopRepository.save(new RouteStop(r2, s2, 3, 16));
        routeStopRepository.save(new RouteStop(r2, s8, 4, 40));

        routeStopRepository.save(new RouteStop(r3, s5, 1, 0));
        routeStopRepository.save(new RouteStop(r3, s1, 2, 15));
        routeStopRepository.save(new RouteStop(r3, s8, 3, 45));

        routeStopRepository.save(new RouteStop(r4, s6, 1, 0));
        routeStopRepository.save(new RouteStop(r4, s8, 2, 35));

        routeStopRepository.save(new RouteStop(r5, s7, 1, 0));
        routeStopRepository.save(new RouteStop(r5, s5, 2, 25));
        routeStopRepository.save(new RouteStop(r5, s8, 3, 55));

        // 7. Trips for today and upcoming 7 days
        LocalDate today = LocalDate.now();
        List<LocalDate> dates = Arrays.asList(today, today.plusDays(1), today.plusDays(2), today.plusDays(3));

        for (LocalDate d : dates) {
            tripRepository.save(new Trip(bus1, r1, d1, d, LocalTime.of(7, 0), LocalTime.of(7, 40), "REGULAR", "SCHEDULED", LocalTime.of(6, 30)));
            tripRepository.save(new Trip(bus2, r2, d2, d, LocalTime.of(7, 30), LocalTime.of(8, 15), "REGULAR", "SCHEDULED", LocalTime.of(7, 0)));
            tripRepository.save(new Trip(bus3, r3, d3, d, LocalTime.of(8, 0), LocalTime.of(8, 50), "REGULAR", "SCHEDULED", LocalTime.of(7, 30)));
            tripRepository.save(new Trip(bus4, r1, d4, d, LocalTime.of(12, 0), LocalTime.of(12, 45), "EXAM_SPECIAL", "SCHEDULED", LocalTime.of(11, 30)));
            tripRepository.save(new Trip(bus5, r2, d5, d, LocalTime.of(15, 0), LocalTime.of(15, 45), "REGULAR", "SCHEDULED", LocalTime.of(14, 30)));
            tripRepository.save(new Trip(bus1, r3, d1, d, LocalTime.of(17, 0), LocalTime.of(17, 50), "EVENING", "SCHEDULED", LocalTime.of(16, 30)));
        }

        // 8. Timetable Entries
        academicTimetableRepository.save(new AcademicTimetable("Information Technology", 3, 5, "MONDAY",
                LocalTime.of(8, 30), LocalTime.of(16, 30), "Object-Oriented Analysis & Design Lab", "ACTIVE"));
        academicTimetableRepository.save(new AcademicTimetable("Information Technology", 3, 5, "TUESDAY",
                LocalTime.of(8, 30), LocalTime.of(15, 0), "Database Management Systems", "ACTIVE"));
        academicTimetableRepository.save(new AcademicTimetable("Computer Science", 3, 5, "WEDNESDAY",
                LocalTime.of(8, 30), LocalTime.of(16, 30), "Full-Stack Web Development", "ACTIVE"));

        examTimetableRepository.save(new ExamTimetable("Information Technology", 3, 5, "Database Management Systems",
                today, LocalTime.of(9, 30), LocalTime.of(11, 30), "SEMESTER_FINAL"));
        examTimetableRepository.save(new ExamTimetable("Information Technology", 3, 5, "Object-Oriented Programming in Java",
                today.plusDays(2), LocalTime.of(9, 30), LocalTime.of(11, 30), "SEMESTER_FINAL"));

        System.out.println("[DATA-INIT] Successfully seeded initial demonstration data!");
    }
}
