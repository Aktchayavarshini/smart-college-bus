# SMART COLLEGE BUS ALLOCATION SYSTEM
## Comprehensive Project Engineering & Academic Submission Report

---

### Table of Contents
1. Abstract
2. Introduction
3. Problem Statement
4. Existing System Analysis
5. Proposed System Architecture
6. System Objectives
7. Hardware Requirements
8. Software Requirements
9. Technology Stack
10. System Architecture & Component Interaction
11. Module Descriptions
12. Database Design & Relational Schema
13. Entity Relationship (ER) Diagram
14. Functional Requirements
15. Non-Functional Requirements
16. Testing Methodology & Verification
17. Results & Key Accomplishments
18. System Limitations
19. Future Enhancements
20. Conclusion

---

### 1. Abstract
The **Smart College Bus Allocation System** is an enterprise-grade full-stack web application designed to automate and optimize student and faculty transportation across higher education institutions. Built on Java 17, Spring Boot 3, Spring Data JPA, Spring Security, and MySQL, the platform replaces outdated manual passes and rigid bus schedules with dynamic seat allocation, flexible boarding stop selection, examination-based return bus recommendations, and predictive passenger-demand analytics. The application includes **Talk to Aadhi**, a rule-driven assistant that queries live database tables to help commuters find buses, evaluate seat availability, and explore connecting routes.

---

### 2. Introduction
In modern engineering and arts colleges, campus transportation logistics represent a critical operational challenge. Thousands of commuters travel daily between suburban hubs and the campus. Conventional transit management relies heavily on static bus routes and manual bookkeeping, which fail during peak traffic, exam dismissals, and irregular student laboratory hours. The Smart College Bus Allocation System provides a unified, responsive portal catering to four user categories: Day Scholars, Hostel Residents, Teaching Faculty, and Transport Administrators.

---

### 3. Problem Statement
Institutional transportation departments currently struggle with:
- **Vehicle Overcrowding:** Key routes suffer severe passenger congestion while secondary routes run partially empty.
- **Inflexible Boarding Policies:** Students are forced into permanent pickup stops with no flexibility to board from project centers, internships, or alternative suburban locations.
- **Midday Examination Transit Void:** University examinations conclude at 11:30 AM or 2:30 PM, yet institutions run return buses only at 05:00 PM, creating hours of idle waiting time.
- **Absence of Real-Time Availability:** Commuters board buses without prior knowledge of seat availability, leading to standing hazards.
- **Lack of Operational Intelligence:** Transport managers lack empirical occupancy metrics to justify allocating additional buses or adjusting departure schedules.

---

### 4. Existing System Analysis
In existing legacy systems:
- Physical paper passes or plastic ID cards are inspected manually at bus gates.
- Route stops cannot be selected or modified dynamically.
- Overbooking occurs regularly because booking counts are tracked on paper logs or decoupled spreadsheets.
- No integrated communication exists between the examination controller's timetable and the transport dispatch schedule.

---

### 5. Proposed System Architecture
The proposed system implements a centralized single-tier architecture combining Spring MVC, Spring Data JPA, and Thymeleaf:
- **Mandatory 3-Step Booking:** Date Selection &rarr; Preferred Departure Slot &rarr; Matching Fleet Selection.
- **ACID Transaction Guarantee:** High-concurrency seat reservation protected by serializable isolation and capacity validations.
- **Automated Exam Matching:** Computes the delta between exam end times and return bus schedules, surfacing 1-click booking recommendations.
- **Overflow Management:** A dedicated Seat Request queue allows passengers to request seats on full buses, which administrators review and approve safely.
- **Talk to Aadhi:** Embedded assistant querying actual SQL tables for real-time locality information (e.g. Pallavaram, Tambaram, Guindy).

---

### 6. System Objectives
1. Provide a single integrated codebase connecting UI, backend business logic, and MySQL database.
2. Enforce role-based access control (`STUDENT`, `TEACHER`, `ADMIN`) with BCrypt encryption.
3. Compute available seats dynamically using verified confirmed records (`total_seats - confirmed_count`).
4. Prevent duplicate bookings for the same user on the same date and travel slot.
5. Provide administrative analytics on route occupancy, congestion alerts, and capacity recommendations.

---

### 7. Hardware Requirements
- **Server / Development Host:** Dual Core 2.0 GHz or higher (Intel Core i5/i7 or AMD Ryzen recommended).
- **RAM:** Minimum 8 GB (16 GB recommended for concurrent Spring Boot and MySQL Workbench execution).
- **Disk Storage:** Minimum 10 GB free hard disk space.
- **Network Interface:** Standard Ethernet / Wi-Fi adapter.
- **Client Device:** Any standard laptop, desktop, or mobile device with a modern web browser.

---

### 8. Software Requirements
- **Operating System:** Windows 10/11, Ubuntu Linux 20.04+, or macOS.
- **Java Runtime / SDK:** Java Development Kit (JDK) 17 LTS or 21 LTS.
- **Database Server:** MySQL Server 8.0+ or 5.7+ (InnoDB).
- **Database Tools:** MySQL Workbench 8.0 CE.
- **Integrated Development Environment (IDE):** Eclipse IDE for Enterprise Java and Web Developers.
- **Build Automation:** Apache Maven 3.8+.
- **Web Browser:** Google Chrome, Mozilla Firefox, or Microsoft Edge.

---

### 9. Technology Stack
- **Backend Framework:** Spring Boot 3.2.5, Spring MVC, Spring Data JPA (Hibernate 6).
- **Security:** Spring Security 6 with BCrypt password hashing.
- **Template Engine:** Thymeleaf 3.1 with Spring Security Extras.
- **Database Connector:** MySQL Connector/J (`com.mysql:mysql-connector-j`).
- **Frontend UI:** HTML5, CSS3, JavaScript (ES6+), Bootstrap 5.3, FontAwesome 6.
- **Testing:** JUnit 5, Mockito, Spring Security Test, H2 In-Memory Database.

---

### 10. System Architecture & Component Interaction
The system is built on a 4-tier layered architecture:
1. **Presentation Layer:** Thymeleaf templates structured with reusable fragments (`header.html`, `footer.html`, `alerts.html`, `aadhi-widget.html`).
2. **Controller Layer:** Spring MVC REST and View controllers managing request dispatching, input validation, and HTTP session lifecycles.
3. **Service Layer:** Transactional business logic executing capacity verifications, cancellation policies, and timetable matching algorithms.
4. **Data Access Layer:** Spring Data JPA repositories communicating with MySQL via JDBC connection pooling (HikariCP).

---

### 11. Module Descriptions

#### A. User Authentication & Authorization Module
Manages self-registration for students (capturing roll number, department, year, semester, student type, and hostel block) and faculty (employee ID, designation, department). Public administrator registration is restricted; admin credentials are pre-seeded securely.

#### B. Date & Time Slot Selection Module
Presents a monthly calendar view restricting past date selections. Users select their desired departure slot (6:00 AM, 7:00 AM, 8:00 AM, 9:00 AM, 12:00 PM, 3:00 PM, 5:00 PM). Matching buses are displayed only after date and time selection is verified.

#### C. Bus Search & Sequence Routing Module
Filters active trips based on route stops where pickup sequence strictly precedes dropoff sequence. Displays bus numbers, registration plates, available seats, and driver contact details.

#### D. Booking & Cancellation Engine
Provides concurrent-safe booking with transactional rollback. If a user modifies their booking, the previous reservation is released only if the replacement booking succeeds. Cancellations immediately restore fleet seat capacity.

#### E. Seat Request Waitlist Module
Enables commuters to request seats on full buses. Transport managers review pending requests and approve seats only if verified cancellations or capacity adjustments permit.

#### F. Examination Timetable Recommender
Analyzes exam schedules, retrieves exam conclusion times (e.g. 11:30 AM), and automatically queries trips departing within 15 to 90 minutes post-examination to present 1-click booking recommendations.

#### G. Administrative Operations & Fleet Analytics
Centralized dashboard for vehicle registration, stop sequencing, driver licensing, and demand analysis (high-demand route flags, congestion alerts, and bus size recommendations).

#### H. Talk to Aadhi Virtual Assistant
Embedded AI assistant interacting with live MySQL tables to answer questions regarding Pallavaram buses, Tambaram routes, remaining seats, and alternative journeys.

---

### 12. Database Design & Relational Schema
The database `CollegeBusDB` contains 13 relational tables enforcing referential integrity with foreign key cascading and InnoDB constraints:
- `users`: Core credentials and roles.
- `students`: 1-to-1 extension of user record.
- `teachers`: 1-to-1 extension of user record.
- `buses`: Fleet registration and capacity.
- `drivers`: License details and duty availability.
- `routes`: Named transit corridors.
- `bus_stops`: Master Chennai locality catalog.
- `route_stops`: Ordered junction table with sequences.
- `trips`: Daily scheduled journeys.
- `bookings`: Active and cancelled passenger reservations.
- `seat_requests`: Overflow waitlist requests.
- `academic_timetable`: Weekly course schedules.
- `exam_timetable`: University exam schedules.

---

### 13. Entity Relationship (ER) Diagram
An interactive graphical schema is provided in `database/ER_Diagram.html` and a high-resolution diagram in `database/ER_Diagram.png`.
- **users (1) &mdash; (1) students**
- **users (1) &mdash; (1) teachers**
- **users (1) &mdash; (N) bookings**
- **trips (1) &mdash; (N) bookings**
- **routes (1) &mdash; (N) route_stops &mdash; (1) bus_stops**
- **buses (1) &mdash; (N) trips**
- **drivers (1) &mdash; (N) trips**

---

### 14. Functional Requirements
- FR-1: Users can authenticate via secure email and BCrypt hashed passwords.
- FR-2: Students and faculty can select custom boarding and drop-off stops for every trip.
- FR-3: Seat reservations must update live capacity immediately without browser caching errors.
- FR-4: Double-booking for the same user on the same travel slot must be rejected.
- FR-5: Booking past cutoff time must be blocked.
- FR-6: Full buses must present alternative departure timings and seat request options.
- FR-7: Examination ending times must recommend appropriate return buses.

---

### 15. Non-Functional Requirements
- **Performance:** Bus search and seat allocation response times under 200 ms.
- **Reliability:** ACID-compliant MySQL transactions preventing phantom reads and overbooking.
- **Security:** Spring Security CSRF token validation, input sanitization preventing SQL injection, and encrypted session cookies.
- **Usability:** Responsive UI across mobile phones, tablets, and desktop workstations adhering to institutional navy blue theme.
- **Maintainability:** Layered architectural pattern (Controller &rarr; Service &rarr; Repository &rarr; Entity).

---

### 16. Testing Methodology & Verification
Testing encompassed unit tests, mock integration tests, and UI verification:
- **Unit Testing:** Verified `BookingService` for capacity boundary limits, duplicate checks, and cancellation releases.
- **NLP Assistant Testing:** Verified `ChatbotService` for Chennai corridor queries (Pallavaram, Tambaram, Guindy).
- **Data Persistence Testing:** Verified H2 in-memory schema generation and JPA entity mappings.

---

### 17. Results & Key Accomplishments
- Implemented a complete, college-submission-ready web application in ONE integrated project.
- Created all 24 required pages, fragments, and responsive navigation layouts.
- Provided a full SQL script (`database/CollegeBusDB.sql`) with Chennai locations and pre-seeded test accounts.
- Successfully verified that seat availability accurately mirrors confirmed bookings in MySQL.

---

### 18. System Limitations
- Live GPS bus tracking and hardware telematics are intentionally excluded as per academic specification.
- SMS gateway integration requires commercial telecom third-party credentials.

---

### 19. Future Enhancements
- Integration of RFID / NFC student bus passes for tap-and-go bus boarding.
- Machine learning predictive models to forecast seasonal seat demand during rainy seasons and festivals.
- Native mobile applications for Android and iOS using Flutter.

---

### 20. Conclusion
The **Smart College Bus Allocation System** delivers a robust, secure, and user-centric platform that modernizes higher education transportation. By eliminating manual paperwork, preventing overcrowding through real-time database seat validation, and integrating academic exam schedules with transit recommendations, the system significantly improves commuter convenience and operational efficiency for college transport departments.
