-- ==========================
-- Task 1: Create Database
-- ==========================

USE college_db;
CREATE TABLE departments (
    department_id INT AUTO_INCREMENT PRIMARY KEY,
    dept_name VARCHAR(100) NOT NULL,
    hod_name VARCHAR(100),
    budget DECIMAL(12,2)
);
CREATE TABLE students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    date_of_birth DATE,
    department_id INT,
    enrollment_year INT,
    FOREIGN KEY (department_id)
        REFERENCES departments(department_id)
);
CREATE TABLE courses (
    course_id INT AUTO_INCREMENT PRIMARY KEY,
    course_name VARCHAR(150) NOT NULL,
    course_code VARCHAR(20) UNIQUE,
    credits INT,
    department_id INT,
    FOREIGN KEY (department_id)
        REFERENCES departments(department_id)
);
CREATE TABLE enrollments (
    enrollment_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    course_id INT,
    enrollment_date DATE,
    grade CHAR(2),
    FOREIGN KEY (student_id)
        REFERENCES students(student_id),
    FOREIGN KEY (course_id)
        REFERENCES courses(course_id)
);
CREATE TABLE professors (
    professor_id INT AUTO_INCREMENT PRIMARY KEY,
    prof_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    department_id INT,
    salary DECIMAL(10,2),
    FOREIGN KEY (department_id)
        REFERENCES departments(department_id)
);

-- ==========================
-- Task 2: Verify Schema
-- ==========================

SHOW TABLES;

DESCRIBE departments;
DESCRIBE students;
DESCRIBE courses;
DESCRIBE enrollments;
DESCRIBE professors;

SHOW CREATE TABLE students;
SHOW CREATE TABLE courses;
SHOW CREATE TABLE enrollments;
SHOW CREATE TABLE professors;

-- =============================
-- Task 3: Verify Normalization
-- =============================

-- 1NF:
-- All tables contain atomic values.
-- Each column stores only one value.
-- There are no repeating groups or multivalued attributes.

-- Example violation:
-- If phone numbers were stored as
-- '9876543210,9123456789'
-- in one column, it would violate 1NF.

-- 2NF:
-- Every table has a single-column primary key.
-- In the enrollments table, all non-key attributes
-- depend on the primary key (enrollment_id).
-- There are no partial dependencies.

-- 3NF:
-- No non-key attribute depends on another non-key attribute.
-- Department information is stored only in the departments table.
-- Students store only department_id.
-- Therefore, there are no transitive dependencies.

-- Conclusion:
-- The schema satisfies 1NF, 2NF and 3NF.

-- ===============================
-- Task 4: Alter and Extend Schema
-- ===============================

ALTER TABLE students
ADD phone_number VARCHAR(15);

ALTER TABLE courses
ADD max_seats INT DEFAULT 60;
DESCRIBE courses;
SHOW CREATE TABLE courses;

ALTER TABLE enrollments
ADD CONSTRAINT chk_grade
CHECK (grade IN ('A','B','C','D','F') OR grade IS NULL);
SHOW CREATE TABLE enrollments;

SHOW CREATE TABLE departments;
ALTER TABLE departments
RENAME COLUMN hod_name TO head_of_dept;
SHOW CREATE TABLE departments;

ALTER TABLE students
DROP COLUMN phone_number;

DESCRIBE departments;
DESCRIBE courses;
DESCRIBE enrollments;
DESCRIBE students;

SHOW TABLES;

SHOW CREATE TABLE departments;
SHOW CREATE TABLE students;
SHOW CREATE TABLE courses;
SHOW CREATE TABLE enrollments;
SHOW CREATE TABLE professors;

--=============================
-- Ranjith Ganesh B
--=============================
