USE master;
IF NOT EXISTS (SELECT 1 FROM sys.databases WHERE name = 'StudentPerformanceDWH')
BEGIN
    EXEC('CREATE DATABASE StudentPerformanceDWH;');
END
GO

USE StudentPerformanceDWH;
GO

IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = 'bronze')
    EXEC('CREATE SCHEMA bronze');
GO
IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = 'silver')
    EXEC('CREATE SCHEMA silver');
GO
IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = 'gold')
    EXEC('CREATE SCHEMA gold');
GO

-- bronze tables creation

IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = 'students' AND schema_id = schema_id('bronze'))
BEGIN
    CREATE TABLE bronze.students(
    student_id VARCHAR(255),
    university VARCHAR(255),
    faculty VARCHAR(255),
    department VARCHAR(255),
    age VARCHAR(255),
    gender VARCHAR(255),
    residency VARCHAR(255),
    entry_year VARCHAR(255),
    current_level VARCHAR(255),
    enrollment_status VARCHAR(255),
    admission_route VARCHAR(255),
    prior_gpa VARCHAR(255),
    prior_failed_courses VARCHAR(255),
    prior_attendance_pct VARCHAR(255),
    employment_status VARCHAR(255),
    usual_study_hours_per_week VARCHAR(255),
    sleep_hours_per_night VARCHAR(255),
    commute_minutes_one_way VARCHAR(255),
    internet_access VARCHAR(255),
    housing_type VARCHAR(255),
    scholarship_status VARCHAR(255),
    financial_strain_self_report VARCHAR(255),
    preferred_support VARCHAR(255));
END

GO

IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name ='assessment' AND schema_id = schema_id('bronze'))
BEGIN
    CREATE TABLE bronze.assessment(
    assessment_id VARCHAR(255),
    enrollment_id VARCHAR(255),
    assessment_name VARCHAR(255),
    assessment_type VARCHAR(255),
    week_due VARCHAR(255),
    due_date VARCHAR(255),
    weight VARCHAR(255),
    max_score VARCHAR(255),
    score VARCHAR(255),
    submission_status VARCHAR(255),
    late_submission VARCHAR(255));
END

GO

IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = 'attendance' AND schema_id = schema_id('bronze'))
BEGIN
    CREATE TABLE bronze.attendance(
    attendance_record_id VARCHAR(255),
    enrollment_id VARCHAR(255),
    student_id VARCHAR(255),
    course_id VARCHAR(255),
    week VARCHAR(255),
    session_number VARCHAR(255),
    class_date VARCHAR(255),
    attendance_status VARCHAR(255));
END

GO

IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = 'course' AND schema_id = schema_id('bronze'))
BEGIN
    CREATE TABLE bronze.course(
    course_id VARCHAR(255),
    department VARCHAR(255),
    course_name VARCHAR(255),
    course_type VARCHAR(255),
    credit_hours VARCHAR(255),
    difficulty_level VARCHAR(255),
    delivery_mode VARCHAR(255));
END

GO

IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = 'enrollment' AND schema_id = schema_id('bronze'))
BEGIN
    CREATE TABLE bronze.enrollment(
    enrollment_id VARCHAR(255),
    student_id VARCHAR(255),
    course_id VARCHAR(255),
    level_at_enrollment VARCHAR(255),
    credit_hours VARCHAR(255),
    registration_date VARCHAR(255),
    withdrawn VARCHAR(255));
END

GO

IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = 'final_results' AND schema_id = schema_id('bronze'))
BEGIN
    CREATE TABLE bronze.final_results(
    enrollment_id VARCHAR(255),
    student_id VARCHAR(255),
    course_id VARCHAR(255),
    final_score VARCHAR(255),
    passed VARCHAR(255),
    final_grade_band VARCHAR(255),
    at_risk_final_outcome VARCHAR(255),
    outcome_available_date VARCHAR(255));
END

GO

IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = 'lms_activity' AND schema_id = schema_id('bronze'))
BEGIN
    CREATE TABLE bronze.lms_activity(
    lms_activity_id VARCHAR(255),
    student_id VARCHAR(255),
    enrollment_id VARCHAR(255),
    course_id VARCHAR(255),
    week VARCHAR(255),
    login_count VARCHAR(255),
    resource_views VARCHAR(255),
    forum_posts VARCHAR(255),
    video_minutes VARCHAR(255),
    last_activity_days_ago VARCHAR(255));
END

GO

IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = 'student_support' AND schema_id = schema_id('bronze'))
BEGIN
    CREATE TABLE bronze.student_support(
    support_event_id VARCHAR(255),
    student_id VARCHAR(255),
    enrollment_id VARCHAR(255),
    support_type VARCHAR(255),
    event_week VARCHAR(255),
    participated VARCHAR(255),
    follow_up_completed VARCHAR(255));
END

GO

IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = 'weekly_snapshots' AND schema_id = schema_id('bronze'))
BEGIN
    CREATE TABLE bronze.weekly_snapshots(
    snapshot_id VARCHAR(255),
    enrollment_id VARCHAR(255),
    student_id VARCHAR(255),
    course_id VARCHAR(255),
    snapshot_week VARCHAR(255),
    snapshot_date VARCHAR(255),
    attendance_pct_to_date VARCHAR(255),
    absences_to_date VARCHAR(255),
    lms_events_this_week VARCHAR(255),
    lms_events_rolling_3_weeks VARCHAR(255),
    assignments_due_to_date VARCHAR(255),
    assignments_submitted_to_date VARCHAR(255),
    late_submissions_to_date VARCHAR(255),
    assessment_average_available_to_date VARCHAR(255),
    prior_gpa VARCHAR(255),
    prior_failed_courses VARCHAR(255),
    usual_study_hours_per_week VARCHAR(255),
    sleep_hours_per_night VARCHAR(255),
    employment_status VARCHAR(255),
    commute_minutes_one_way VARCHAR(255),
    internet_access VARCHAR(255),
    financial_strain_self_report VARCHAR(255));
END

GO

TRUNCATE TABLE bronze.students;
BULK INSERT bronze.students
FROM 'E:\DEPI\Final_Project\student_performance_data\student_performance_data\students.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIELDQUOTE = '"' ,
    CODEPAGE = '65001'
);

GO

TRUNCATE TABLE bronze.assessment;
BULK INSERT bronze.assessment
FROM 'E:\DEPI\Final_Project\student_performance_data\student_performance_data\assessments.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIELDQUOTE = '"' ,
    CODEPAGE = '65001'
);

GO

TRUNCATE TABLE bronze.attendance;
BULK INSERT bronze.attendance
FROM 'E:\DEPI\Final_Project\student_performance_data\student_performance_data\attendance.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIELDQUOTE = '"' ,
    CODEPAGE = '65001'
);

GO

TRUNCATE TABLE bronze.course;
BULK INSERT bronze.course
FROM 'E:\DEPI\Final_Project\student_performance_data\student_performance_data\courses.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIELDQUOTE = '"' ,
    CODEPAGE = '65001'
);

GO

TRUNCATE TABLE bronze.enrollment;
BULK INSERT bronze.enrollment
FROM 'E:\DEPI\Final_Project\student_performance_data\student_performance_data\enrollments.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIELDQUOTE = '"' ,
    CODEPAGE = '65001'
);

GO

TRUNCATE TABLE bronze.final_results;
BULK INSERT bronze.final_results
FROM 'E:\DEPI\Final_Project\student_performance_data\student_performance_data\final_results.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIELDQUOTE = '"' ,
    CODEPAGE = '65001'
);

GO

TRUNCATE TABLE bronze.lms_activity;
BULK INSERT bronze.lms_activity
FROM 'E:\DEPI\Final_Project\student_performance_data\student_performance_data\lms_activity.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIELDQUOTE = '"' ,
    CODEPAGE = '65001'
);

GO

TRUNCATE TABLE bronze.student_support;
BULK INSERT bronze.student_support
FROM 'E:\DEPI\Final_Project\student_performance_data\student_performance_data\student_support.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIELDQUOTE = '"' ,
    CODEPAGE = '65001'
);

GO

TRUNCATE TABLE bronze.weekly_snapshots;
BULK INSERT bronze.weekly_snapshots
FROM 'E:\DEPI\Final_Project\student_performance_data\student_performance_data\weekly_snapshots.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIELDQUOTE = '"' ,
    CODEPAGE = '65001'
);

GO


--==================================================
-- silver tables creation
--==================================================


-- silver.student

IF NOT EXISTS (
    SELECT 1
    FROM sys.tables
    WHERE name = 'student'
      AND schema_id = SCHEMA_ID('silver')
)
BEGIN
    CREATE TABLE silver.student (
        student_id VARCHAR(50) UNIQUE,
        university VARCHAR(100),
        faculty VARCHAR(100),
        department VARCHAR(100),
        age INT,
        gender VARCHAR(20),
        residency VARCHAR(100),
        entry_year INT,
        current_level VARCHAR(50),
        enrollment_status VARCHAR(50),
        admission_route VARCHAR(50),
        prior_gpa DECIMAL(4,2),
        prior_failed_courses INT,
        prior_attendance_pct DECIMAL(5,2),
        employment_status VARCHAR(50),
        usual_study_hours_per_week DECIMAL(5,2),
        sleep_hours_per_night DECIMAL(4,2),
        commute_minutes_one_way INT,
        internet_access VARCHAR(50),
        housing_type VARCHAR(50),
        scholarship_status VARCHAR(50),
        financial_strain_self_report VARCHAR(50),
        preferred_support VARCHAR(100)
    );
END;
GO

-- Reload Silver from Bronze
TRUNCATE TABLE silver.student;

;WITH cleaned AS (
    SELECT
        NULLIF(LTRIM(RTRIM(student_id)), '') AS student_id,
        LTRIM(RTRIM(university)) AS university,
        LTRIM(RTRIM(faculty)) AS faculty,
        LTRIM(RTRIM(department)) AS department,
        TRY_CAST(age AS INT) AS age,
        LTRIM(RTRIM(gender)) AS gender,
        LTRIM(RTRIM(residency)) AS residency,
        TRY_CAST(entry_year AS INT) AS entry_year,
        LTRIM(RTRIM(current_level)) AS current_level,
        LTRIM(RTRIM(enrollment_status)) AS enrollment_status,
        LTRIM(RTRIM(admission_route)) AS admission_route,
        TRY_CAST(prior_gpa AS DECIMAL(4,2)) AS prior_gpa,
        TRY_CAST(prior_failed_courses AS INT)
            AS prior_failed_courses,
        TRY_CAST(prior_attendance_pct AS DECIMAL(5,2))
            AS prior_attendance_pct,

        CASE
            WHEN LOWER(LTRIM(RTRIM(employment_status)))
                IN ('part time', 'part-time')
                THEN 'Part-time'
            WHEN LOWER(LTRIM(RTRIM(employment_status)))
                IN ('full time', 'full-time')
                THEN 'Full-time'
            WHEN LOWER(LTRIM(RTRIM(employment_status)))
                = 'not employed'
                THEN 'Not employed'
            ELSE LTRIM(RTRIM(employment_status))
        END AS employment_status,

        TRY_CAST(usual_study_hours_per_week AS DECIMAL(5,2))
            AS usual_study_hours_per_week,
        TRY_CAST(sleep_hours_per_night AS DECIMAL(4,2))
            AS sleep_hours_per_night,
        TRY_CAST(commute_minutes_one_way AS INT)
            AS commute_minutes_one_way,
        LTRIM(RTRIM(internet_access)) AS internet_access,
        LTRIM(RTRIM(housing_type)) AS housing_type,
        LTRIM(RTRIM(scholarship_status)) AS scholarship_status,
        LTRIM(RTRIM(financial_strain_self_report))
            AS financial_strain_self_report,
        LTRIM(RTRIM(preferred_support)) AS preferred_support
    FROM bronze.students
),

validated AS (
    SELECT
        student_id,
        university,
        faculty,
        department,

        CASE
             WHEN age BETWEEN 18 AND 50 THEN age 
          ELSE NULL
       END AS age,

        gender,
        residency,

        CASE
            WHEN entry_year BETWEEN 2017 AND 2026
                THEN entry_year
            ELSE NULL
        END AS entry_year,

        current_level,
        enrollment_status,
        admission_route,

        CASE
            WHEN prior_gpa BETWEEN 0 AND 4
                THEN prior_gpa
            ELSE NULL
        END AS prior_gpa,

        CASE
            WHEN prior_failed_courses >= 0
                THEN prior_failed_courses
            ELSE NULL
        END AS prior_failed_courses,

        CASE
            WHEN prior_attendance_pct BETWEEN 0 AND 100
                THEN prior_attendance_pct
            ELSE NULL
        END AS prior_attendance_pct,

        employment_status,

        CASE
            WHEN usual_study_hours_per_week >= 0
                THEN usual_study_hours_per_week
            ELSE NULL
        END AS usual_study_hours_per_week,

        CASE
            WHEN sleep_hours_per_night BETWEEN 0 AND 24
                THEN sleep_hours_per_night
            ELSE NULL
        END AS sleep_hours_per_night,

        CASE
            WHEN commute_minutes_one_way >= 0
                THEN commute_minutes_one_way
            ELSE NULL
        END AS commute_minutes_one_way,

        internet_access,
        housing_type,
        scholarship_status,
        financial_strain_self_report,
        preferred_support

    FROM cleaned
    WHERE student_id IS NOT NULL
),

-- Handle NULLs left after validation
imputed AS (
    SELECT
        student_id,
        university,
        faculty,
        department,
        age,
        gender,
        residency,
        entry_year,
        current_level,
        enrollment_status,
        admission_route,

        -- prior_gpa: fill NULL with department median, fallback to overall median
        CAST(
            COALESCE(prior_gpa, dept_median_gpa, overall_median_gpa)
            AS DECIMAL(4,2)
        ) AS prior_gpa,

        prior_failed_courses,
        prior_attendance_pct,
        employment_status,
        usual_study_hours_per_week,
        sleep_hours_per_night,
        commute_minutes_one_way,

        -- internet_access: fill NULL/empty with 'Unknown'
        COALESCE(NULLIF(internet_access, ''), 'Unknown') AS internet_access,

        housing_type,
        scholarship_status,
        financial_strain_self_report,
        preferred_support
    FROM (
        SELECT
            v.*,
            PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY v.prior_gpa)
                OVER (PARTITION BY v.department) AS dept_median_gpa,
            PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY v.prior_gpa)
                OVER () AS overall_median_gpa
        FROM validated AS v
    ) AS x
),

-- Remove exact duplicate records
ranked AS (
    SELECT *,
        ROW_NUMBER() OVER (
            PARTITION BY
                student_id,
                university,
                faculty,
                department,
                age,
                gender,
                residency,
                entry_year,
                current_level,
                enrollment_status,
                admission_route,
                prior_gpa,
                prior_failed_courses,
                prior_attendance_pct,
                employment_status,
                usual_study_hours_per_week,
                sleep_hours_per_night,
                commute_minutes_one_way,
                internet_access,
                housing_type,
                scholarship_status,
                financial_strain_self_report,
                preferred_support
            ORDER BY student_id
        ) AS rn
    FROM imputed
),

-- Keep one copy of each exact record
deduplicated AS (
    SELECT *
    FROM ranked
    WHERE rn = 1
)

INSERT INTO silver.student (
    student_id,
    university,
    faculty,
    department,
    age,
    gender,
    residency,
    entry_year,
    current_level,
    enrollment_status,
    admission_route,
    prior_gpa,
    prior_failed_courses,
    prior_attendance_pct,
    employment_status,
    usual_study_hours_per_week,
    sleep_hours_per_night,
    commute_minutes_one_way,
    internet_access,
    housing_type,
    scholarship_status,
    financial_strain_self_report,
    preferred_support
)
SELECT
    student_id,
    university,
    faculty,
    department,
    age,
    gender,
    residency,
    entry_year,
    current_level,
    enrollment_status,
    admission_route,
    prior_gpa,
    prior_failed_courses,
    prior_attendance_pct,
    employment_status,
    usual_study_hours_per_week,
    sleep_hours_per_night,
    commute_minutes_one_way,
    internet_access,
    housing_type,
    scholarship_status,
    financial_strain_self_report,
    preferred_support
FROM deduplicated;
GO


-- silver.assessment

IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = 'assessment' AND schema_id = schema_id('silver'))
BEGIN
    CREATE TABLE silver.assessment (
        assessment_id VARCHAR(50) UNIQUE,
        enrollment_id VARCHAR(50),
        assessment_name VARCHAR(150),
        assessment_type VARCHAR(50),
        week_due INT,
        due_date DATE,
        weight DECIMAL(5,2),
        max_score DECIMAL(7,2),
        score DECIMAL(7,2),
        submission_status VARCHAR(50),
        late_submission BIT
    );
END
GO

TRUNCATE TABLE silver.assessment;

;WITH cleaned AS (
    SELECT
        NULLIF(LTRIM(RTRIM(assessment_id)), '') AS assessment_id,
        NULLIF(LTRIM(RTRIM(enrollment_id)), '') AS enrollment_id,
        NULLIF(LTRIM(RTRIM(assessment_name)), '') AS assessment_name,

        CASE
            WHEN LOWER(LTRIM(RTRIM(assessment_type))) = 'quiz'
                THEN 'Quiz'
            WHEN LOWER(LTRIM(RTRIM(assessment_type))) = 'assignment'
                THEN 'Assignment'
            WHEN LOWER(LTRIM(RTRIM(assessment_type))) = 'exam'
                THEN 'Exam'
            WHEN LOWER(LTRIM(RTRIM(assessment_type))) = 'project'
                THEN 'Project'
            ELSE NULLIF(LTRIM(RTRIM(assessment_type)), '')
        END AS assessment_type,

        TRY_CAST(week_due AS INT) AS week_due,

        COALESCE(
            TRY_CONVERT(DATE, NULLIF(LTRIM(RTRIM(due_date)), ''), 23),
            TRY_CONVERT(DATE, NULLIF(LTRIM(RTRIM(due_date)), ''), 103)
        ) AS due_date,

        TRY_CAST(weight AS DECIMAL(5,2)) AS weight,
        TRY_CAST(max_score AS DECIMAL(7,2)) AS max_score,
        TRY_CAST(NULLIF(LTRIM(RTRIM(score)), '') AS DECIMAL(7,2)) AS score,

        CASE
            WHEN LOWER(LTRIM(RTRIM(submission_status))) = 'missing'
                THEN 'Missing'
            WHEN LOWER(LTRIM(RTRIM(submission_status))) = 'submitted'
                THEN 'Submitted'
            ELSE NULLIF(LTRIM(RTRIM(submission_status)), '')
        END AS submission_status,

        CASE
            WHEN LOWER(LTRIM(RTRIM(late_submission))) IN ('true', '1', 'yes')
                THEN CAST(1 AS BIT)
            WHEN LOWER(LTRIM(RTRIM(late_submission))) IN ('false', '0', 'no')
                THEN CAST(0 AS BIT)
            ELSE NULL
        END AS late_submission

    FROM bronze.assessment
),

validated AS (
    SELECT
        assessment_id,
        enrollment_id,
        assessment_name,
        assessment_type,

        CASE
            WHEN week_due BETWEEN 1 AND 52 THEN week_due
            ELSE NULL
        END AS week_due,

        due_date,

        CASE
            WHEN weight BETWEEN 0 AND 1 THEN weight
            ELSE NULL
        END AS weight,

        CASE
            WHEN max_score > 0 THEN max_score
            ELSE NULL
        END AS max_score,

        CASE
            WHEN score >= 0 AND score <= max_score THEN score
            ELSE NULL
        END AS score,

        submission_status,
        late_submission
    FROM cleaned
    WHERE assessment_id IS NOT NULL
),

-- Handle NULL scores left after validation
-- Missing   -> 0
-- Submitted -> average score ratio of the same assessment_type (fallback: overall), scaled to the row's max_score
imputed AS (
    SELECT
        assessment_id,
        enrollment_id,
        assessment_name,
        assessment_type,
        week_due,
        due_date,
        weight,
        max_score,

        CAST(
            CASE
                WHEN submission_status = 'Missing'
                    THEN 0
                WHEN score IS NOT NULL
                    THEN score
                WHEN submission_status = 'Submitted'
                    THEN ROUND(
                        COALESCE(type_avg_ratio, overall_avg_ratio) * max_score,
                        2
                    )
                ELSE NULL
            END
            AS DECIMAL(7,2)
        ) AS score,

        submission_status,
        late_submission
    FROM (
        SELECT
            v.*,
            AVG(CASE
                    WHEN v.submission_status = 'Submitted'
                     AND v.score IS NOT NULL
                     AND v.max_score IS NOT NULL
                        THEN CAST(v.score AS FLOAT) / CAST(v.max_score AS FLOAT)
                END) OVER (PARTITION BY v.assessment_type) AS type_avg_ratio,
            AVG(CASE
                    WHEN v.submission_status = 'Submitted'
                     AND v.score IS NOT NULL
                     AND v.max_score IS NOT NULL
                        THEN CAST(v.score AS FLOAT) / CAST(v.max_score AS FLOAT)
                END) OVER () AS overall_avg_ratio
        FROM validated AS v
    ) AS x
),

ranked AS (
    SELECT *,
        ROW_NUMBER() OVER (
            PARTITION BY
                assessment_id, enrollment_id, assessment_name,
                assessment_type, week_due, due_date, weight,
                max_score, score, submission_status, late_submission
            ORDER BY assessment_id
        ) AS rn
    FROM imputed
),

deduplicated AS (
    SELECT *
    FROM ranked
    WHERE rn = 1
)

INSERT INTO silver.assessment (
    assessment_id, enrollment_id, assessment_name, assessment_type,
    week_due, due_date, weight, max_score, score,
    submission_status, late_submission
)
SELECT
    assessment_id, enrollment_id, assessment_name, assessment_type,
    week_due, due_date, weight, max_score, score,
    submission_status, late_submission
FROM deduplicated;
GO


-- silver.attendance

IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = 'attendance' AND schema_id = schema_id('silver'))
BEGIN
    CREATE TABLE silver.attendance (
        attendance_record_id VARCHAR(50) UNIQUE,
        enrollment_id VARCHAR(50),
        student_id VARCHAR(50),
        course_id VARCHAR(50),
        week INT,
        session_number INT,
        class_date DATE,
        attendance_status VARCHAR(50)
    );
END
GO

TRUNCATE TABLE silver.attendance;

;WITH cleaned AS (
    SELECT
        NULLIF(LTRIM(RTRIM(attendance_record_id)), '') AS attendance_record_id,
        NULLIF(LTRIM(RTRIM(enrollment_id)), '') AS enrollment_id,
        NULLIF(LTRIM(RTRIM(student_id)), '') AS student_id,
        NULLIF(LTRIM(RTRIM(course_id)), '') AS course_id,
        TRY_CAST(week AS INT) AS week,
        TRY_CAST(session_number AS INT) AS session_number,

        COALESCE(
            TRY_CONVERT(DATE, NULLIF(LTRIM(RTRIM(class_date)), ''), 23),
            TRY_CONVERT(DATE, NULLIF(LTRIM(RTRIM(class_date)), ''), 103)
        ) AS class_date,

        CASE
            WHEN LOWER(LTRIM(RTRIM(attendance_status))) = 'present'
                THEN 'Present'
            WHEN LOWER(LTRIM(RTRIM(attendance_status))) = 'absent'
                THEN 'Absent'
            ELSE NULLIF(LTRIM(RTRIM(attendance_status)), '')
        END AS attendance_status

    FROM bronze.attendance
),

validated AS (
    SELECT
        attendance_record_id,
        enrollment_id,
        student_id,
        course_id,

        CASE
            WHEN week BETWEEN 1 AND 12 THEN week
            ELSE NULL
        END AS week,

        CASE
            WHEN session_number BETWEEN 1 AND 2 THEN session_number
            ELSE NULL
        END AS session_number,

        class_date,
        attendance_status
    FROM cleaned
    WHERE attendance_record_id IS NOT NULL
),

ranked AS (
    SELECT *,
        ROW_NUMBER() OVER (
            PARTITION BY
                attendance_record_id, enrollment_id, student_id,
                course_id, week, session_number, class_date,
                attendance_status
            ORDER BY attendance_record_id
        ) AS rn
    FROM validated
),

deduplicated AS (
    SELECT *
    FROM ranked
    WHERE rn = 1
)

INSERT INTO silver.attendance (
    attendance_record_id, enrollment_id, student_id, course_id,
    week, session_number, class_date, attendance_status
)
SELECT
    attendance_record_id, enrollment_id, student_id, course_id,
    week, session_number, class_date, attendance_status
FROM deduplicated;
GO


-- silver.course

IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = 'course' AND schema_id = schema_id('silver'))
BEGIN
    CREATE TABLE silver.course (
        course_id VARCHAR(50) UNIQUE,
        department VARCHAR(100),
        course_name VARCHAR(150),
        course_type VARCHAR(50),
        credit_hours INT,
        difficulty_level INT,
        delivery_mode VARCHAR(50)
    );
END
GO

TRUNCATE TABLE silver.course;

;WITH cleaned AS (
    SELECT
        NULLIF(LTRIM(RTRIM(course_id)), '') AS course_id,
        NULLIF(LTRIM(RTRIM(department)), '') AS department,
        NULLIF(LTRIM(RTRIM(course_name)), '') AS course_name,

        CASE
            WHEN LOWER(LTRIM(RTRIM(course_type))) = 'core'
                THEN 'Core'
            WHEN LOWER(LTRIM(RTRIM(course_type))) = 'elective'
                THEN 'Elective'
            WHEN LOWER(LTRIM(RTRIM(course_type))) = 'practical'
                THEN 'Practical'
            ELSE NULLIF(LTRIM(RTRIM(course_type)), '')
        END AS course_type,

        TRY_CAST(credit_hours AS INT) AS credit_hours,
        TRY_CAST(difficulty_level AS INT) AS difficulty_level,

        CASE
            WHEN LOWER(LTRIM(RTRIM(delivery_mode))) = 'in-person'
                THEN 'In-person'
            WHEN LOWER(LTRIM(RTRIM(delivery_mode))) = 'online'
                THEN 'Online'
            WHEN LOWER(LTRIM(RTRIM(delivery_mode))) = 'hybrid'
                THEN 'Hybrid'
            ELSE NULLIF(LTRIM(RTRIM(delivery_mode)), '')
        END AS delivery_mode

    FROM bronze.course
),

validated AS (
    SELECT
        course_id,
        department,
        course_name,
        course_type,

        CASE
            WHEN credit_hours BETWEEN 1 AND 6
                THEN credit_hours
            ELSE NULL
        END AS credit_hours,

        CASE
            WHEN difficulty_level BETWEEN 1 AND 5
                THEN difficulty_level
            ELSE NULL
        END AS difficulty_level,

        delivery_mode
    FROM cleaned
    WHERE course_id IS NOT NULL
),

ranked AS (
    SELECT *,
        ROW_NUMBER() OVER (
            PARTITION BY
                course_id, department, course_name, course_type,
                credit_hours, difficulty_level, delivery_mode
            ORDER BY course_id
        ) AS rn
    FROM validated
),

deduplicated AS (
    SELECT *
    FROM ranked
    WHERE rn = 1
)

INSERT INTO silver.course (
    course_id, department, course_name, course_type,
    credit_hours, difficulty_level, delivery_mode
)
SELECT
    course_id, department, course_name, course_type,
    credit_hours, difficulty_level, delivery_mode
FROM deduplicated;
GO


-- silver.enrollment

IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = 'enrollment' AND schema_id = schema_id('silver'))
BEGIN
    CREATE TABLE silver.enrollment (
        enrollment_id VARCHAR(50) UNIQUE,
        student_id VARCHAR(50),
        course_id VARCHAR(50),
        level_at_enrollment INT,
        credit_hours INT,
        registration_date DATE,
        withdrawn BIT
    );
END
GO

TRUNCATE TABLE silver.enrollment;

;WITH cleaned AS (
    SELECT
        NULLIF(LTRIM(RTRIM(enrollment_id)), '') AS enrollment_id,
        NULLIF(LTRIM(RTRIM(student_id)), '') AS student_id,
        NULLIF(LTRIM(RTRIM(course_id)), '') AS course_id,
        TRY_CAST(level_at_enrollment AS INT) AS level_at_enrollment,
        TRY_CAST(credit_hours AS INT) AS credit_hours,

        COALESCE(
            TRY_CONVERT(DATE, NULLIF(LTRIM(RTRIM(registration_date)), ''), 23),
            TRY_CONVERT(DATE, NULLIF(LTRIM(RTRIM(registration_date)), ''), 103)
        ) AS registration_date,

        CASE
            WHEN LOWER(LTRIM(RTRIM(withdrawn))) IN ('true', '1', 'yes')
                THEN CAST(1 AS BIT)
            WHEN LOWER(LTRIM(RTRIM(withdrawn))) IN ('false', '0', 'no')
                THEN CAST(0 AS BIT)
            ELSE NULL
        END AS withdrawn

    FROM bronze.enrollment
),

validated AS (
    SELECT
        enrollment_id,
        student_id,
        course_id,

        CASE
            WHEN level_at_enrollment BETWEEN 1 AND 4
                THEN level_at_enrollment
            ELSE NULL
        END AS level_at_enrollment,

        CASE
            WHEN credit_hours BETWEEN 1 AND 6
                THEN credit_hours
            ELSE NULL
        END AS credit_hours,

        registration_date,
        withdrawn
    FROM cleaned
    WHERE enrollment_id IS NOT NULL
),

ranked AS (
    SELECT *,
        ROW_NUMBER() OVER (
            PARTITION BY
                enrollment_id, student_id, course_id,
                level_at_enrollment, credit_hours,
                registration_date, withdrawn
            ORDER BY enrollment_id
        ) AS rn
    FROM validated
),

deduplicated AS (
    SELECT *
    FROM ranked
    WHERE rn = 1
)

INSERT INTO silver.enrollment (
    enrollment_id, student_id, course_id,
    level_at_enrollment, credit_hours, registration_date, withdrawn
)
SELECT
    enrollment_id, student_id, course_id,
    level_at_enrollment, credit_hours, registration_date, withdrawn
FROM deduplicated;
GO

-- silver.final_result

IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = 'final_result' AND schema_id = schema_id('silver'))
BEGIN
    CREATE TABLE silver.final_result (
        enrollment_id VARCHAR(50) UNIQUE,
        student_id VARCHAR(50),
        course_id VARCHAR(50),
        final_score DECIMAL(5,2),
        passed BIT,
        final_grade_band VARCHAR(10),
        at_risk_final_outcome BIT,
        outcome_available_date DATE
    );
END
GO

TRUNCATE TABLE silver.final_result;

;WITH cleaned AS (
    SELECT
        NULLIF(LTRIM(RTRIM(enrollment_id)), '') AS enrollment_id,
        NULLIF(LTRIM(RTRIM(student_id)), '') AS student_id,
        NULLIF(LTRIM(RTRIM(course_id)), '') AS course_id,
        TRY_CAST(final_score AS DECIMAL(5,2)) AS final_score,

        CASE
            WHEN LOWER(LTRIM(RTRIM(passed))) IN ('true', '1', 'yes')
                THEN CAST(1 AS BIT)
            WHEN LOWER(LTRIM(RTRIM(passed))) IN ('false', '0', 'no')
                THEN CAST(0 AS BIT)
            ELSE NULL
        END AS passed,

        UPPER(NULLIF(LTRIM(RTRIM(final_grade_band)), ''))
            AS final_grade_band,

        CASE
            WHEN LOWER(LTRIM(RTRIM(at_risk_final_outcome)))
                    IN ('true', '1', 'yes')
                THEN CAST(1 AS BIT)
            WHEN LOWER(LTRIM(RTRIM(at_risk_final_outcome)))
                    IN ('false', '0', 'no')
                THEN CAST(0 AS BIT)
            ELSE NULL
        END AS at_risk_final_outcome,

        COALESCE(
            TRY_CONVERT(
                DATE,
                NULLIF(LTRIM(RTRIM(outcome_available_date)), ''),
                23
            ),
            TRY_CONVERT(
                DATE,
                NULLIF(LTRIM(RTRIM(outcome_available_date)), ''),
                103
            )
        ) AS outcome_available_date

    FROM bronze.final_results
),

validated AS (
    SELECT
        enrollment_id,
        student_id,
        course_id,

        CASE
            WHEN final_score BETWEEN 0 AND 100 THEN final_score
            ELSE NULL
        END AS final_score,

        passed,

        CASE
            WHEN final_grade_band IN ('A', 'B', 'C', 'D', 'F')
                THEN final_grade_band
            ELSE NULL
        END AS final_grade_band,

        at_risk_final_outcome,
        outcome_available_date
    FROM cleaned
    WHERE enrollment_id IS NOT NULL
),

ranked AS (
    SELECT *,
        ROW_NUMBER() OVER (
            PARTITION BY
                enrollment_id, student_id, course_id,
                final_score, passed, final_grade_band,
                at_risk_final_outcome, outcome_available_date
            ORDER BY enrollment_id
        ) AS rn
    FROM validated
),

deduplicated AS (
    SELECT *
    FROM ranked
    WHERE rn = 1
)

INSERT INTO silver.final_result (
    enrollment_id, student_id, course_id,
    final_score, passed, final_grade_band,
    at_risk_final_outcome, outcome_available_date
)
SELECT
    enrollment_id, student_id, course_id,
    final_score, passed, final_grade_band,
    at_risk_final_outcome, outcome_available_date
FROM deduplicated;
GO

-- silver.lms_activity

IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = 'lms_activity' AND schema_id = schema_id('silver'))
BEGIN
    CREATE TABLE silver.lms_activity (
        lms_record_id VARCHAR(50) UNIQUE,
        student_id VARCHAR(50),
        enrollment_id VARCHAR(50),
        course_id VARCHAR(50),
        week INT,
        login_count INT,
        resource_views INT,
        forum_posts INT,
        video_minutes DECIMAL(8,2),
        last_activity_days_ago INT
    );
END
GO

TRUNCATE TABLE silver.lms_activity;

;WITH cleaned AS (
    SELECT
        NULLIF(LTRIM(RTRIM(lms_activity_id)), '') AS lms_record_id,
        NULLIF(LTRIM(RTRIM(student_id)), '') AS student_id,
        NULLIF(LTRIM(RTRIM(enrollment_id)), '') AS enrollment_id,
        NULLIF(LTRIM(RTRIM(course_id)), '') AS course_id,
        TRY_CAST(week AS INT) AS week,
        TRY_CAST(login_count AS INT) AS login_count,
        TRY_CAST(resource_views AS INT) AS resource_views,
        TRY_CAST(forum_posts AS INT) AS forum_posts,
        TRY_CAST(NULLIF(LTRIM(RTRIM(video_minutes)), '') AS DECIMAL(8,2))
            AS video_minutes,
        TRY_CAST(last_activity_days_ago AS INT) AS last_activity_days_ago

    FROM bronze.lms_activity
),

validated AS (
    SELECT
        lms_record_id,
        student_id,
        enrollment_id,
        course_id,

        CASE
            WHEN week BETWEEN 1 AND 12 THEN week
            ELSE NULL
        END AS week,

        CASE
            WHEN login_count >= 0 THEN login_count
            ELSE NULL
        END AS login_count,

        CASE
            WHEN resource_views >= 0 THEN resource_views
            ELSE NULL
        END AS resource_views,

        CASE
            WHEN forum_posts >= 0 THEN forum_posts
            ELSE NULL
        END AS forum_posts,

        CASE
            WHEN video_minutes >= 0 THEN video_minutes
            ELSE NULL
        END AS video_minutes,

        CASE
            WHEN last_activity_days_ago >= 0
                THEN last_activity_days_ago
            ELSE NULL
        END AS last_activity_days_ago

    FROM cleaned
    WHERE lms_record_id IS NOT NULL
),

-- Handle NULLs left after validation
imputed AS (
    SELECT
        lms_record_id,
        student_id,
        enrollment_id,
        course_id,
        week,
        login_count,
        resource_views,
        forum_posts,

        -- video_minutes: fill NULL with 0
        COALESCE(video_minutes, 0) AS video_minutes,

        last_activity_days_ago
    FROM validated
),

ranked AS (
    SELECT *,
        ROW_NUMBER() OVER (
            PARTITION BY
                lms_record_id, student_id, enrollment_id, course_id,
                week, login_count, resource_views, forum_posts,
                video_minutes, last_activity_days_ago
            ORDER BY lms_record_id
        ) AS rn
    FROM imputed
),

deduplicated AS (
    SELECT *
    FROM ranked
    WHERE rn = 1
)

INSERT INTO silver.lms_activity (
    lms_record_id, student_id, enrollment_id, course_id, week,
    login_count, resource_views, forum_posts, video_minutes,
    last_activity_days_ago
)
SELECT
    lms_record_id, student_id, enrollment_id, course_id, week,
    login_count, resource_views, forum_posts, video_minutes,
    last_activity_days_ago
FROM deduplicated;
GO

-- silver.student_support

IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = 'student_support' AND schema_id = schema_id('silver'))
BEGIN
    CREATE TABLE silver.student_support (
        support_event_id VARCHAR(50) UNIQUE,
        student_id VARCHAR(50),
        enrollment_id VARCHAR(50),
        support_type VARCHAR(100),
        event_week INT,
        participated BIT,
        follow_up_completed BIT
    );
END
GO

TRUNCATE TABLE silver.student_support;

;WITH cleaned AS (
    SELECT
        NULLIF(LTRIM(RTRIM(support_event_id)), '') AS support_event_id,
        NULLIF(LTRIM(RTRIM(student_id)), '') AS student_id,
        NULLIF(LTRIM(RTRIM(enrollment_id)), '') AS enrollment_id,

        CASE
            WHEN LOWER(LTRIM(RTRIM(support_type))) = 'advising'
                THEN 'Advising'
            WHEN LOWER(LTRIM(RTRIM(support_type))) = 'tutoring'
                THEN 'Tutoring'
            WHEN LOWER(LTRIM(RTRIM(support_type))) = 'peer study group'
                THEN 'Peer study group'
            ELSE NULLIF(LTRIM(RTRIM(support_type)), '')
        END AS support_type,

        TRY_CONVERT(
            INT,
            TRY_CONVERT(
                DECIMAL(5,2),
                NULLIF(LTRIM(RTRIM(event_week)), '')
            )
        ) AS event_week,

        CASE
            WHEN LOWER(LTRIM(RTRIM(participated))) IN ('true', '1', 'yes')
                THEN CAST(1 AS BIT)
            WHEN LOWER(LTRIM(RTRIM(participated))) IN ('false', '0', 'no')
                THEN CAST(0 AS BIT)
            ELSE NULL
        END AS participated,

        CASE
            WHEN LOWER(LTRIM(RTRIM(follow_up_completed)))
                    IN ('true', '1', 'yes')
                THEN CAST(1 AS BIT)
            WHEN LOWER(LTRIM(RTRIM(follow_up_completed)))
                    IN ('false', '0', 'no')
                THEN CAST(0 AS BIT)
            ELSE NULL
        END AS follow_up_completed

    FROM bronze.student_support
),

validated AS (
    SELECT
        support_event_id,
        student_id,
        enrollment_id,
        support_type,

        CASE
            WHEN event_week BETWEEN 1 AND 12 THEN event_week
            ELSE NULL
        END AS event_week,

        participated,
        follow_up_completed
    FROM cleaned
    WHERE support_event_id IS NOT NULL
),

ranked AS (
    SELECT *,
        ROW_NUMBER() OVER (
            PARTITION BY
                support_event_id, student_id, enrollment_id,
                support_type, event_week, participated,
                follow_up_completed
            ORDER BY support_event_id
        ) AS rn
    FROM validated
),

deduplicated AS (
    SELECT *
    FROM ranked
    WHERE rn = 1
)

INSERT INTO silver.student_support (
    support_event_id, student_id, enrollment_id, support_type,
    event_week, participated, follow_up_completed
)
SELECT
    support_event_id, student_id, enrollment_id, support_type,
    event_week, participated, follow_up_completed
FROM deduplicated;
GO

-- silver.weekly_snapshot

IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = 'weekly_snapshot' AND schema_id = schema_id('silver'))
BEGIN
    CREATE TABLE silver.weekly_snapshot (
        snapshot_id VARCHAR(50) UNIQUE,
        enrollment_id VARCHAR(50),
        student_id VARCHAR(50),
        course_id VARCHAR(50),
        snapshot_week INT,
        snapshot_date DATE,
        attendance_pct_to_date DECIMAL(5,2),
        absences_to_date INT,
        lms_events_this_week INT,
        lms_events_rolling_3_weeks INT,
        assignments_due_to_date INT,
        assignments_submitted_to_date INT,
        late_submissions_to_date INT,
        assessment_average_available_to_date DECIMAL(5,2),
        prior_gpa DECIMAL(4,2),
        prior_failed_courses INT,
        usual_study_hours_per_week DECIMAL(5,2),
        sleep_hours_per_night DECIMAL(4,2),
        employment_status VARCHAR(50),
        commute_minutes_one_way INT,
        internet_access VARCHAR(50),
        financial_strain_self_report VARCHAR(50)
    );
END
GO

TRUNCATE TABLE silver.weekly_snapshot;

;WITH cleaned AS (
    SELECT
        NULLIF(LTRIM(RTRIM(snapshot_id)), '') AS snapshot_id,
        NULLIF(LTRIM(RTRIM(enrollment_id)), '') AS enrollment_id,
        NULLIF(LTRIM(RTRIM(student_id)), '') AS student_id,
        NULLIF(LTRIM(RTRIM(course_id)), '') AS course_id,
        TRY_CAST(snapshot_week AS INT) AS snapshot_week,

        COALESCE(
            TRY_CONVERT(
                DATE,
                NULLIF(LTRIM(RTRIM(snapshot_date)), ''),
                23
            ),
            TRY_CONVERT(
                DATE,
                NULLIF(LTRIM(RTRIM(snapshot_date)), ''),
                103
            )
        ) AS snapshot_date,

        TRY_CAST(attendance_pct_to_date AS DECIMAL(5,2))
            AS attendance_pct_to_date,

        TRY_CAST(absences_to_date AS INT)
            AS absences_to_date,

        TRY_CAST(lms_events_this_week AS INT)
            AS lms_events_this_week,

        TRY_CAST(lms_events_rolling_3_weeks AS INT)
            AS lms_events_rolling_3_weeks,

        TRY_CAST(assignments_due_to_date AS INT)
            AS assignments_due_to_date,

        TRY_CAST(assignments_submitted_to_date AS INT)
            AS assignments_submitted_to_date,

        TRY_CAST(late_submissions_to_date AS INT)
            AS late_submissions_to_date,

        TRY_CAST(
            NULLIF(
                LTRIM(RTRIM(assessment_average_available_to_date)),
                ''
            ) AS DECIMAL(5,2)
        ) AS assessment_average_available_to_date,

        TRY_CAST(prior_gpa AS DECIMAL(4,2))
            AS prior_gpa,

        TRY_CAST(prior_failed_courses AS INT)
            AS prior_failed_courses,

        TRY_CAST(usual_study_hours_per_week AS DECIMAL(5,2))
            AS usual_study_hours_per_week,

        TRY_CAST(sleep_hours_per_night AS DECIMAL(4,2))
            AS sleep_hours_per_night,

        CASE
            WHEN LOWER(LTRIM(RTRIM(employment_status)))
                    IN ('part-time', 'part time')
                THEN 'Part-time'
            WHEN LOWER(LTRIM(RTRIM(employment_status)))
                    IN ('full-time', 'full time')
                THEN 'Full-time'
            WHEN LOWER(LTRIM(RTRIM(employment_status))) = 'not employed'
                THEN 'Not employed'
            ELSE NULLIF(LTRIM(RTRIM(employment_status)), '')
        END AS employment_status,

        TRY_CAST(commute_minutes_one_way AS INT)
            AS commute_minutes_one_way,

        CASE
            WHEN LOWER(LTRIM(RTRIM(internet_access))) = 'reliable'
                THEN 'Reliable'
            WHEN LOWER(LTRIM(RTRIM(internet_access))) = 'limited'
                THEN 'Limited'
            WHEN LOWER(LTRIM(RTRIM(internet_access)))
                    = 'sometimes unreliable'
                THEN 'Sometimes unreliable'
            ELSE NULLIF(LTRIM(RTRIM(internet_access)), '')
        END AS internet_access,

        CASE
            WHEN LOWER(LTRIM(RTRIM(financial_strain_self_report))) = 'low'
                THEN 'Low'
            WHEN LOWER(LTRIM(RTRIM(financial_strain_self_report))) = 'moderate'
                THEN 'Moderate'
            WHEN LOWER(LTRIM(RTRIM(financial_strain_self_report))) = 'high'
                THEN 'High'
            ELSE NULLIF(LTRIM(RTRIM(financial_strain_self_report)), '')
        END AS financial_strain_self_report

    FROM bronze.weekly_snapshots
),

validated AS (
    SELECT
        snapshot_id,
        enrollment_id,
        student_id,
        course_id,

        CASE
            WHEN snapshot_week BETWEEN 1 AND 12
                THEN snapshot_week
            ELSE NULL
        END AS snapshot_week,

        snapshot_date,

        CASE
            WHEN attendance_pct_to_date BETWEEN 0 AND 100
                THEN attendance_pct_to_date
            ELSE NULL
        END AS attendance_pct_to_date,

        CASE
            WHEN absences_to_date >= 0
                THEN absences_to_date
            ELSE NULL
        END AS absences_to_date,

        CASE
            WHEN lms_events_this_week >= 0
                THEN lms_events_this_week
            ELSE NULL
        END AS lms_events_this_week,

        CASE
            WHEN lms_events_rolling_3_weeks >= 0
                THEN lms_events_rolling_3_weeks
            ELSE NULL
        END AS lms_events_rolling_3_weeks,

        CASE
            WHEN assignments_due_to_date >= 0
                THEN assignments_due_to_date
            ELSE NULL
        END AS assignments_due_to_date,

        CASE
            WHEN assignments_submitted_to_date >= 0
                 AND assignments_submitted_to_date <= assignments_due_to_date
                THEN assignments_submitted_to_date
            ELSE NULL
        END AS assignments_submitted_to_date,

        CASE
            WHEN late_submissions_to_date >= 0
                 AND late_submissions_to_date <= assignments_submitted_to_date
                THEN late_submissions_to_date
            ELSE NULL
        END AS late_submissions_to_date,

        CASE
            WHEN assessment_average_available_to_date BETWEEN 0 AND 100
                THEN assessment_average_available_to_date
            ELSE NULL
        END AS assessment_average_available_to_date,

        CASE
            WHEN prior_gpa BETWEEN 0 AND 4
                THEN prior_gpa
            ELSE NULL
        END AS prior_gpa,

        CASE
            WHEN prior_failed_courses >= 0
                THEN prior_failed_courses
            ELSE NULL
        END AS prior_failed_courses,

        CASE
            WHEN usual_study_hours_per_week >= 0
                THEN usual_study_hours_per_week
            ELSE NULL
        END AS usual_study_hours_per_week,

        CASE
            WHEN sleep_hours_per_night BETWEEN 0 AND 24
                THEN sleep_hours_per_night
            ELSE NULL
        END AS sleep_hours_per_night,

        employment_status,

        CASE
            WHEN commute_minutes_one_way >= 0
                THEN commute_minutes_one_way
            ELSE NULL
        END AS commute_minutes_one_way,

        internet_access,
        financial_strain_self_report

    FROM cleaned
    WHERE snapshot_id IS NOT NULL
),

-- Handle NULLs left after validation
imputed AS (
    SELECT
        snapshot_id,
        enrollment_id,
        student_id,
        course_id,
        snapshot_week,
        snapshot_date,
        attendance_pct_to_date,
        absences_to_date,
        lms_events_this_week,
        lms_events_rolling_3_weeks,
        assignments_due_to_date,
        assignments_submitted_to_date,
        late_submissions_to_date,

        -- left as NULL on purpose: no graded assessments yet in early weeks
        assessment_average_available_to_date,

        prior_gpa,
        prior_failed_courses,
        usual_study_hours_per_week,
        sleep_hours_per_night,
        employment_status,
        commute_minutes_one_way,

        -- internet_access: fill NULL/empty with 'Unknown'
        COALESCE(NULLIF(internet_access, ''), 'Unknown') AS internet_access,

        financial_strain_self_report
    FROM validated
),

ranked AS (
    SELECT *,
        ROW_NUMBER() OVER (
            PARTITION BY
                snapshot_id, enrollment_id, student_id, course_id,
                snapshot_week, snapshot_date,
                attendance_pct_to_date, absences_to_date,
                lms_events_this_week, lms_events_rolling_3_weeks,
                assignments_due_to_date, assignments_submitted_to_date,
                late_submissions_to_date,
                assessment_average_available_to_date,
                prior_gpa, prior_failed_courses,
                usual_study_hours_per_week, sleep_hours_per_night,
                employment_status, commute_minutes_one_way,
                internet_access, financial_strain_self_report
            ORDER BY snapshot_id
        ) AS rn
    FROM imputed
),

deduplicated AS (
    SELECT *
    FROM ranked
    WHERE rn = 1
)

INSERT INTO silver.weekly_snapshot (
    snapshot_id, enrollment_id, student_id, course_id,
    snapshot_week, snapshot_date, attendance_pct_to_date,
    absences_to_date, lms_events_this_week,
    lms_events_rolling_3_weeks, assignments_due_to_date,
    assignments_submitted_to_date, late_submissions_to_date,
    assessment_average_available_to_date, prior_gpa,
    prior_failed_courses, usual_study_hours_per_week,
    sleep_hours_per_night, employment_status,
    commute_minutes_one_way, internet_access,
    financial_strain_self_report
)
SELECT
    snapshot_id, enrollment_id, student_id, course_id,
    snapshot_week, snapshot_date, attendance_pct_to_date,
    absences_to_date, lms_events_this_week,
    lms_events_rolling_3_weeks, assignments_due_to_date,
    assignments_submitted_to_date, late_submissions_to_date,
    assessment_average_available_to_date, prior_gpa,
    prior_failed_courses, usual_study_hours_per_week,
    sleep_hours_per_night, employment_status,
    commute_minutes_one_way, internet_access,
    financial_strain_self_report
FROM deduplicated;
GO