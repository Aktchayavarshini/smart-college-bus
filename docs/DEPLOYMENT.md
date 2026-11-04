# Deployment Configuration

## Runtime

- Java 17
- Spring Boot 3.2.5
- MySQL 8+
- Start command: `java -jar target/*.jar`
- Build: `./mvnw --batch-mode --no-transfer-progress clean verify`

The existing app is a Spring Boot + Thymeleaf application. Vercel does not host this conventional long-running Spring Boot server. Deploy the backend to a Java-capable host and point a future Next.js frontend at its HTTPS API origin.

The application defaults to the `prod` profile when no profile is selected. Local development must explicitly set `SPRING_PROFILES_ACTIVE=dev`; automated tests use the isolated `test` profile. This fail-closed default prevents an accidentally misconfigured deployment from starting with the demo H2 database and sample accounts.

## Container build

A multi-stage Java 17 Docker image is provided. It runs as an unprivileged UID and packages the application after running the Maven verification suite.

```bash
docker build -t smart-college-bus:release .
docker run --rm -p 8080:8080 \
  -e SPRING_PROFILES_ACTIVE=prod \
  -e DB_URL='jdbc:mysql://HOST:3306/CollegeBusDB?serverTimezone=UTC&sslMode=REQUIRED' \
  -e DB_USERNAME='APP_USER' \
  -e DB_PASSWORD='INJECT_FROM_SECRET_MANAGER' \
  -e FRONTEND_ORIGIN='https://YOUR_FRONTEND_ORIGIN' \
  smart-college-bus:release
```

Do not put real passwords in shell history or deployment manifests; configure them through the hosting provider's secret manager. The command above is a configuration example, not a deployed environment.

## Required production environment variables

| Variable | Required value |
|---|---|
| `SPRING_PROFILES_ACTIVE` | `prod` |
| `DB_URL` | Full JDBC URL, e.g. `jdbc:mysql://HOST:3306/CollegeBusDB?serverTimezone=UTC&sslMode=REQUIRED` |
| `DB_USERNAME` | Database application user |
| `DB_PASSWORD` | Database application user's password |
| `FRONTEND_ORIGIN` | Exact HTTPS origin of the browser frontend, no trailing slash |

Do not commit production credentials. Use a least-privilege database account and managed secrets in the hosting provider.

## Database provisioning

1. Provision a new MySQL 8 database.
2. Review `database/CollegeBusDB-production-schema.sql` before execution. It is non-destructive and creates missing tables only; it does not alter existing tables or records.
3. Apply this production schema-only script. It creates the 13 tables without inserting demo users, passwords, bookings, drivers, or sample trips. Existing tables are left untouched; review any schema changes separately before applying them. Do not use `database/CollegeBusDB.sql` in production; that file is a destructive academic/demo dataset.
4. Deploy with `SPRING_PROFILES_ACTIVE=prod`.
5. Production Hibernate mode is `validate`; schema changes must be applied deliberately before deploying code that depends on them.

Do not point the destructive SQL script at a database containing real user or booking data.

## Production data and administrator provisioning

The demo `DataInitializer` is restricted to the `dev` profile. Production startup never creates sample students, staff, buses, trips, or a default administrator. Provision real operational data through a reviewed, access-controlled database import or the authenticated admin workflows.

Create the first administrator through a controlled one-time provisioning procedure: generate a BCrypt password hash using the application's configured `BCryptPasswordEncoder`, insert the administrator row with `role='ADMIN'` and `account_status='ACTIVE'`, then securely remove the temporary provisioning access. Never reuse the development demo credentials in production. Do not expose the JDBC/OOP CRUD demonstration endpoints in production; that controller is development-profile only.

Production JDBC demonstration access fails closed: it requires explicit `DB_URL`, `DB_USERNAME`, and `DB_PASSWORD` and will not silently switch to an ephemeral H2 database if MySQL is unavailable.

## Browser session and CSRF

Production session cookies are Secure, HttpOnly, and SameSite=None so a separately hosted browser frontend can send the session cross-site. The browser must use `credentials: "include"`, and the backend must allow only the exact `FRONTEND_ORIGIN`.

Spring Security uses a readable CSRF cookie and the `X-XSRF-TOKEN` header. The frontend should first call `GET /api/v1/csrf` with credentials, then send the returned header name/token on unsafe requests. Booking mutations are not yet exposed under `/api/v1`; this is groundwork, not a claim that the Next.js auth flow is complete.

## CI

GitHub Actions workflow `.github/workflows/java-ci.yml` runs Java 17 Maven `clean verify` on pushes and pull requests targeting `main` or `rebuild/production-upgrade`. A green workflow run is required before calling the backend verified.
