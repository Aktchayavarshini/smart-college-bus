# Deployment Configuration

## Runtime

- Java 17
- Spring Boot 3.2.5
- MySQL 8+
- Start command: `java -jar target/*.jar`
- Build: `./mvnw --batch-mode --no-transfer-progress clean verify`

The existing app is a Spring Boot + Thymeleaf application. Vercel does not host this conventional long-running Spring Boot server. Deploy the backend to a Java-capable host and point a future Next.js frontend at its HTTPS API origin.

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
2. Review `database/CollegeBusDB.sql` before execution. It contains destructive `DROP TABLE` statements and must only be used against an empty, newly provisioned database.
3. Apply the schema and seed data to that empty database using the documented setup process.
4. Deploy with `SPRING_PROFILES_ACTIVE=prod`.
5. Production Hibernate mode is `validate`; schema changes must be applied deliberately before deploying code that depends on them.

Do not point the destructive SQL script at a database containing real user or booking data.

## Browser session and CSRF

Production session cookies are Secure, HttpOnly, and SameSite=None so a separately hosted browser frontend can send the session cross-site. The browser must use `credentials: "include"`, and the backend must allow only the exact `FRONTEND_ORIGIN`.

Spring Security uses a readable CSRF cookie and the `X-XSRF-TOKEN` header. The frontend should first call `GET /api/v1/csrf` with credentials, then send the returned header name/token on unsafe requests. Booking mutations are not yet exposed under `/api/v1`; this is groundwork, not a claim that the Next.js auth flow is complete.

## CI

GitHub Actions workflow `.github/workflows/java-ci.yml` runs Java 17 Maven `clean verify` on pushes and pull requests targeting `main` or `rebuild/production-upgrade`. A green workflow run is required before calling the backend verified.
