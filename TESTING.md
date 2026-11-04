# SMART COLLEGE BUS ALLOCATION SYSTEM — TEST STRATEGY

## 1. Automated test coverage

The repository currently contains 25 JUnit 5 tests across the following suites:

| Test suite | Tests | Coverage |
|---|---:|---|
| `SmartCollegeBusApplicationTests` | 1 | Spring application context and JPA startup under the isolated `test` profile |
| `BookingServiceTest` | 4 | Successful booking, capacity rejection, duplicate booking rejection, and cancellation |
| `ChatbotServiceTest` | 3 | Greeting, booking guidance, and locality search |
| `OOPConceptsTest` | 8 | Encapsulation, inheritance, polymorphism, abstraction, and exception behavior |
| `JdbcDatabaseCrudTest` | 3 | JDBC connection, CRUD lifecycle, and transaction behavior |
| `UserServiceImplTest` | 2 | Rejects privileged and unknown self-registration roles before persistence |
| `ProductionSecurityIntegrationTest` | 4 | Public read API, CSRF bootstrap, admin authentication boundary, and development-only JDBC demo boundary |
| **Total** | **27** | **Unit, Spring security integration, and MySQL production-schema startup coverage** |

Run the same verification used by CI:

```bash
bash ./mvnw --batch-mode --no-transfer-progress clean verify
```

GitHub Actions runs Java verification and the Next.js production build separately. Check the latest runs on `rebuild/production-upgrade`; older successful runs do not certify later commits. A green build confirms compilation and the automated tests above, not a complete production deployment.

## 2. Concurrency and transactional controls

`BookingServiceImpl.bookSeat()` and cancellation acquire a pessimistic write lock on the trip row inside the transaction. Booking also uses serializable isolation, checks active duplicate bookings, validates trip resources and stop order, and calculates capacity from confirmed database records.

**Important test limitation:** the current automated booking tests use Mockito and do not create simultaneous transactions against a real MySQL server. Before production traffic, run a MySQL integration/load test with concurrent booking and cancellation requests for the final available seat, then verify that confirmed bookings never exceed bus capacity.

## 3. Manual end-to-end test plan

The following workflows still require browser testing against a provisioned database and deployed backend. They are not marked as verified by the current CI suite.

| Area | Required check | Status |
|---|---|---|
| Registration | Student and teacher registration, duplicate identities, invalid role and password validation | Not run against production-like MySQL |
| Authentication | Login, logout, inactive account rejection, and role-specific redirects | Not run end-to-end |
| Trip discovery | Date, time slot, active stops, route direction, and inactive fleet filtering | API tests partial; browser test pending |
| Booking | Reserve, duplicate prevention, cutoff, capacity, cancel, and modify | Unit tests; MySQL concurrency test pending |
| Seat requests | Submit, approve, reject, and concurrent approval | Manual integration test pending |
| Student/teacher | Dashboards, timetables, exam recommendations, profile and booking history | Manual browser test pending |
| Admin | Fleet, routes, stops, drivers, trips, booking audit and reports | Manual browser test pending |
| Responsive UI | Mobile/tablet/desktop layouts and keyboard/accessibility checks | Manual browser test pending |
| Production database | Apply schema-only SQL, verify Hibernate validation, and test backup/restore | Pending infrastructure |

## 4. Production release gates

- Latest Java CI and frontend CI must pass on the exact release commit.
- Run integration tests against MySQL 8, not only H2.
- Run concurrent booking/cancellation tests against MySQL.
- Complete browser end-to-end testing for every role and critical workflow.
- Provision the production database and Java backend host; set secrets outside source control.
- Verify HTTPS, session cookies, CORS origin, CSRF behavior, database backups, monitoring, and restore procedure.
- Confirm administrator provisioning and remove all development/demo accounts.

Until these gates are completed, treat the branch as a hardened release candidate, not a live production deployment.
