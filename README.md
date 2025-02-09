QAP2 - SQL and PostgreSQL Mastery
This repository contains SQL scripts for two database systems:

📌 University Course Enrollment System
A database for managing students, professors, courses, and enrollments.

✅ Features
Students can enroll in multiple courses.
Each course is assigned one professor.
Supports data retrieval, updates, and deletions.

📂 Tables
students (student_id, first_name, last_name, email, school_enrollment_date)
professors (professor_id, first_name, last_name, department)
courses (course_id, course_name, course_description, professor_id)
enrollment (student_id, course_id, enrollment_date)

🛠 SQL Operations
🔹  Create tables
🔹  Insert data
🔹 Retrieve enrolled students
🔹 Update student email
🔹 Remove a student from a course

📌 Online Store Inventory & Orders System
A database for tracking products, customers, orders, and order items.

✅ Features
Customers can place multiple orders.
Each order contains multiple products.
Stock updates automatically when orders are placed.

📂 Tables
products (product_id, product_name, price, stock_quantity)
customers (customer_id, first_name, last_name, email)
orders (order_id, customer_id, order_date)
order_items (order_id, product_id, quantity)

🛠 SQL Operations
🔹 Create tables
🔹 Insert data
🔹 Retrieve product stock & order details
🔹 Update stock after purchase
🔹 Delete orders


