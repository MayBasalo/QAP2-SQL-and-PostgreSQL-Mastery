University Course Enrollment System
This database system manages information about students, professors, courses, and enrollments.

Key Features:
Students can enroll in multiple courses.
Each course is taught by one professor.
Supports data retrieval, updates, and deletions for various operations.
Tables:
students: Stores student information.

student_id (Primary Key)
first_name
last_name
email
school_enrollment_date
professors: Stores professor information.

professor_id (Primary Key)
first_name
last_name
department
courses: Stores course details.

course_id (Primary Key)
course_name
course_description
professor_id (Foreign Key, references professors)
enrollments: Links students to the courses they are enrolled in.

student_id (Foreign Key, references students)
course_id (Foreign Key, references courses)
enrollment_date
SQL Operations Included:
Create tables: Defines the structure for students, professors, courses, and enrollments.
Insert data: Populates the tables with sample records.
Retrieve enrolled students: Queries to list students enrolled in specific courses.
Update student email: Allows for updating student contact information.
Remove a student from a course: Deletes a student's enrollment from a specific course.
