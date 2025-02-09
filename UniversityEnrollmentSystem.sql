-- Problem 1 - University Course Enrollment System

-- Create Tables

-- Creating students Table
CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,
    first_name TEXT,
    last_name TEXT,
    email TEXT,
    school_enrollment_date DATE
);

-- Creating professors Table
CREATE TABLE professors (
    professor_id SERIAL PRIMARY KEY,
    first_name TEXT,
    last_name TEXT,
    department TEXT
);

-- Creating courses Table
CREATE TABLE courses (
    course_id SERIAL PRIMARY KEY,
    course_name TEXT,
    course_description TEXT,
    professor_id INT REFERENCES professors(professor_id)
);

-- Creating enrollment Table
CREATE TABLE enrollment (
    student_id INT REFERENCES students(student_id),
    course_id INT REFERENCES courses(course_id),
    enrollment_date DATE,
    PRIMARY KEY (student_id, course_id)
);

-----------------------------------------------------------------------------------

-- Insert Data

-- Inserting students Data
INSERT INTO students (first_name, last_name, email, school_enrollment_date) VALUES
('May', 'Basalo', 'may.basalo@example.com', '2024-02-10'),
('Olivia', 'Baker', 'olivia.baker@example.com', '2024-01-05'),
('Ethan', 'Davis', 'ethan.davis@example.com', '2023-11-25'),
('Mia', 'Taylor', 'mia.taylor@example.com', '2023-10-18'),
('Aiden', 'Martinez', 'aiden.martinez@example.com', '2024-03-02');

-- Confirmation query
SELECT * FROM students;

-- Inserting professors Data
INSERT INTO professors (first_name, last_name, department) VALUES
('Mary', 'Montero', 'Biology'),
('James', 'Johnson', 'Engineering'),
('Emily', 'Wilson', 'Literature'),
('Daniel', 'Brown', 'Psychology'),
('Sophia', 'Miller', 'Chemistry');

-- Confirmation query
SELECT * FROM professors;

-- Inserting Courses Data
INSERT INTO courses (course_name, course_description, professor_id) VALUES
('Biology 101', 'Introduction to Biology', (SELECT professor_id FROM professors WHERE first_name = 'Sophia' AND last_name = 'Miller')),
('Physics 101', 'Introduction to Physics', (SELECT professor_id FROM professors WHERE first_name = 'James' AND last_name = 'Johnson')),
('Psychology 101', 'Introduction to Psychology', (SELECT professor_id FROM professors WHERE first_name = 'Daniel' AND last_name = 'Brown'));

-- Confirmation query
SELECT * FROM courses;

-- Inserting enrollment Data
INSERT INTO enrollment (student_id, course_id, enrollment_date) VALUES
    ((SELECT student_id FROM students WHERE first_name = 'May' AND last_name = 'Basalo' LIMIT 1),
     (SELECT course_id FROM courses WHERE course_name = 'Chemistry 1' LIMIT 1), '2024-02-10'),
    (2, 2, '2024-01-05'),
    (3, 1, '2023-11-26'),
    (4, 2, '2023-10-18'),
    ((SELECT student_id FROM students WHERE first_name = 'Olivia' AND last_name = 'Baker' LIMIT 1),
     3, '2024-01-05');

-- Confirmation query
SELECT * FROM enrollment;

--------------------------------------------------------------------------------

 --1) SQL Queries
-- 1.1) Retrieve full names of all students enrolled in "Physics 101"
SELECT first_name || ' ' || last_name AS full_name
FROM students
JOIN enrollment ON students.student_id = enrollment.student_id
JOIN courses ON enrollment.course_id = courses.course_id
WHERE course_name = 'Physics 101';



-- 1.2) Retrieve a list of all courses along with the professor's full name who teaches each course
SELECT course_name, first_name || ' ' || last_name AS professor_full_name
FROM courses
JOIN professors ON courses.professor_id = professors.professor_id;



-- 1.3) Retrieve all courses that have students enrolled in them
SELECT DISTINCT course_name FROM courses 
JOIN enrollment ON courses.course_id = enrollment.course_id;

--------------------------------------------------------------------

--2) Update Data
-- Update a Student's Email
UPDATE students
SET email = 'may.basalo@keyin.com'
WHERE first_name = 'May' AND last_name = 'Basalo';

-- Confirmation query
SELECT email FROM students Where first_name = 'May' AND last_name = 'Basalo';


-----------------------------------------------------------------------

--3) Delete Data
-- Remove a Student from a Course
DELETE FROM enrollment
WHERE student_id = (SELECT student_id FROM students WHERE first_name = 'Mia' AND last_name = 'Taylor')
AND course_id = (SELECT course_id FROM courses WHERE course_name = 'Physics 101');

-- Confirmation query
SELECT * FROM enrollment;
