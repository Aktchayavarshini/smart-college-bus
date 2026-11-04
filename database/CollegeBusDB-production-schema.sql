-- PRODUCTION SCHEMA-ONLY SCRIPT
-- Destructive: drops and recreates application tables. Run ONLY against a newly provisioned empty database.
-- Contains no sample users, default passwords, bookings, or demo fleet data.

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


-- Production schema setup intentionally stops before demo seed data.
