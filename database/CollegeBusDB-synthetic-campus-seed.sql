-- SYNTHETIC CAMPUS DATASET (MySQL 8.0+)
-- Adds exactly 350 synthetic student profiles and 50 synthetic teacher profiles.
-- Idempotent: stable email/roll/employee identifiers + INSERT IGNORE.
-- All accounts are INACTIVE and carry a non-login marker, not a usable password.
-- These are fictional records; no real student/faculty personal data is included.
-- Run only after database/CollegeBusDB-production-schema.sql.
USE CollegeBusDB;

-- 350 synthetic student user accounts.
INSERT IGNORE INTO users (full_name, email, password, phone_number, role, account_status)
WITH RECURSIVE seq AS (
    SELECT 1 AS n
    UNION ALL SELECT n + 1 FROM seq WHERE n < 350
)
SELECT
    CONCAT('Synthetic Student ', LPAD(n, 3, '0')),
    CONCAT('student', LPAD(n, 3, '0'), '@synthetic.collegebus.test'),
    '!SYNTHETIC_ACCOUNT_NO_LOGIN!',
    CONCAT('900', LPAD(n, 7, '0')),
    'STUDENT',
    'INACTIVE'
FROM seq;

-- Student profiles, linked by deterministic synthetic email.
INSERT IGNORE INTO students (user_id, roll_number, department, academic_year, semester, student_type, hostel_name)
SELECT
    u.user_id,
    CONCAT('SYN-2026-', LPAD(n, 4, '0')),
    CASE MOD(n - 1, 7)
        WHEN 0 THEN 'Computer Science and Engineering'
        WHEN 1 THEN 'Information Technology'
        WHEN 2 THEN 'Electronics and Communication Engineering'
        WHEN 3 THEN 'Electrical and Electronics Engineering'
        WHEN 4 THEN 'Mechanical Engineering'
        WHEN 5 THEN 'Civil Engineering'
        ELSE 'Artificial Intelligence and Data Science'
    END,
    1 + MOD(n - 1, 4),
    1 + 2 * MOD(n - 1, 4),
    CASE WHEN MOD(n, 5) = 0 THEN 'HOSTEL' ELSE 'DAY_SCHOLAR' END,
    CASE WHEN MOD(n, 5) = 0 THEN CONCAT('Synthetic Hostel ', 1 + MOD(n, 3)) ELSE NULL END
FROM (
    WITH RECURSIVE seq AS (
        SELECT 1 AS n
        UNION ALL SELECT n + 1 FROM seq WHERE n < 350
    )
    SELECT n FROM seq
) numbers
JOIN users u ON u.email = CONCAT('student', LPAD(numbers.n, 3, '0'), '@synthetic.collegebus.test')
WHERE u.role = 'STUDENT';

-- 50 synthetic teacher user accounts.
INSERT IGNORE INTO users (full_name, email, password, phone_number, role, account_status)
WITH RECURSIVE seq AS (
    SELECT 1 AS n
    UNION ALL SELECT n + 1 FROM seq WHERE n < 50
)
SELECT
    CONCAT('Synthetic Faculty ', LPAD(n, 2, '0')),
    CONCAT('teacher', LPAD(n, 2, '0'), '@synthetic.collegebus.test'),
    '!SYNTHETIC_ACCOUNT_NO_LOGIN!',
    CONCAT('910', LPAD(n, 7, '0')),
    'TEACHER',
    'INACTIVE'
FROM seq;

-- Teacher profiles, linked by deterministic synthetic email.
INSERT IGNORE INTO teachers (user_id, employee_id, department, designation)
SELECT
    u.user_id,
    CONCAT('SYN-FAC-', LPAD(n, 4, '0')),
    CASE MOD(n - 1, 7)
        WHEN 0 THEN 'Computer Science and Engineering'
        WHEN 1 THEN 'Information Technology'
        WHEN 2 THEN 'Electronics and Communication Engineering'
        WHEN 3 THEN 'Electrical and Electronics Engineering'
        WHEN 4 THEN 'Mechanical Engineering'
        WHEN 5 THEN 'Civil Engineering'
        ELSE 'Artificial Intelligence and Data Science'
    END,
    CASE MOD(n - 1, 4)
        WHEN 0 THEN 'Assistant Professor'
        WHEN 1 THEN 'Associate Professor'
        WHEN 2 THEN 'Professor'
        ELSE 'Lecturer'
    END
FROM (
    WITH RECURSIVE seq AS (
        SELECT 1 AS n
        UNION ALL SELECT n + 1 FROM seq WHERE n < 50
    )
    SELECT n FROM seq
) numbers
JOIN users u ON u.email = CONCAT('teacher', LPAD(numbers.n, 2, '0'), '@synthetic.collegebus.test')
WHERE u.role = 'TEACHER';

-- Fail loudly if the expected profile totals are not present.
SELECT
    (SELECT COUNT(*) FROM students s JOIN users u ON u.user_id = s.user_id
      WHERE u.email LIKE 'student___@synthetic.collegebus.test') AS synthetic_students,
    (SELECT COUNT(*) FROM teachers t JOIN users u ON u.user_id = t.user_id
      WHERE u.email LIKE 'teacher__@synthetic.collegebus.test') AS synthetic_teachers;
