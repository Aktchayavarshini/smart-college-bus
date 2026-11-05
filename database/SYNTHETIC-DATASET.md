# Synthetic campus dataset

The optional synthetic campus seed is maintained separately from the production schema:

- Schema: `database/CollegeBusDB-production-schema.sql`
- Synthetic seed: `database/CollegeBusDB-synthetic-campus-seed.sql`

Run the schema first, then the seed against `CollegeBusDB` using a MySQL 8.0+ client. The seed is idempotent and uses stable synthetic identifiers:

- 350 student user/profile records
- 50 teacher user/profile records
- Seven sample departments
- Deterministic roll numbers and employee IDs

**Safety:** all generated user accounts are marked `INACTIVE` and use a non-login marker in the password column. They are intended for database relationship, listing, pagination, filtering and admin-workflow testing, not authentication. Do not activate them or replace the marker with a shared password. The three separately provisioned evaluator accounts remain distinct.

The Java CI workflow provisions this dataset in its disposable MySQL service and asserts exact profile counts. The production database is not changed automatically by this repository file; deployment requires a deliberate, reviewed seed execution.
