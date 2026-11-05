# Synthetic transport dataset

This test fixture is based on the Sriperumbudur, Tamil Nadu corridor because no institution name or campus address was supplied. The college record is deliberately named **Synthetic Engineering College** and must be replaced with the actual institution before production use.

## Included

- One synthetic college/campus record.
- 146 synthetic feeder routes, each with pickup and campus drop-off sequence.
- 50 buses assigned to the shared synthetic main route.
- 146 feeder buses (one per feeder route) plus 50 main-route buses.
- 196 synthetic driver records.
- 30 days of scheduled trips generated from the date the seed is executed:
  - Every feeder route: 08:00, 15:00 and 17:00.
  - Each of the 50 main-route buses: 10:00 and 12:00.
- Locality names around Sriperumbudur, Poonamallee, Porur, Kundrathur, Tambaram and the surrounding corridor.

The route patterns, fleet registrations, driver records and timetable are synthetic demonstration data. They are not official MTC/TNSTC routes or verified college transport schedules.

## Apply

Run `database/CollegeBusDB-synthetic-transport-seed.sql` after the production schema and student/faculty seed. It is designed to be repeatable and does not delete existing records.

The public frontend requires a travel date, pickup stop and drop-off stop. Search uses the existing stops/trips API filters. Pickup and drop-off must differ; the backend should return only trips whose route includes both stops in the correct sequence.

## Before production

Replace the placeholder college with the actual college name/address, validate every locality and stop with transport administration, assign real fleet/driver details only through authorized operational records, and confirm departure times. Do not present synthetic schedules as actual services.
