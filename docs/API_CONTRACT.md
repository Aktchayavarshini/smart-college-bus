# Frontend API Contract (v1)

Base URL: `{BACKEND_ORIGIN}/api/v1`

This is an incremental integration contract. The existing Spring MVC/Thymeleaf application remains the current complete application. The v1 endpoints below provide read-only transit discovery for a future Next.js client; they do not replace existing booking, registration, profile, or administration workflows.

## Public read endpoints

### `GET /stops`

Returns active pickup/drop-off stops.

```json
[
  {
    "id": 1,
    "name": "Central",
    "area": "Chennai",
    "description": "..."
  }
]
```

### `GET /trips`

Search scheduled trips for a date.

Query parameters:
- `travelDate` (required): ISO date, `YYYY-MM-DD`
- `preferredTimeSlot` (optional): existing application slot value; defaults to `ALL`
- `pickupStopId` (optional)
- `dropoffStopId` (optional)

Returns the existing `TripCardDto` fields: trip and bus identifiers, route, travel date, departure/arrival, driver display details, seat counts, pickup/drop-off names, and estimated travel duration.

Past travel dates return HTTP 400.

Example:
`GET /api/v1/trips?travelDate=2026-11-10&preferredTimeSlot=08:00&pickupStopId=1&dropoffStopId=4`

### `GET /trips/{tripId}`

Returns a single trip card. Optional query parameters: `pickupStopId`, `dropoffStopId`.

### `GET /csrf`

Returns a CSRF token for browser clients using the Spring session.

```json
{
  "headerName": "X-XSRF-TOKEN",
  "token": "..."
}
```

The endpoint is intended as a bootstrap for a future same-session API. The frontend must send credentials and return the token in the named request header for unsafe HTTP methods.

## Authentication boundary

The v1 query endpoints are public. Existing booking, cancellation, modification, registration, timetable and admin flows remain on the existing MVC routes and Spring Security form-login session. No public booking mutation endpoint has been added. Do not expose a booking API until the frontend login/session flow, CSRF handling, role checks, and response DTOs have been integration-tested.

## Cross-origin browser requests

Set `FRONTEND_ORIGIN` to the exact deployed frontend origin, for example `https://your-app.vercel.app` (no trailing slash). The backend enables credentialed CORS for that single origin on `/api/**`. Never use wildcard origins with credentials.
