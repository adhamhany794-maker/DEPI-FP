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
    term_id VARCHAR(255),
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
    term_id VARCHAR(255),
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
    term_id VARCHAR(255),
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
FROM 'C:\Users\Adham\Desktop\Projects-DEPI\FinalProject\student_performance_data\students.csv'
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
FROM 'C:\Users\Adham\Desktop\Projects-DEPI\FinalProject\student_performance_data\assessments.csv'
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
FROM 'C:\Users\Adham\Desktop\Projects-DEPI\FinalProject\student_performance_data\attendance.csv'
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
FROM 'C:\Users\Adham\Desktop\Projects-DEPI\FinalProject\student_performance_data\courses.csv'
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
FROM 'C:\Users\Adham\Desktop\Projects-DEPI\FinalProject\student_performance_data\enrollments.csv'
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
FROM 'C:\Users\Adham\Desktop\Projects-DEPI\FinalProject\student_performance_data\final_results.csv'
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
FROM 'C:\Users\Adham\Desktop\Projects-DEPI\FinalProject\student_performance_data\lms_activity.csv'
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
FROM 'C:\Users\Adham\Desktop\Projects-DEPI\FinalProject\student_performance_data\student_support.csv'
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
FROM 'C:\Users\Adham\Desktop\Projects-DEPI\FinalProject\student_performance_data\weekly_snapshots.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIELDQUOTE = '"' ,
    CODEPAGE = '65001'
);

GO

-- silver tables creation

IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = 'student' AND schema_id = schema_id('silver'))
BEGIN
    CREATE TABLE silver.student (
        student_id VARCHAR(50) NOT NULL,
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
END

GO

IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = 'assessment' AND schema_id = schema_id('silver'))
BEGIN
    CREATE TABLE silver.assessment (
        assessment_id VARCHAR(50) NOT NULL,
        enrollment_id VARCHAR(50),
        assessment_name VARCHAR(150),
        assessment_type VARCHAR(50),
        week_due INT,
        due_date DATE,
        weight DECIMAL(5,2),
        max_score DECIMAL(6,2),
        score DECIMAL(6,2),
        submission_status VARCHAR(50),
        late_submission BIT
    );
END

GO

IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = 'attendance' AND schema_id = schema_id('silver'))
BEGIN
    CREATE TABLE silver.attendance (
        attendance_record_id VARCHAR(50) NOT NULL,
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

IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = 'course' AND schema_id = schema_id('silver'))
BEGIN
    CREATE TABLE silver.course (
        course_id VARCHAR(50) NOT NULL,
        department VARCHAR(100),
        course_name VARCHAR(150),
        course_type VARCHAR(50),
        credit_hours INT,
        difficulty_level VARCHAR(50),
        delivery_mode VARCHAR(50)
    );
END

GO

IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = 'enrollment' AND schema_id = schema_id('silver'))
BEGIN
    CREATE TABLE silver.enrollment (
        enrollment_id VARCHAR(50) NOT NULL,
        student_id VARCHAR(50),
        course_id VARCHAR(50),
        term_id VARCHAR(50),
        level_at_enrollment VARCHAR(50),
        credit_hours INT,
        registration_date DATE,
        withdrawn BIT
    );
END

GO

IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = 'FinalResults' AND schema_id = schema_id('silver'))
BEGIN
    CREATE TABLE silver.FinalResults (
        enrollment_id VARCHAR(50) NOT NULL,
        student_id VARCHAR(50),
        course_id VARCHAR(50),
        term_id VARCHAR(50),
        final_score DECIMAL(6,2),
        passed BIT,
        final_grade_band VARCHAR(10),
        at_risk_final_outcome VARCHAR(50),
        outcome_available_date DATE
    );
END

GO

IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = 'LmsActivity' AND schema_id = schema_id('silver'))
BEGIN
    CREATE TABLE silver.LmsActivity (
        lms_activity_id VARCHAR(50) NOT NULL,
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

IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = 'StudentSupport' AND schema_id = schema_id('silver'))
BEGIN
    CREATE TABLE silver.StudentSupport (
        support_event_id VARCHAR(50) NOT NULL,
        student_id VARCHAR(50),
        enrollment_id VARCHAR(50),
        support_type VARCHAR(100),
        event_week INT,
        participated BIT,
        follow_up_completed BIT
    );
END

GO

IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = 'WeeklySnapshots' AND schema_id = schema_id('silver'))
BEGIN
    CREATE TABLE silver.WeeklySnapshots (
        snapshot_id VARCHAR(50) NOT NULL,
        enrollment_id VARCHAR(50),
        student_id VARCHAR(50),
        course_id VARCHAR(50),
        term_id VARCHAR(50),
        snapshot_week INT,
        snapshot_date DATE,
        attendance_pct_to_date DECIMAL(5,2),
        absences_to_date INT,
        lms_events_this_week INT,
        lms_events_rolling_3_weeks INT,
        assignments_due_to_date INT,
        assignments_submitted_to_date INT,
        late_submissions_to_date INT,
        assessment_average_available_to_date DECIMAL(6,2),
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

