# SMART COLLEGE BUS ALLOCATION SYSTEM
## Comprehensive Academic Project Report & Engineering Documentation
### Submitted for Practical Review & Degree Examination in Computer Science & Engineering / Information Technology

---

## Academic Verification Notice & Prescribed Requirements Compliance
This project satisfies all mandated evaluation criteria set forth by the project review committee:
1. **Implemented in Java:** Developed using modern Java (JDK 17 LTS / JDK 21 LTS) and Spring Boot 3.2.5.
2. **Implementation of All 6 Core OOP Concepts:**
   - **Encapsulation:** Private domain fields with validated getters and setters enforcing capacity and email invariants.
   - **Inheritance:** Multi-level class hierarchies for Vehicles (`AbstractVehicle` &rarr; `CollegeBus` &rarr; `AirConditionedBus` / `StandardCollegeBus`) and Persons (`AbstractPerson` &rarr; `StudentPassenger` / `FacultyPassenger` / `TransportStaff`).
   - **Polymorphism:** Both Compile-Time Polymorphism (Method Overloading on `calculateFare` and `allocateSeat`) and Runtime Polymorphism (Dynamic Method Dispatch on `calculateOperatingCostPerKm` and `getComfortMultiplier`).
   - **Abstraction:** Abstract Base Classes (`AbstractVehicle`, `AbstractPerson`) and pure Interfaces (`Bookable`, `FareCalculable`, `DatabaseOperations`, `Displayable`).
   - **Packages:** Clean modular packages (`com.collegebus.oop.model`, `dao`, `interfaces`, `service`, `exception`, `runner`, and web controllers/repositories).
   - **Exception Handling:** Custom exception hierarchy (`BusTransportationException`, `SeatNotAvailableException`, `DuplicateBookingException`, `BookingCutoffException`, `DatabaseOperationException`, `InvalidDataException`) with structured `try-catch-finally` resource management.
3. **Proper Database Design (DBMS):**
   - 13 normalized relational tables created using MySQL InnoDB storage engine (`CollegeBusDB.sql`).
   - Primary Keys (`AUTO_INCREMENT`), Foreign Keys (`FOREIGN KEY ... REFERENCES`), unique constraints, and composite indexes.
   - Complete ER Diagram ([`database/ER_Diagram.html`](database/ER_Diagram.html) and [`database/ER_Diagram.png`](database/ER_Diagram.png)).
4. **Direct DBMS Connectivity & CRUD Operations:**
   - Pure JDBC implementation (`java.sql.Connection`, `PreparedStatement`, `ResultSet`, `SQLException`).
   - Complete **Create, Read, Update, and Delete (CRUD)** operations implemented in `JdbcBusDao` and `JdbcBookingDao`.
   - ACID transaction management (`setAutoCommit(false)`, `commit()`, `rollback()`).
5. **Interactive Demonstrations Provided:**
   - Standalone Terminal / Eclipse Runner: `com.collegebus.oop.runner.OOPAndDBMSDemonstrationRunner`.
   - Web Architecture Dashboard: Live interactive portal at `/oop-demo` with real-time JDBC execution.

---

## Table of Contents
1. [Abstract](#1-abstract)
2. [Introduction & Background](#2-introduction--background)
3. [Problem Statement](#3-problem-statement)
4. [System Objectives & Scope](#4-system-objectives--scope)
5. [Core Object-Oriented Programming (OOP) Implementation](#5-core-object-oriented-programming-oop-implementation)
   - 5.1 [Encapsulation](#51-encapsulation)
   - 5.2 [Inheritance](#52-inheritance)
   - 5.3 [Polymorphism (Overloading & Overriding)](#53-polymorphism-overloading--overriding)
   - 5.4 [Abstraction (Abstract Classes & Interfaces)](#54-abstraction-abstract-classes--interfaces)
   - 5.5 [Package Architecture](#55-package-architecture)
   - 5.6 [Custom Exception Handling & Resource Safety](#56-custom-exception-handling--resource-safety)
6. [Database Management System (DBMS) Architecture](#6-database-management-system-dbms-architecture)
   - 6.1 [Database Schema & Normalization](#61-database-schema--normalization)
   - 6.2 [Relational Tables & Keys Breakdown](#62-relational-tables--keys-breakdown)
   - 6.3 [Entity-Relationship (ER) Diagram](#63-entity-relationship-er-diagram)
   - 6.4 [Direct JDBC Database Connectivity](#64-direct-jdbc-database-connectivity)
   - 6.5 [CRUD Operations (Create, Read, Update, Delete)](#65-crud-operations-create-read-update-delete)
   - 6.6 [ACID Transactions & Concurrency Control](#66-acid-transactions--concurrency-control)
7. [Integration of OOP Concepts with DBMS Operations](#7-integration-of-oop-concepts-with-dbms-operations)
8. [Full-Stack Web Application Modules](#8-full-stack-web-application-modules)
   - 8.1 [Authentication & RBAC](#81-authentication--rbac)
   - 8.2 [Date & Time Slot Booking Engine](#82-date--time-slot-booking-engine)
   - 8.3 [Real-Time Seat Calculation](#83-real-time-seat-calculation)
   - 8.4 [Seat Request Waitlist System](#84-seat-request-waitlist-system)
   - 8.5 [Academic & Exam Timetable Recommender](#85-academic--exam-timetable-recommender)
   - 8.6 [Talk to Aadhi Transportation Assistant](#86-talk-to-aadhi-transportation-assistant)
   - 8.7 [Admin Fleet & Analytics Suite](#87-admin-fleet--analytics-suite)
9. [Hardware & Software Requirements](#9-hardware--software-requirements)
10. [Testing Methodology & Test Suite Execution](#10-testing-methodology--test-suite-execution)
11. [Project Evaluation & Viva-Voce Demonstration Script](#11-project-evaluation--viva-voce-demonstration-script)
12. [Conclusion](#12-conclusion)

---

### 1. Abstract
The **Smart College Bus Allocation System** is an enterprise-grade full-stack transit management application built upon **Java 17/21**, **Object-Oriented Programming principles**, and **MySQL Relational Database Management Systems (DBMS)**. Modern higher education campuses transport thousands of commuters daily across sprawling metropolitan corridors. Legacy paper passes, manual spreadsheets, and static route allocations result in chronic seat imbalances, overbooking hazards, and logistical blind spots during semester examinations.

This project delivers a unified architecture that gives equal importance to both **Object-Oriented Software Engineering** and **Relational Database Design**. The application implements all 6 core OOP concepts—**Encapsulation**, **Inheritance**, **Polymorphism**, **Abstraction**, **Packages**, and **Exception Handling**—and integrates them directly with an ACID-compliant MySQL database via both direct JDBC Data Access Objects and Spring Data JPA. Commuters enjoy flexible boarding stop selection, dynamic verified seat calculations (`total_seats - confirmed_count`), waitlist overflow requests, and exam-to-bus matching. Transport managers gain complete administrative fleet oversight and demand analytics. The project includes a dedicated standalone CLI test runner and a live Web OOP demonstration suite to enable comprehensive academic review.

---

### 2. Introduction & Background
Higher education institutions face unique transportation logistical challenges. Unlike public bus corporations, college transport operates on strict academic timetables, specialized commuter categories (Day Scholars, Hostel Residents, Teaching Faculty, and Operational Staff), and irregular dismissal schedules dictated by laboratory practicals and university examinations.

A robust software solution cannot merely be a superficial web interface. It requires:
1. **Strong Domain Modeling:** Using Object-Oriented principles to represent real-world entities (Vehicles, Commuters, Routes, Trips, Bookings) with strong invariants and polymorphic behavior.
2. **ACID Relational Storage:** A normalized schema ensuring that two commuters concurrent on the web cannot double-book the same seat or corrupt capacity metrics.
3. **Decoupled Architecture:** Clean separation of presentation (Thymeleaf/Bootstrap), controllers (Spring MVC), business service layers, and data access layers (JDBC DAO / JPA Repository).

---

### 3. Problem Statement
Institutional transport operations encounter persistent problems:
- **Severe Route Congestion vs Underutilization:** Prime suburban corridors (e.g., Chennai GST Road, Pallavaram, Tambaram, Guindy) suffer acute passenger congestion while secondary routes run partially empty.
- **Inflexible Boarding Policies:** Students are restricted to single static home stops, unable to commute flexibly from libraries, internships, or peer study centers.
- **Midday Examination Transit Mismatch:** Semester examinations conclude at 11:30 AM or 2:30 PM, yet college buses traditionally depart only at 05:00 PM, stranding students on campus for hours.
- **Lack of Real-Time Seat Visibility:** Commuters arrive at pickup points without knowing if seats are available, risking overcapacity violations.
- **Overbooking in Disconnected Spreadsheets:** Manual pass issuing lacks concurrency controls, allowing duplicate seat allocations.

---

### 4. System Objectives & Scope
- **Develop a Single Integrated Java Codebase:** Eliminates disconnected front-end/back-end repositories by combining business logic, data access, and presentation into one cohesive project.
- **Demonstrate Practical Implementation of Core OOP Concepts:** Incorporate Encapsulation, Inheritance, Polymorphism, Abstraction, Packages, and Custom Exception Handling directly into domain logic.
- **Implement Robust DBMS Architecture:** Design a 13-table normalized schema with primary keys, foreign keys, cascading rules, and composite indexes.
- **Provide Direct JDBC Connectivity & CRUD Operations:** Implement raw Java JDBC DAOs demonstrating `Connection`, `PreparedStatement`, `ResultSet`, and ACID transactional integrity.
- **Enforce Business Constraints:** Ensure available seats equal confirmed database records (`total_seats - confirmed_count`), restrict duplicate active bookings, and enforce booking cutoff windows.

---

### 5. Core Object-Oriented Programming (OOP) Implementation

The project places core OOP principles at the center of its software architecture. All domain models and services are organized under `com.collegebus.oop.*`.

#### 5.1 Encapsulation
Encapsulation binds data and the methods manipulating that data together while hiding internal state from unauthorized external mutation.

**Implementation Details:**
- All entity fields are declared strictly `private` or `protected`.
- Mutators (`setters`) validate business domain invariants and throw custom `InvalidDataException` on invalid input.
- **Bus Capacity Guard:** In [`AbstractVehicle.java`](file:///c:/Users/SUBITSHA/OneDrive/Desktop/smtclgbus/src/main/java/com/collegebus/oop/model/AbstractVehicle.java), `setCapacity(int capacity)` guarantees seat capacity lies strictly between 1 and 100 seats:
  ```java
  public void setCapacity(int capacity) {
      if (capacity <= 0 || capacity > 100) {
          throw new InvalidDataException("capacity", "Bus passenger capacity must be between 1 and 100 seats");
      }
      this.capacity = capacity;
  }
  ```
- **Email Regex Guard:** In [`AbstractPerson.java`](file:///c:/Users/SUBITSHA/OneDrive/Desktop/smtclgbus/src/main/java/com/collegebus/oop/model/AbstractPerson.java), `setEmail(String email)` validates standard RFC email formatting using regular expressions.
- **Phone Privacy Masking:** The method `getMaskedPhone()` displays only the terminal 4 digits (e.g., `******3210`) preventing data exposure during public display.

#### 5.2 Inheritance
Inheritance enables code reuse and hierarchical domain specialization. The system contains two distinct inheritance hierarchies:

##### Hierarchy A: Vehicle & Fleet Hierarchy
```
AbstractVehicle (Abstract Base Class)
   ▲
   └── CollegeBus (Concrete Subclass - Base Transport Bus)
          ▲
          ├── AirConditionedBus (Specialized Subclass - Deluxe AC Bus)
          └── StandardCollegeBus (Specialized Subclass - Non-AC Bus)
```
- [`AbstractVehicle`](file:///c:/Users/SUBITSHA/OneDrive/Desktop/smtclgbus/src/main/java/com/collegebus/oop/model/AbstractVehicle.java): Encapsulates `vehicleId`, `registrationNumber`, `capacity`, and `fuelEfficiencyKmPerLitre`. Declares abstract methods `calculateOperatingCostPerKm()` and `getComfortMultiplier()`.
- [`CollegeBus`](file:///c:/Users/SUBITSHA/OneDrive/Desktop/smtclgbus/src/main/java/com/collegebus/oop/model/CollegeBus.java): Extends `AbstractVehicle` and implements `Bookable` and `FareCalculable`. Adds `busNumber`, `routeName`, and `bookedSeats`.
- [`AirConditionedBus`](file:///c:/Users/SUBITSHA/OneDrive/Desktop/smtclgbus/src/main/java/com/collegebus/oop/model/AirConditionedBus.java): Extends `CollegeBus`. Adds `targetTemperatureCelsius`, `wifiEnabled`, and overrides operating cost to incorporate HVAC compressor fuel overhead.
- [`StandardCollegeBus`](file:///c:/Users/SUBITSHA/OneDrive/Desktop/smtclgbus/src/main/java/com/collegebus/oop/model/StandardCollegeBus.java): Extends `CollegeBus`. Adds `emergencyExitCount` and standard diesel consumption profiles.

##### Hierarchy B: Person & Commuter Hierarchy
```
AbstractPerson (Abstract Base Class)
   ▲
   ├── StudentPassenger (Enrolled Student Commuter)
   ├── FacultyPassenger (Teaching Faculty Commuter)
   └── TransportStaff (Heavy Vehicle Driver / Transport Staff)
```
- [`AbstractPerson`](file:///c:/Users/SUBITSHA/OneDrive/Desktop/smtclgbus/src/main/java/com/collegebus/oop/model/AbstractPerson.java): Encapsulates commuter contact details and account status.
- [`StudentPassenger`](file:///c:/Users/SUBITSHA/OneDrive/Desktop/smtclgbus/src/main/java/com/collegebus/oop/model/StudentPassenger.java): Adds `rollNumber`, `department`, `academicYear`, `semester`, and restricts max active bookings to **1**.
- [`FacultyPassenger`](file:///c:/Users/SUBITSHA/OneDrive/Desktop/smtclgbus/src/main/java/com/collegebus/oop/model/FacultyPassenger.java): Adds `employeeId`, `designation`, and permits up to **2** concurrent bookings for academic supervision and exam duties.
- [`TransportStaff`](file:///c:/Users/SUBITSHA/OneDrive/Desktop/smtclgbus/src/main/java/com/collegebus/oop/model/TransportStaff.java): Adds `licenseNumber`, `experienceYears`, and sets booking limit to **0** (operations role).

#### 5.3 Polymorphism (Overloading & Overriding)
The project demonstrates both compile-time and runtime polymorphic mechanisms:

##### A. Compile-Time Polymorphism (Method Overloading)
Multiple methods share identical names with distinct parameter signatures within [`CollegeBus.java`](file:///c:/Users/SUBITSHA/OneDrive/Desktop/smtclgbus/src/main/java/com/collegebus/oop/model/CollegeBus.java) and [`BusAllocationManager.java`](file:///c:/Users/SUBITSHA/OneDrive/Desktop/smtclgbus/src/main/java/com/collegebus/oop/service/BusAllocationManager.java):

| Method Signature | Parameters | Description |
| :--- | :--- | :--- |
| `calculateFare(double distanceKm)` | `(double)` | Basic distance-based calculation: `distance * baseFare * comfortMultiplier`. |
| `calculateFare(double distanceKm, boolean peakHour)` | `(double, boolean)` | Adds 20% peak-hour traffic surcharge when `peakHour = true`. |
| `calculateFare(double distanceKm, boolean peakHour, boolean facultyConcession)` | `(double, boolean, boolean)` | Applies 30% academic concession discount for faculty journeys. |
| `allocateSeat(CollegeBus bus, AbstractPerson passenger)` | `(CollegeBus, AbstractPerson)` | Basic allocation using default terminal stops. |
| `allocateSeat(CollegeBus bus, AbstractPerson passenger, String pickup, String drop)` | `(CollegeBus, AbstractPerson, String, String)` | Custom pickup and drop-off allocation. |
| `allocateSeat(CollegeBus bus, AbstractPerson passenger, String pickup, String drop, boolean waitlist)` | `(CollegeBus, AbstractPerson, String, String, boolean)` | Full allocation supporting priority waitlist override. |

##### B. Runtime Polymorphism (Dynamic Method Dispatch / Method Overriding)
When invoking an abstract method on a base reference, the Java Virtual Machine (JVM) dynamically binds execution to the concrete runtime object's overridden method:
```java
List<AbstractVehicle> fleet = List.of(new StandardCollegeBus(...), new AirConditionedBus(...));
for (AbstractVehicle vehicle : fleet) {
    // Dynamic Method Dispatch: JVM calls the appropriate subclass method at runtime!
    double cost = vehicle.calculateOperatingCostPerKm();
    double comfort = vehicle.getComfortMultiplier();
}
```
- `StandardCollegeBus.calculateOperatingCostPerKm()` &rarr; returns basic diesel cost (~Rs. 19.79/km).
- `AirConditionedBus.calculateOperatingCostPerKm()` &rarr; returns fuel + HVAC surcharge (~Rs. 33.93/km).
- `AirConditionedBus.getComfortMultiplier()` &rarr; returns `1.35` (35% comfort multiplier).

#### 5.4 Abstraction (Abstract Classes & Interfaces)
Abstraction hides intricate implementation mechanics behind clean high-level contracts.

##### Abstract Classes:
- [`AbstractVehicle`](file:///c:/Users/SUBITSHA/OneDrive/Desktop/smtclgbus/src/main/java/com/collegebus/oop/model/AbstractVehicle.java): Cannot be instantiated directly (`new AbstractVehicle()` is forbidden). Forces all subclasses to implement `calculateOperatingCostPerKm()`, `getComfortMultiplier()`, and `getVehicleCategory()`.
- [`AbstractPerson`](file:///c:/Users/SUBITSHA/OneDrive/Desktop/smtclgbus/src/main/java/com/collegebus/oop/model/AbstractPerson.java): Forces concrete subclasses to define `getRoleTitle()`, `getMaxSimultaneousBookings()`, and `getIdentityBadge()`.

##### Interfaces:
- [`Bookable.java`](file:///c:/Users/SUBITSHA/OneDrive/Desktop/smtclgbus/src/main/java/com/collegebus/oop/interfaces/Bookable.java): Pure contract for capacity management:
  - `boolean hasAvailableSeats();`
  - `int getAvailableSeats();`
  - `boolean reserveSeat();`
  - `boolean releaseSeat();`
- [`FareCalculable.java`](file:///c:/Users/SUBITSHA/OneDrive/Desktop/smtclgbus/src/main/java/com/collegebus/oop/interfaces/FareCalculable.java): Contract defining overloaded fare calculation signatures.
- [`DatabaseOperations.java`](file:///c:/Users/SUBITSHA/OneDrive/Desktop/smtclgbus/src/main/java/com/collegebus/oop/interfaces/DatabaseOperations.java): Generic interface defining the DBMS CRUD contract:
  ```java
  public interface DatabaseOperations<T, ID> {
      T create(T entity) throws DatabaseOperationException;
      Optional<T> findById(ID id) throws DatabaseOperationException;
      List<T> findAll() throws DatabaseOperationException;
      boolean update(T entity) throws DatabaseOperationException;
      boolean deleteById(ID id) throws DatabaseOperationException;
      long count() throws DatabaseOperationException;
  }
  ```
- [`Displayable.java`](file:///c:/Users/SUBITSHA/OneDrive/Desktop/smtclgbus/src/main/java/com/collegebus/oop/interfaces/Displayable.java): Contract defining `String getSummaryDetails()`.

#### 5.5 Package Architecture
The codebase strictly adheres to standard Java packaging conventions to prevent namespace collisions and maintain modular boundaries:

```
src/main/java/com/collegebus/
├── SmartCollegeBusApplication.java   // Spring Boot Application Entry Point
├── config/                           // Security, Authentication, UserDetailsService
│   ├── CustomAuthenticationSuccessHandler.java
│   ├── CustomUserDetailsService.java
│   └── SecurityConfig.java
├── controller/                       // Spring MVC Presentation Layer
│   ├── AdminController.java
│   ├── BookingController.java
│   ├── ChatbotController.java
│   ├── HomeController.java
│   ├── OOPDemoController.java        // Dedicated OOP & DBMS Architecture UI
│   ├── StudentController.java
│   ├── TeacherController.java
│   └── TimetableController.java
├── dto/                              // Data Transfer Objects
│   ├── BookingRequestDto.java
│   ├── BusSearchDto.java
│   └── TripCardDto.java
├── entity/                           // JPA Relational Entity Models
│   ├── Booking.java
│   ├── Bus.java
│   ├── Route.java
│   ├── Trip.java
│   └── User.java
├── exception/                        // Web Exception Handlers
│   ├── BookingException.java
│   └── GlobalExceptionHandler.java
├── oop/                              // Dedicated Core OOP & Direct JDBC Package
│   ├── dao/                          // Direct java.sql JDBC Data Access Objects
│   │   ├── CollegeBusDBConnection.java
│   │   ├── JdbcBookingDao.java
│   │   └── JdbcBusDao.java
│   ├── exception/                    // Domain Custom Checked & Runtime Exceptions
│   │   ├── BookingCutoffException.java
│   │   ├── BusTransportationException.java
│   │   ├── DatabaseOperationException.java
│   │   ├── DuplicateBookingException.java
│   │   ├── InvalidDataException.java
│   │   └── SeatNotAvailableException.java
│   ├── interfaces/                   // Pure Functional Contracts & Interfaces
│   │   ├── Bookable.java
│   │   ├── DatabaseOperations.java
│   │   ├── Displayable.java
│   │   └── FareCalculable.java
│   ├── model/                        // Encapsulated Class Hierarchies
│   │   ├── AbstractPerson.java
│   │   ├── AbstractVehicle.java
│   │   ├── AirConditionedBus.java
│   │   ├── CollegeBus.java
│   │   ├── FacultyPassenger.java
│   │   ├── StandardCollegeBus.java
│   │   ├── StudentPassenger.java
│   │   └── TransportStaff.java
│   ├── runner/                       // Executable Console Demonstration
│   │   └── OOPAndDBMSDemonstrationRunner.java
│   └── service/                      // Business Allocation & Polymorphic Services
│       └── BusAllocationManager.java
├── repository/                       // Spring Data JPA ORM Repositories
│   ├── BookingRepository.java
│   ├── BusRepository.java
│   └── TripRepository.java
└── service/                          // Spring Service Interfaces & Implementations
    ├── BookingService.java
    └── impl/
        ├── BookingServiceImpl.java
        └── TripServiceImpl.java
```

#### 5.6 Custom Exception Handling & Resource Safety
The system demonstrates clean exception hierarchy and resource management:

```
java.lang.Throwable
   ▲
   ├── java.lang.Exception
   │      ▲
   │      └── BusTransportationException (Base Checked Exception)
   │             ▲
   │             ├── SeatNotAvailableException
   │             ├── DuplicateBookingException
   │             ├── BookingCutoffException
   │             └── DatabaseOperationException
   │
   └── java.lang.RuntimeException
          ▲
          └── InvalidDataException (Domain Invariant Violation)
```

**Try-Catch-Finally and Try-with-Resources:**
Every direct JDBC operation utilizes `try-with-resources` to ensure that `Connection`, `PreparedStatement`, and `ResultSet` are closed deterministically, preventing database connection pool exhaustion:
```java
try (Connection conn = CollegeBusDBConnection.getConnection();
     PreparedStatement pstmt = conn.prepareStatement(sql)) {
    pstmt.setLong(1, busId);
    try (ResultSet rs = pstmt.executeQuery()) {
        if (rs.next()) {
            return Optional.of(mapResultSetToBus(rs));
        }
    }
} catch (SQLException ex) {
    throw new DatabaseOperationException("DBMS Error: " + ex.getMessage(), sql, ex);
} finally {
    // Audit logs executed unconditionally
}
```

---

### 6. Database Management System (DBMS) Architecture

#### 6.1 Database Schema & Normalization
The database `CollegeBusDB` is designed adhering to Third Normal Form (3NF):
- **1NF (First Normal Form):** All column values are atomic; repeating groups are eliminated.
- **2NF (Second Normal Form):** Every non-key attribute is fully functionally dependent on the primary key. Junction tables (e.g., `route_stops`) eliminate partial dependencies.
- **3NF (Third Normal Form):** Transitive dependencies are removed. Driver details, stop localities, and vehicle capacities reside in their own master tables and are referenced via foreign keys.

#### 6.2 Relational Tables & Keys Breakdown
The schema contains **13 InnoDB relational tables**:

| Table Name | Primary Key | Foreign Keys & References | Purpose |
| :--- | :--- | :--- | :--- |
| `users` | `user_id` (BIGINT AUTO_INCREMENT) | None (`email` UNIQUE) | Central credential and authentication table. |
| `students` | `student_id` (BIGINT AUTO_INCREMENT) | `user_id` &rarr; `users(user_id)` ON DELETE CASCADE | 1-to-1 extension storing roll number, year, semester. |
| `teachers` | `teacher_id` (BIGINT AUTO_INCREMENT) | `user_id` &rarr; `users(user_id)` ON DELETE CASCADE | 1-to-1 extension storing employee ID and designation. |
| `buses` | `bus_id` (BIGINT AUTO_INCREMENT) | None (`bus_number` UNIQUE) | Fleet vehicle tracking, registration, and seating capacity. |
| `drivers` | `driver_id` (BIGINT AUTO_INCREMENT) | None (`license_number` UNIQUE) | Commercial driver profiles and phone contacts. |
| `routes` | `route_id` (BIGINT AUTO_INCREMENT) | None (`route_name` UNIQUE) | Transit corridors connecting suburbs to campus. |
| `bus_stops` | `stop_id` (BIGINT AUTO_INCREMENT) | None | Catalog of approved boarding stops in Chennai. |
| `route_stops` | `route_stop_id` (BIGINT AUTO_INCREMENT) | `route_id` &rarr; `routes`, `stop_id` &rarr; `bus_stops` | Junction table ordering stops by sequence number. |
| `trips` | `trip_id` (BIGINT AUTO_INCREMENT) | `bus_id` &rarr; `buses`, `route_id` &rarr; `routes`, `driver_id` &rarr; `drivers` | Daily scheduled transit journeys with departure slots. |
| `bookings` | `booking_id` (BIGINT AUTO_INCREMENT) | `trip_id` &rarr; `trips`, `user_id` &rarr; `users`, stops | Confirmed and cancelled passenger seat reservations. |
| `seat_requests` | `request_id` (BIGINT AUTO_INCREMENT) | `trip_id` &rarr; `trips`, `user_id` &rarr; `users` | Overflow waitlist requests when buses are full. |
| `academic_timetable` | `timetable_id` (BIGINT AUTO_INCREMENT) | None | Weekly subject and laboratory classroom hours. |
| `exam_timetable` | `exam_id` (BIGINT AUTO_INCREMENT) | None | University examination conclusion schedules. |

#### 6.3 Entity-Relationship (ER) Diagram
The Entity-Relationship model enforces referential integrity:
- **`users` (1) &mdash; (1) `students`**
- **`users` (1) &mdash; (1) `teachers`**
- **`users` (1) &mdash; (N) `bookings`**
- **`trips` (1) &mdash; (N) `bookings`**
- **`routes` (1) &mdash; (N) `route_stops` (N) &mdash; (1) `bus_stops`**
- **`buses` (1) &mdash; (N) `trips`**
- **`drivers` (1) &mdash; (N) `trips`**

An interactive visual diagram is available at [`database/ER_Diagram.html`](database/ER_Diagram.html) and high-resolution PNG at [`database/ER_Diagram.png`](database/ER_Diagram.png).

#### 6.4 Direct JDBC Database Connectivity
The project provides pure JDBC database management in [`CollegeBusDBConnection.java`](file:///c:/Users/SUBITSHA/OneDrive/Desktop/smtclgbus/src/main/java/com/collegebus/oop/dao/CollegeBusDBConnection.java).
- Loads official MySQL Driver: `com.mysql.cj.jdbc.Driver`.
- Establishes connection via `DriverManager.getConnection(url, user, pass)`.
- **Development fallback:** In the `dev` profile only, an in-memory H2 fallback supports offline academic demonstrations. Production requires explicit MySQL credentials and fails closed rather than switching to ephemeral storage.

#### 6.5 CRUD Operations (Create, Read, Update, Delete)
The class [`JdbcBusDao.java`](file:///c:/Users/SUBITSHA/OneDrive/Desktop/smtclgbus/src/main/java/com/collegebus/oop/dao/JdbcBusDao.java) implements all four CRUD operations using SQL `PreparedStatement`:

1. **CREATE (INSERT):**
   ```sql
   INSERT INTO buses (bus_number, registration_number, total_seats, bus_type, bus_status)
   VALUES (?, ?, ?, ?, ?)
   ```
2. **READ (SELECT BY ID & ALL):**
   ```sql
   SELECT bus_id, bus_number, registration_number, total_seats, bus_type, bus_status
   FROM buses WHERE bus_id = ?
   ```
3. **UPDATE:**
   ```sql
   UPDATE buses SET bus_number = ?, registration_number = ?, total_seats = ?, bus_type = ?, bus_status = ?
   WHERE bus_id = ?
   ```
4. **DELETE:**
   ```sql
   DELETE FROM buses WHERE bus_id = ?
   ```

#### 6.6 ACID Transactions & Concurrency Control
In [`JdbcBookingDao.java`](file:///c:/Users/SUBITSHA/OneDrive/Desktop/smtclgbus/src/main/java/com/collegebus/oop/dao/JdbcBookingDao.java), seat reservation enforces ACID transactions:
- **Atomicity:** `conn.setAutoCommit(false);` ensures all SQL inserts must succeed together. If any failure occurs, `conn.rollback();` restores prior state.
- **Consistency:** Foreign key referential constraints prevent orphaned bookings.
- **Isolation:** Database locks prevent phantom seat reads.
- **Durability:** Committed reservations persist permanently on disk.

---

### 7. Integration of OOP Concepts with DBMS Operations

A critical aspect of this project is the seamless mapping between Relational Database rows and Encapsulated OOP Domain Models (Object-Relational Mapping):

```
+------------------------------------+          +------------------------------------+
|       RELATIONAL TABLE ROW         |          |       ENCAPSULATED OOP OBJECT      |
|  Table: buses                      |          |  Class: AirConditionedBus          |
|------------------------------------|          |------------------------------------|
|  bus_id: 101                       | <======> |  vehicleId = 101L                  |
|  bus_number: 'BUS-101'             |          |  busNumber = 'BUS-101'             |
|  registration_number: 'TN-01-AB'   |          |  registrationNumber = 'TN-01-AB'   |
|  total_seats: 50                   |          |  capacity = 50                     |
|  bus_type: 'AC'                    |          |  getComfortMultiplier() -> 1.35    |
|  bus_status: 'ACTIVE'              |          |  status = 'ACTIVE'                 |
+------------------------------------+          +------------------------------------+
```

In `JdbcBusDao.mapResultSetToBus(ResultSet rs)`:
- Reads column `bus_type`.
- If `bus_type == 'AC'`, it instantiates an `AirConditionedBus`.
- If `bus_type == 'NON_AC'`, it instantiates a `StandardCollegeBus`.
- Polymorphic dynamic dispatch is enabled directly from database query results!

---

### 8. Full-Stack Web Application Modules

#### 8.1 Authentication & RBAC
- Role-Based Access Control powered by **Spring Security 6**.
- Pre-hashed BCrypt passwords with salts.
- Roles: `ROLE_STUDENT`, `ROLE_TEACHER`, `ROLE_ADMIN`.

#### 8.2 Date & Time Slot Booking Engine
- **Mandatory 3-Step Workflow:** Commuters select Travel Date &rarr; Departure Time Slot &rarr; Matching Bus.
- Calendar view blocks past dates.

#### 8.3 Real-Time Seat Calculation
- Prevents overbooking by querying actual confirmed database records:
  $$\text{Available Seats} = \text{total\_seats} - \text{confirmed\_bookings}$$
- Evaluated immediately inside database transaction to eliminate race conditions.

#### 8.4 Seat Request Waitlist System
- When a bus is full (0 available seats), commuters can submit a **Seat Request**.
- Transport administrators review pending requests on `/admin/seat-requests` and reallocate capacity safely.

#### 8.5 Academic & Exam Timetable Recommender
- Matches examination end times (e.g., 11:30 AM) with departure buses scheduled 15 to 90 minutes post-examination (e.g., 12:00 PM bus), surfacing 1-click booking shortcuts.

#### 8.6 Talk to Aadhi Transportation Assistant
- Interactive conversational assistant querying live MySQL tables for routes, Chennai localities (Pallavaram, Tambaram, Guindy, etc.), and seat counts.

#### 8.7 Admin Fleet & Analytics Suite
- Administrative dashboard with vehicle CRUD, route sequencing, driver licensing, and route congestion metrics.

---

### 9. Hardware & Software Requirements

#### Hardware Requirements:
- **Processor:** Dual Core 2.0 GHz or higher (Intel Core i3/i5/i7 or AMD Ryzen).
- **RAM:** Minimum 8 GB (16 GB recommended).
- **Hard Disk Space:** Minimum 5 GB free storage.
- **Client Display:** 1024x768 resolution minimum (Fully responsive on mobile).

#### Software Requirements:
- **Operating System:** Windows 10/11, Ubuntu Linux 20.04+, or macOS.
- **Java Development Kit (JDK):** JDK 17 LTS or JDK 21 LTS.
- **Database Engine:** MySQL Server 8.0+ or 5.7+ (InnoDB).
- **Database Administration Tool:** MySQL Workbench 8.0 CE.
- **IDE:** Eclipse IDE for Enterprise Java and Web Developers / IntelliJ IDEA / VS Code.
- **Build System:** Apache Maven 3.8+ (Maven Wrapper `mvnw` included).

---

### 10. Testing Methodology & Test Suite Execution

The application contains comprehensive unit and integration test suites executed with JUnit 5 and Mockito:

1. **`OOPConceptsTest.java` (8 Test Cases):**
   - Validates Encapsulation boundary checks and email regex validation.
   - Validates multi-level Inheritance on Vehicles and Persons.
   - Validates compile-time Method Overloading on `calculateFare`.
   - Validates runtime Dynamic Method Dispatch on fleet cost analytics.
   - Validates Abstraction on `Bookable` interface.
   - Validates Custom Exception handling (`SeatNotAvailableException` and `DuplicateBookingException`).
2. **`JdbcDatabaseCrudTest.java` (3 Test Cases):**
   - Validates raw JDBC Connection metadata.
   - Validates Create, Read, Update, and Delete operations on the `buses` table.
   - Validates ACID Transactional booking creation and rollback.
3. **`BookingServiceTest.java` (4 Test Cases):**
   - Tests capacity constraints, duplicate booking prevention, and transactional cancellation.
4. **`ChatbotServiceTest.java` (3 Test Cases):**
   - Validates locality queries, booking guidance, and alternative route suggestions.
5. **`UserServiceImplTest.java` (2 Test Cases):** Rejects privileged and unknown self-registration roles before persistence.
6. **`ProductionSecurityIntegrationTest.java` (4 Test Cases):** Checks public transit API access, CSRF bootstrap, admin authentication, and development-only JDBC demo access.
7. **`ProductionProfileSchemaValidationTest.java` (1 Test Case):** Boots the production profile against the MySQL 8 schema-only database provisioned by CI.
7. **`SmartCollegeBusApplicationTests.java` (1 Test Case):**
   - Verifies Spring Boot ApplicationContext initialization and entity mapping.

#### Test Execution Result:
The repository now contains 26 automated tests, including registration-role checks, Spring Security integration tests, and a production-profile startup test against MySQL 8. The current CI result must be checked on the exact release commit; this report does not claim that manual browser tests or production MySQL concurrency tests have been completed.

---

### 11. Project Evaluation & Viva-Voce Demonstration Script

During the project evaluation review, the project team can demonstrate compliance using the following structured script:

#### Demonstration Step 1: Standalone OOP & DBMS Console Runner
Open terminal in project directory and execute:
```bash
./mvnw test-compile
java -cp "target/classes;target/dependency/*" com.collegebus.oop.runner.OOPAndDBMSDemonstrationRunner
```
*(Or in Eclipse: Right-click `OOPAndDBMSDemonstrationRunner.java` &rarr; **Run As &rarr; Java Application**)*

**What to point out to examiners:**
1. **Encapsulation:** Point to the setter rejection of negative capacity (-10) and invalid email syntax.
2. **Inheritance:** Show `AbstractVehicle` &rarr; `CollegeBus` &rarr; `AirConditionedBus` and `AbstractPerson` &rarr; `StudentPassenger`.
3. **Polymorphism:** Show the 3 overloaded `calculateFare` outputs and dynamic method dispatch computing operating costs.
4. **Abstraction:** Show the `Bookable` contract reserving and releasing seats.
5. **Exception Handling:** Show the custom `SeatNotAvailableException` caught inside `try-catch-finally`.
6. **DBMS Direct JDBC:** Show the live JDBC `INSERT`, `SELECT`, `UPDATE`, `DELETE`, and row count queries on `CollegeBusDB`.

#### Demonstration Step 2: Interactive Web Architecture Portal
1. Start the application in local development mode:
   ```bash
   SPRING_PROFILES_ACTIVE=dev ./mvnw spring-boot:run
   ```
2. Open browser at `http://localhost:8080/oop-demo`.
3. Click the yellow **"Run Live OOP & JDBC CRUD Test"** button.
4. Show examiners the real-time execution report with live SQL statements executed against the database.

#### Demonstration Step 3: MySQL Workbench Verification
1. Open MySQL Workbench and inspect `CollegeBusDB`.
2. Show all 13 tables, primary keys, foreign keys, and indexes.
3. Show that booking a seat in the web app immediately increments confirmed records and decrements available seats in SQL.

---

### 12. Conclusion
The **Smart College Bus Allocation System** represents a complete, academically rigorous engineering solution that bridges theoretical computer science concepts with modern enterprise web development. By giving equal importance to **Object-Oriented Programming principles** (Encapsulation, Inheritance, Polymorphism, Abstraction, Packages, and Custom Exception Handling) and **Relational Database Design** (Normalization, Referential Integrity, JDBC CRUD, and ACID Transactions), the project satisfies all university requirements and provides a demonstrable platform for higher education campus transit management.
