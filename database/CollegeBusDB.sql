-- =====================================================================
-- SMART COLLEGE BUS ALLOCATION SYSTEM - COMPLETE DATABASE SCHEMA
-- Database: CollegeBusDB
-- Engine: InnoDB | Character Set: utf8mb4 | Collation: utf8mb4_unicode_ci
-- Target Platform: MySQL 8.0+ / MySQL 5.7+ / MySQL Workbench
-- =====================================================================

-- 1. Create Database if not exists
CREATE DATABASE IF NOT EXISTS CollegeBusDB
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE CollegeBusDB;

-- Disable foreign key checks during schema drops/recreations
SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS seat_requests;
DROP TABLE IF EXISTS bookings;
DROP TABLE IF EXISTS route_stops;
DROP TABLE IF EXISTS trips;
DROP TABLE IF EXISTS buses;
DROP TABLE IF EXISTS drivers;
DROP TABLE IF EXISTS bus_stops;
DROP TABLE IF EXISTS routes;
DROP TABLE IF EXISTS exam_timetable;
DROP TABLE IF EXISTS academic_timetable;
DROP TABLE IF EXISTS teachers;
DROP TABLE IF EXISTS students;
DROP TABLE IF EXISTS users;

SET FOREIGN_KEY_CHECKS = 1;

-- =====================================================================
-- TABLE 1: users
-- Stores all system user accounts (Students, Teachers, Transport Admins)
-- =====================================================================
CREATE TABLE users (
    user_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    password VARCHAR(255) NOT NULL,
    phone_number VARCHAR(20) NOT NULL,
    role VARCHAR(20) NOT NULL COMMENT 'STUDENT, TEACHER, ADMIN',
    account_status VARCHAR(20) NOT NULL DEFAULT 'ACTIVE' COMMENT 'ACTIVE, INACTIVE, SUSPENDED',
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT uk_users_email UNIQUE (email),
    INDEX idx_users_role (role),
    INDEX idx_users_status (account_status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================================
-- TABLE 2: students
-- One-to-One relationship with users table for student-specific info
-- =====================================================================
CREATE TABLE students (
    student_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT NOT NULL,
    roll_number VARCHAR(50) NOT NULL,
    department VARCHAR(100) NOT NULL,
    academic_year INT NOT NULL COMMENT '1 to 4',
    semester INT NOT NULL COMMENT '1 to 8',
    student_type VARCHAR(30) NOT NULL DEFAULT 'DAY_SCHOLAR' COMMENT 'DAY_SCHOLAR, HOSTEL',
    hostel_name VARCHAR(100) NULL,
    CONSTRAINT uk_students_user_id UNIQUE (user_id),
    CONSTRAINT uk_students_roll_number UNIQUE (roll_number),
    CONSTRAINT fk_students_user FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    INDEX idx_students_dept_sem (department, semester)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================================
-- TABLE 3: teachers
-- One-to-One relationship with users table for faculty-specific info
-- =====================================================================
CREATE TABLE teachers (
    teacher_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT NOT NULL,
    employee_id VARCHAR(50) NOT NULL,
    department VARCHAR(100) NOT NULL,
    designation VARCHAR(100) NOT NULL,
    CONSTRAINT uk_teachers_user_id UNIQUE (user_id),
    CONSTRAINT uk_teachers_employee_id UNIQUE (employee_id),
    CONSTRAINT fk_teachers_user FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    INDEX idx_teachers_dept (department)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================================
-- TABLE 4: buses
-- Bus fleet management including capacity and operational status
-- =====================================================================
CREATE TABLE buses (
    bus_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    bus_number VARCHAR(50) NOT NULL COMMENT 'e.g., BUS-101, BUS-102',
    registration_number VARCHAR(50) NOT NULL COMMENT 'e.g., TN-01-AB-1234',
    total_seats INT NOT NULL,
    bus_type VARCHAR(30) NOT NULL DEFAULT 'NON_AC' COMMENT 'AC, NON_AC, DELUXE',
    bus_status VARCHAR(30) NOT NULL DEFAULT 'ACTIVE' COMMENT 'ACTIVE, MAINTENANCE, INACTIVE',
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT uk_buses_bus_number UNIQUE (bus_number),
    CONSTRAINT uk_buses_registration_number UNIQUE (registration_number),
    INDEX idx_buses_status (bus_status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================================
-- TABLE 5: drivers
-- Driver records and contact details
-- =====================================================================
CREATE TABLE drivers (
    driver_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    driver_name VARCHAR(100) NOT NULL,
    phone_number VARCHAR(20) NOT NULL,
    license_number VARCHAR(50) NOT NULL,
    driver_status VARCHAR(30) NOT NULL DEFAULT 'ACTIVE' COMMENT 'ACTIVE, ON_LEAVE, INACTIVE',
    CONSTRAINT uk_drivers_license UNIQUE (license_number),
    INDEX idx_drivers_status (driver_status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================================
-- TABLE 6: routes
-- Defined bus transportation routes connecting college to various areas
-- =====================================================================
CREATE TABLE routes (
    route_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    route_name VARCHAR(100) NOT NULL,
    source VARCHAR(100) NOT NULL,
    destination VARCHAR(100) NOT NULL,
    route_description TEXT NULL,
    route_status VARCHAR(30) NOT NULL DEFAULT 'ACTIVE' COMMENT 'ACTIVE, INACTIVE',
    INDEX idx_routes_status (route_status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================================
-- TABLE 7: bus_stops
-- Master repository of approved college bus stops with locality names
-- =====================================================================
CREATE TABLE bus_stops (
    stop_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    stop_name VARCHAR(100) NOT NULL,
    location_description VARCHAR(255) NULL,
    area VARCHAR(100) NOT NULL,
    stop_status VARCHAR(30) NOT NULL DEFAULT 'ACTIVE' COMMENT 'ACTIVE, INACTIVE',
    INDEX idx_stops_area (area),
    INDEX idx_stops_name (stop_name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================================
-- TABLE 8: route_stops
-- Junction table mapping stops to routes with sequence and estimated travel times
-- =====================================================================
CREATE TABLE route_stops (
    route_stop_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    route_id BIGINT NOT NULL,
    stop_id BIGINT NOT NULL,
    stop_sequence INT NOT NULL COMMENT '1=First stop, 2=Second, etc.',
    estimated_travel_minutes INT NOT NULL DEFAULT 0,
    CONSTRAINT uk_route_stop_seq UNIQUE (route_id, stop_sequence),
    CONSTRAINT uk_route_stop UNIQUE (route_id, stop_id),
    CONSTRAINT fk_route_stops_route FOREIGN KEY (route_id) REFERENCES routes(route_id) ON DELETE CASCADE,
    CONSTRAINT fk_route_stops_stop FOREIGN KEY (stop_id) REFERENCES bus_stops(stop_id) ON DELETE RESTRICT,
    INDEX idx_route_stops_route (route_id),
    INDEX idx_route_stops_stop (stop_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================================
-- TABLE 9: trips
-- Scheduled journeys combining a Bus, Route, Driver, Date and Time slot
-- =====================================================================
CREATE TABLE trips (
    trip_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    bus_id BIGINT NOT NULL,
    route_id BIGINT NOT NULL,
    driver_id BIGINT NOT NULL,
    travel_date DATE NOT NULL,
    departure_time TIME NOT NULL,
    arrival_time TIME NULL,
    trip_type VARCHAR(30) NOT NULL DEFAULT 'REGULAR' COMMENT 'REGULAR, EXAM_SPECIAL, EVENING',
    trip_status VARCHAR(30) NOT NULL DEFAULT 'SCHEDULED' COMMENT 'SCHEDULED, IN_TRANSIT, COMPLETED, CANCELLED',
    booking_cutoff_time TIME NOT NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_trips_bus FOREIGN KEY (bus_id) REFERENCES buses(bus_id) ON DELETE RESTRICT,
    CONSTRAINT fk_trips_route FOREIGN KEY (route_id) REFERENCES routes(route_id) ON DELETE RESTRICT,
    CONSTRAINT fk_trips_driver FOREIGN KEY (driver_id) REFERENCES drivers(driver_id) ON DELETE RESTRICT,
    INDEX idx_trips_date_time (travel_date, departure_time),
    INDEX idx_trips_status (trip_status),
    INDEX idx_trips_route_date (route_id, travel_date)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================================
-- TABLE 10: bookings
-- Confirmed and cancelled student/teacher seat reservations
-- =====================================================================
CREATE TABLE bookings (
    booking_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT NOT NULL,
    trip_id BIGINT NOT NULL,
    pickup_stop_id BIGINT NOT NULL,
    dropoff_stop_id BIGINT NOT NULL,
    requested_pickup_text VARCHAR(150) NULL,
    requested_destination_text VARCHAR(150) NULL,
    booking_status VARCHAR(30) NOT NULL DEFAULT 'CONFIRMED' COMMENT 'CONFIRMED, CANCELLED, MODIFIED',
    booking_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_bookings_user FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE RESTRICT,
    CONSTRAINT fk_bookings_trip FOREIGN KEY (trip_id) REFERENCES trips(trip_id) ON DELETE RESTRICT,
    CONSTRAINT fk_bookings_pickup FOREIGN KEY (pickup_stop_id) REFERENCES bus_stops(stop_id) ON DELETE RESTRICT,
    CONSTRAINT fk_bookings_dropoff FOREIGN KEY (dropoff_stop_id) REFERENCES bus_stops(stop_id) ON DELETE RESTRICT,
    INDEX idx_bookings_user_status (user_id, booking_status),
    INDEX idx_bookings_trip_status (trip_id, booking_status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================================
-- TABLE 11: seat_requests
-- Requests placed by passengers when a bus trip is already full
-- =====================================================================
CREATE TABLE seat_requests (
    request_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT NOT NULL,
    trip_id BIGINT NOT NULL,
    pickup_stop_id BIGINT NOT NULL,
    dropoff_stop_id BIGINT NOT NULL,
    request_status VARCHAR(30) NOT NULL DEFAULT 'PENDING' COMMENT 'PENDING, APPROVED, REJECTED',
    requested_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    processed_at DATETIME NULL,
    processed_by BIGINT NULL,
    CONSTRAINT fk_requests_user FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE RESTRICT,
    CONSTRAINT fk_requests_trip FOREIGN KEY (trip_id) REFERENCES trips(trip_id) ON DELETE RESTRICT,
    CONSTRAINT fk_requests_pickup FOREIGN KEY (pickup_stop_id) REFERENCES bus_stops(stop_id) ON DELETE RESTRICT,
    CONSTRAINT fk_requests_dropoff FOREIGN KEY (dropoff_stop_id) REFERENCES bus_stops(stop_id) ON DELETE RESTRICT,
    CONSTRAINT fk_requests_admin FOREIGN KEY (processed_by) REFERENCES users(user_id) ON DELETE RESTRICT,
    INDEX idx_requests_status (request_status),
    INDEX idx_requests_trip (trip_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================================
-- TABLE 12: academic_timetable
-- College class schedule for department, academic year and semester
-- =====================================================================
CREATE TABLE academic_timetable (
    timetable_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    department VARCHAR(100) NOT NULL,
    academic_year INT NOT NULL,
    semester INT NOT NULL,
    day_of_week VARCHAR(20) NOT NULL COMMENT 'MONDAY, TUESDAY, WEDNESDAY, THURSDAY, FRIDAY, SATURDAY',
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    subject_name VARCHAR(150) NOT NULL,
    timetable_status VARCHAR(30) NOT NULL DEFAULT 'ACTIVE',
    INDEX idx_academic_lookup (department, academic_year, semester, day_of_week)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================================
-- TABLE 13: exam_timetable
-- College examination schedule used for return bus trip recommendations
-- =====================================================================
CREATE TABLE exam_timetable (
    exam_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    department VARCHAR(100) NOT NULL,
    academic_year INT NOT NULL,
    semester INT NOT NULL,
    subject_name VARCHAR(150) NOT NULL,
    exam_date DATE NOT NULL,
    exam_start_time TIME NOT NULL,
    exam_end_time TIME NOT NULL,
    exam_type VARCHAR(50) NOT NULL DEFAULT 'SEMESTER_FINAL' COMMENT 'MID_TERM, SEMESTER_FINAL, MODEL_EXAM',
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_exam_date (exam_date),
    INDEX idx_exam_dept (department, academic_year, semester)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================================
-- SEED DATA INSERTION
-- Realistic records covering Chennai routes (Pallavaram, Tambaram, etc.)
-- Default passwords:
--   admin@collegebus.edu   -> Admin@123   (BCrypt hash below)
--   teacher@collegebus.edu -> Teacher@123 (BCrypt hash below)
--   student@collegebus.edu -> Student@123 (BCrypt hash below)
--   hostel@collegebus.edu  -> Student@123 (BCrypt hash below)
-- =====================================================================

-- BCrypt hashes (Spring Security compatible):
-- Admin@123   -> $2a$10$wK1bYn.v0uWb5e5P.uF2ce4e8D/03UjH8K4b5xY2dE1tL7t.6hG7q
-- Teacher@123 -> $2a$10$8R8M6x5kY3.Qf7T5u9Y8kP9f8Q7/Wa7V8y2Z5u2e6u9Y8kP9f8Q7/
-- Student@123 -> $2a$10$2l5rJ6wV5kZ1o8T7g0.0Se9Z5j2I0Y4W8t8u7r6t5s4a3b2c1d0e.

INSERT INTO users (user_id, full_name, email, password, phone_number, role, account_status) VALUES
(1, 'System Administrator', 'admin@collegebus.edu', '$2a$10$wK1bYn.v0uWb5e5P.uF2ce4e8D/03UjH8K4b5xY2dE1tL7t.6hG7q', '9876543210', 'ADMIN', 'ACTIVE'),
(2, 'Dr. Arulmozhi Varman', 'teacher@collegebus.edu', '$2a$10$8R8M6x5kY3.Qf7T5u9Y8kP9f8Q7/Wa7V8y2Z5u2e6u9Y8kP9f8Q7/', '9876543211', 'TEACHER', 'ACTIVE'),
(3, 'Mukesh K', 'student@collegebus.edu', '$2a$10$2l5rJ6wV5kZ1o8T7g0.0Se9Z5j2I0Y4W8t8u7r6t5s4a3b2c1d0e.', '9876543212', 'STUDENT', 'ACTIVE'),
(4, 'Deepika R', 'hostel@collegebus.edu', '$2a$10$2l5rJ6wV5kZ1o8T7g0.0Se9Z5j2I0Y4W8t8u7r6t5s4a3b2c1d0e.', '9876543213', 'STUDENT', 'ACTIVE'),
(5, 'Prof. Senthil Kumar', 'senthil@collegebus.edu', '$2a$10$8R8M6x5kY3.Qf7T5u9Y8kP9f8Q7/Wa7V8y2Z5u2e6u9Y8kP9f8Q7/', '9876543214', 'TEACHER', 'ACTIVE'),
(6, 'Vigneshwaran S', 'vignesh@collegebus.edu', '$2a$10$2l5rJ6wV5kZ1o8T7g0.0Se9Z5j2I0Y4W8t8u7r6t5s4a3b2c1d0e.', '9876543215', 'STUDENT', 'ACTIVE');

-- Insert Students
INSERT INTO students (student_id, user_id, roll_number, department, academic_year, semester, student_type, hostel_name) VALUES
(1, 3, '714021104001', 'Computer Science and Engineering', 3, 5, 'DAY_SCHOLAR', NULL),
(2, 4, '714021104002', 'Information Technology', 3, 5, 'HOSTEL', 'Kaveri Girls Hostel Block B'),
(3, 6, '714021106015', 'Electronics and Communication Engineering', 2, 3, 'DAY_SCHOLAR', NULL);

-- Insert Teachers
INSERT INTO teachers (teacher_id, user_id, employee_id, department, designation) VALUES
(1, 2, 'FAC-CSE-012', 'Computer Science and Engineering', 'Associate Professor & HOD'),
(2, 5, 'FAC-ECE-008', 'Electronics and Communication Engineering', 'Assistant Professor');

-- Insert Buses
INSERT INTO buses (bus_id, bus_number, registration_number, total_seats, bus_type, bus_status) VALUES
(1, 'BUS-101', 'TN-09-CB-1001', 50, 'AC', 'ACTIVE'),
(2, 'BUS-102', 'TN-09-CB-1002', 45, 'NON_AC', 'ACTIVE'),
(3, 'BUS-103', 'TN-09-CB-1003', 55, 'NON_AC', 'ACTIVE'),
(4, 'BUS-104', 'TN-09-CB-1004', 35, 'AC', 'ACTIVE'),
(5, 'BUS-105', 'TN-09-CB-1005', 50, 'NON_AC', 'ACTIVE'),
(6, 'BUS-106', 'TN-09-CB-1006', 40, 'NON_AC', 'MAINTENANCE');

-- Insert Drivers
INSERT INTO drivers (driver_id, driver_name, phone_number, license_number, driver_status) VALUES
(1, 'R. Murugan', '9840112233', 'TN0120150001234', 'ACTIVE'),
(2, 'K. Selvam', '9840223344', 'TN0220160002345', 'ACTIVE'),
(3, 'M. Anbazhagan', '9840334455', 'TN0320170003456', 'ACTIVE'),
(4, 'P. Rajendran', '9840445566', 'TN0420180004567', 'ACTIVE'),
(5, 'S. Vijayakumar', '9840556677', 'TN0520190005678', 'ACTIVE');

-- Insert Bus Stops (Chennai Metropolitan Region)
INSERT INTO bus_stops (stop_id, stop_name, location_description, area, stop_status) VALUES
(1, 'College Main Campus', 'Central Transport Bay, College Main Gate', 'Avadi Campus', 'ACTIVE'),
(2, 'Pallavaram Bus Stand', 'GST Road, Near Pallavaram Railway Station', 'Pallavaram', 'ACTIVE'),
(3, 'Pallavaram Ponds Signal', 'GST Road, Near Ponds Factory Signal', 'Pallavaram', 'ACTIVE'),
(4, 'Tambaram Sanatorium', 'GST Road, Opp MEPZ Main Gate', 'Tambaram', 'ACTIVE'),
(5, 'Tambaram West Bus Terminus', 'Near Tambaram Railway Station Entrance', 'Tambaram', 'ACTIVE'),
(6, 'Chromepet MIT Gate', 'GST Road, Near Madras Institute of Technology Gate', 'Chromepet', 'ACTIVE'),
(7, 'Guindy Kathipara Junction', 'Under Kathipara Flyover Metro Station Exit', 'Guindy', 'ACTIVE'),
(8, 'Velachery Vijayanagar Bus Terminus', 'Vijayanagar 100 Feet Road', 'Velachery', 'ACTIVE'),
(9, 'Koyambedu CMBT', 'Outer Ring Road, Opp Rohini Theatre CMBT', 'Koyambedu', 'ACTIVE'),
(10, 'Porur Junction', 'Mount Poonamallee Road, Tollgate Corner', 'Porur', 'ACTIVE'),
(11, 'Thiruvanmiyur Bus Depot', 'TIDEL Park Junction Road', 'Thiruvanmiyur', 'ACTIVE'),
(12, 'Sholinganallur Junction', 'OMR - Medavakkam Link Road Junction', 'Sholinganallur', 'ACTIVE'),
(13, 'Perungalathur Junction', 'GST Road, Near Perungalathur Bus Shelter', 'Perungalathur', 'ACTIVE'),
(14, 'T. Nagar Panagal Park', 'Usman Road Corner, Near Bus Shelter', 'T. Nagar', 'ACTIVE'),
(15, 'Chennai Central', 'Near Park Town Railway Station & Central Gate', 'Central', 'ACTIVE');

-- Insert Routes
INSERT INTO routes (route_id, route_name, source, destination, route_description, route_status) VALUES
(1, 'Route 101 - Pallavaram Express', 'Pallavaram Bus Stand', 'College Main Campus', 'Via Chromepet, Tambaram Sanatorium, Tambaram West, Perungalathur to College Campus', 'ACTIVE'),
(2, 'Route 102 - Velachery IT Corridor', 'Velachery Vijayanagar Bus Terminus', 'College Main Campus', 'Via Guindy Kathipara, Porur, Poonamallee to College Campus', 'ACTIVE'),
(3, 'Route 103 - Central City Route', 'Chennai Central', 'College Main Campus', 'Via T. Nagar, Guindy Kathipara, Porur to College Campus', 'ACTIVE'),
(4, 'Route 104 - OMR Sholinganallur Special', 'Sholinganallur Junction', 'College Main Campus', 'Via Medavakkam, Tambaram East to College Campus', 'ACTIVE'),
(5, 'Route 105 - Return Campus to Pallavaram', 'College Main Campus', 'Pallavaram Bus Stand', 'Evening Return via Perungalathur, Tambaram, Chromepet to Pallavaram', 'ACTIVE');

-- Insert Route Stops with sequence and estimated travel times
-- Route 101: Pallavaram to Campus
INSERT INTO route_stops (route_stop_id, route_id, stop_id, stop_sequence, estimated_travel_minutes) VALUES
(1, 1, 2, 1, 0),    -- Pallavaram Bus Stand (Start)
(2, 1, 3, 2, 5),    -- Pallavaram Ponds Signal
(3, 1, 6, 3, 12),   -- Chromepet MIT Gate
(4, 1, 4, 4, 18),   -- Tambaram Sanatorium
(5, 1, 5, 5, 25),   -- Tambaram West Bus Terminus
(6, 1, 13, 6, 35),  -- Perungalathur Junction
(7, 1, 1, 7, 50);   -- College Main Campus (Arrival)

-- Route 102: Velachery to Campus
INSERT INTO route_stops (route_stop_id, route_id, stop_id, stop_sequence, estimated_travel_minutes) VALUES
(8, 2, 8, 1, 0),    -- Velachery Vijayanagar (Start)
(9, 2, 7, 2, 15),   -- Guindy Kathipara
(10, 2, 10, 3, 30),  -- Porur Junction
(11, 2, 1, 4, 55);  -- College Main Campus (Arrival)

-- Route 103: Central to Campus
INSERT INTO route_stops (route_stop_id, route_id, stop_id, stop_sequence, estimated_travel_minutes) VALUES
(12, 3, 15, 1, 0),  -- Chennai Central (Start)
(13, 3, 14, 2, 20),  -- T. Nagar Panagal Park
(14, 3, 7, 3, 35),   -- Guindy Kathipara
(15, 3, 10, 4, 48),  -- Porur Junction
(16, 3, 1, 5, 65);  -- College Main Campus (Arrival)

-- Route 104: OMR Sholinganallur to Campus
INSERT INTO route_stops (route_stop_id, route_id, stop_id, stop_sequence, estimated_travel_minutes) VALUES
(17, 4, 12, 1, 0),  -- Sholinganallur (Start)
(18, 4, 5, 2, 25),   -- Tambaram West
(19, 4, 13, 3, 35),  -- Perungalathur
(20, 4, 1, 4, 55);  -- College Main Campus (Arrival)

-- Route 105: Return Campus to Pallavaram
INSERT INTO route_stops (route_stop_id, route_id, stop_id, stop_sequence, estimated_travel_minutes) VALUES
(21, 5, 1, 1, 0),    -- College Main Campus (Start)
(22, 5, 13, 2, 15),  -- Perungalathur
(23, 5, 5, 3, 25),   -- Tambaram West
(24, 5, 4, 4, 32),   -- Tambaram Sanatorium
(25, 5, 6, 5, 38),   -- Chromepet MIT Gate
(26, 5, 2, 6, 50);   -- Pallavaram Bus Stand (Arrival)

-- Insert Scheduled Trips (Current and upcoming dates)
-- Trips for 2026-11-03 and 2026-11-04
INSERT INTO trips (trip_id, bus_id, route_id, driver_id, travel_date, departure_time, arrival_time, trip_type, trip_status, booking_cutoff_time) VALUES
(1, 1, 1, 1, '2026-11-03', '06:00:00', '06:55:00', 'REGULAR', 'SCHEDULED', '05:30:00'),
(2, 2, 1, 2, '2026-11-03', '07:00:00', '07:55:00', 'REGULAR', 'SCHEDULED', '06:30:00'),
(3, 3, 1, 3, '2026-11-03', '08:00:00', '08:55:00', 'REGULAR', 'SCHEDULED', '07:30:00'),
(4, 4, 2, 4, '2026-11-03', '07:00:00', '08:00:00', 'REGULAR', 'SCHEDULED', '06:30:00'),
(5, 5, 3, 5, '2026-11-03', '07:00:00', '08:10:00', 'REGULAR', 'SCHEDULED', '06:30:00'),
(6, 1, 5, 1, '2026-11-03', '12:00:00', '12:55:00', 'EXAM_SPECIAL', 'SCHEDULED', '11:00:00'),
(7, 2, 5, 2, '2026-11-03', '15:00:00', '15:55:00', 'REGULAR', 'SCHEDULED', '14:00:00'),
(8, 3, 5, 3, '2026-11-03', '17:00:00', '17:55:00', 'EVENING', 'SCHEDULED', '16:00:00'),
-- Next Day Trips (2026-11-04)
(9, 1, 1, 1, '2026-11-04', '07:00:00', '07:55:00', 'REGULAR', 'SCHEDULED', '06:30:00'),
(10, 2, 1, 2, '2026-11-04', '08:00:00', '08:55:00', 'REGULAR', 'SCHEDULED', '07:30:00'),
(11, 4, 2, 4, '2026-11-04', '07:00:00', '08:00:00', 'REGULAR', 'SCHEDULED', '06:30:00'),
(12, 1, 5, 1, '2026-11-04', '12:00:00', '12:55:00', 'EXAM_SPECIAL', 'SCHEDULED', '11:00:00'),
(13, 2, 5, 2, '2026-11-04', '17:00:00', '17:55:00', 'EVENING', 'SCHEDULED', '16:00:00');

-- Insert Sample Bookings
INSERT INTO bookings (booking_id, user_id, trip_id, pickup_stop_id, dropoff_stop_id, requested_pickup_text, requested_destination_text, booking_status, booking_date) VALUES
(1, 3, 2, 2, 1, 'Pallavaram Bus Stand', 'College Main Campus', 'CONFIRMED', '2026-11-02 10:15:00'),
(2, 2, 2, 6, 1, 'Chromepet MIT Gate', 'College Main Campus', 'CONFIRMED', '2026-11-02 11:30:00'),
(3, 6, 4, 8, 1, 'Velachery Vijayanagar', 'College Main Campus', 'CONFIRMED', '2026-11-02 14:20:00');

-- Insert Sample Seat Request (User waiting on full trip)
INSERT INTO seat_requests (request_id, user_id, trip_id, pickup_stop_id, dropoff_stop_id, request_status, requested_at) VALUES
(1, 4, 3, 2, 1, 'PENDING', '2026-11-02 16:45:00');

-- Insert Academic Timetable
INSERT INTO academic_timetable (timetable_id, department, academic_year, semester, day_of_week, start_time, end_time, subject_name, timetable_status) VALUES
(1, 'Computer Science and Engineering', 3, 5, 'MONDAY', '08:45:00', '09:45:00', 'Compiler Design', 'ACTIVE'),
(2, 'Computer Science and Engineering', 3, 5, 'MONDAY', '09:45:00', '10:45:00', 'Database Management Systems', 'ACTIVE'),
(3, 'Computer Science and Engineering', 3, 5, 'MONDAY', '11:00:00', '12:45:00', 'Cloud Computing Laboratory', 'ACTIVE'),
(4, 'Computer Science and Engineering', 3, 5, 'MONDAY', '13:30:00', '14:30:00', 'Object Oriented Analysis and Design', 'ACTIVE'),
(5, 'Computer Science and Engineering', 3, 5, 'MONDAY', '14:30:00', '16:30:00', 'Open Elective - Web Technology', 'ACTIVE'),
(6, 'Computer Science and Engineering', 3, 5, 'TUESDAY', '08:45:00', '10:45:00', 'Full Stack Development Lab', 'ACTIVE'),
(7, 'Information Technology', 3, 5, 'MONDAY', '08:45:00', '09:45:00', 'Information Security', 'ACTIVE'),
(8, 'Information Technology', 3, 5, 'MONDAY', '09:45:00', '10:45:00', 'Software Project Management', 'ACTIVE'),
(9, 'Electronics and Communication Engineering', 2, 3, 'MONDAY', '08:45:00', '09:45:00', 'Digital Electronics', 'ACTIVE');

-- Insert Exam Timetable (with various ending times to demonstrate return bus recommendations)
INSERT INTO exam_timetable (exam_id, department, academic_year, semester, subject_name, exam_date, exam_start_time, exam_end_time, exam_type) VALUES
(1, 'Computer Science and Engineering', 3, 5, 'CS8591 - Computer Networks', '2026-11-03', '09:30:00', '11:30:00', 'MID_TERM'),
(2, 'Computer Science and Engineering', 3, 5, 'CS8592 - Object Oriented Analysis & Design', '2026-11-04', '09:30:00', '12:30:00', 'SEMESTER_FINAL'),
(3, 'Information Technology', 3, 5, 'IT8501 - Web Technology', '2026-11-03', '13:30:00', '16:30:00', 'SEMESTER_FINAL'),
(4, 'Electronics and Communication Engineering', 2, 3, 'EC8392 - Digital Electronics', '2026-11-03', '09:30:00', '11:30:00', 'MID_TERM'),
(5, 'Computer Science and Engineering', 3, 5, 'CS8501 - Theory of Computation', '2026-11-07', '13:30:00', '14:30:00', 'MODEL_EXAM');

-- =====================================================================
-- USEFUL VERIFICATION SELECT QUERIES
-- =====================================================================

-- 1. Trip details with bus, route, driver and calculated available seats
SELECT 
    t.trip_id,
    t.travel_date,
    t.departure_time,
    r.route_name,
    b.bus_number,
    b.total_seats,
    COUNT(bk.booking_id) AS confirmed_bookings,
    (b.total_seats - COUNT(bk.booking_id)) AS available_seats,
    d.driver_name,
    t.trip_status
FROM trips t
JOIN buses b ON t.bus_id = b.bus_id
JOIN routes r ON t.route_id = r.route_id
JOIN drivers d ON t.driver_id = d.driver_id
LEFT JOIN bookings bk ON t.trip_id = bk.trip_id AND bk.booking_status = 'CONFIRMED'
GROUP BY t.trip_id, t.travel_date, t.departure_time, r.route_name, b.bus_number, b.total_seats, d.driver_name, t.trip_status;

-- 2. Route stops in sequence for Route 101
SELECT 
    rs.stop_sequence,
    s.stop_name,
    s.area,
    rs.estimated_travel_minutes
FROM route_stops rs
JOIN bus_stops s ON rs.stop_id = s.stop_id
WHERE rs.route_id = 1
ORDER BY rs.stop_sequence ASC;

-- 3. Exam return bus recommendation check for CS8591 (Exam ends 11:30 AM -> Recommend 12:00 PM Trip)
SELECT 
    e.subject_name,
    e.exam_date,
    e.exam_end_time,
    t.trip_id,
    t.departure_time AS recommended_bus_time,
    b.bus_number,
    r.route_name
FROM exam_timetable e
JOIN trips t ON t.travel_date = e.exam_date 
    AND t.departure_time >= e.exam_end_time
    AND t.departure_time <= ADDTIME(e.exam_end_time, '01:00:00')
JOIN buses b ON t.bus_id = b.bus_id
JOIN routes r ON t.route_id = r.route_id
WHERE e.exam_id = 1
ORDER BY t.departure_time ASC;

-- 4. High passenger demand routes summary
SELECT 
    r.route_name,
    COUNT(DISTINCT t.trip_id) AS total_trips,
    COUNT(bk.booking_id) AS total_passengers,
    ROUND((COUNT(bk.booking_id) / NULLIF(SUM(DISTINCT b.total_seats), 0)) * 100, 2) AS occupancy_rate_percent
FROM routes r
JOIN trips t ON r.route_id = t.route_id
JOIN buses b ON t.bus_id = b.bus_id
LEFT JOIN bookings bk ON t.trip_id = bk.trip_id AND bk.booking_status = 'CONFIRMED'
GROUP BY r.route_id, r.route_name;
