-- Problem 2 - Online Store Inventory and Orders System

-- Create Tables

-- Creating Products Table
CREATE TABLE products (
	product_id SERIAL PRIMARY KEY,
	product_name TEXT,
	price DECIMAL(10,2),
	stock_quantity INT
);

-- Creating Customers Table
CREATE TABLE customers (
	customer_id SERIAL PRIMARY KEY,
	first_name TEXT,
	last_name TEXT,
	email TEXT
);

-- Creating Orders Table
CREATE TABLE orders (
	order_id SERIAL PRIMARY KEY,
	customer_id INT REFERENCES customers(customer_id),
	order_date DATE DEFAULT CURRENT_DATE
);

-- Creating Order Items Table
CREATE TABLE order_items (
    order_id INT REFERENCES orders(order_id),
    product_id INT REFERENCES products(product_id),
    quantity INT,
    PRIMARY KEY (order_id, product_id)
);

---------------------------------------------------------------------------

-- Insert Data

-- Inserting Products Data
INSERT INTO products (product_name, price, stock_quantity) VALUES
    ('Laptop', 999.99, 15),
    ('Smartphone', 799.99, 25),
    ('Tablet', 499.99, 30),
    ('Smartwatch', 199.99, 40),
    ('Headphones', 149.99, 50);

-- Inserting Customers Data
INSERT INTO customers (first_name, last_name, email) VALUES
    ('Alice', 'Johnson', 'alice.johnson@example.com'),
    ('Bob', 'Smith', 'bob.smith@example.com'),
    ('Charlie', 'Davis', 'charlie.davis@example.com'),
    ('Diana', 'Moore', 'diana.moore@example.com');

-- Inserting Orders Data
INSERT INTO orders (customer_id, order_date) VALUES
    ((SELECT customer_id FROM customers WHERE first_name = 'Alice' AND last_name = 'Johnson'), '2023-09-01'),
    ((SELECT customer_id FROM customers WHERE first_name = 'Bob' AND last_name = 'Smith'), '2023-08-29'),
    ((SELECT customer_id FROM customers WHERE first_name = 'Charlie' AND last_name = 'Davis'), '2023-09-05'),
    ((SELECT customer_id FROM customers WHERE first_name = 'Diana' AND last_name = 'Moore'), '2023-09-04'),
    ((SELECT customer_id FROM customers WHERE first_name = 'Alice' AND last_name = 'Johnson'), '2023-08-23');

-- Inserting Order Items Data
INSERT INTO order_items (order_id, product_id, quantity) 
SELECT orders.order_id, products.product_id, order_items.quantity 
FROM (VALUES 
    (1, 'Laptop', 1), 
    (1, 'Tablet', 1), 
    (2, 'Smartphone', 1), 
    (2, 'Headphones', 2), 
    (3, 'Smartwatch', 2), 
    (3, 'Laptop', 1), 
    (4, 'Tablet', 1), 
    (4, 'Smartphone', 1), 
    (5, 'Smartwatch', 1), 
    (5, 'Headphones', 2) 
) AS order_items(order_id, product_name, quantity)
JOIN products ON order_items.product_name = products.product_name
JOIN orders ON order_items.order_id = orders.order_id;

-----------------------------------------------------------------------

--1) SQL Queries
--1.1) Retrieve the names and stock quantities of all products
SELECT product_name, stock_quantity FROM products;

-- 1.2) Retrieve the product names and quantities for one of the orders placed
SELECT product_name, quantity FROM products
JOIN order_items ON products.product_id = order_items.product_id
JOIN orders ON order_items.order_id = orders.order_id
WHERE orders.order_id = 1;

-- 1.3) Retrieve all orders placed by a specific customer (including IDs of what was ordered and quantities)
SELECT 
    orders.order_id, product_name, quantity,
    first_name || ' ' || last_name AS customer_full_name
FROM orders
JOIN customers ON orders.customer_id = customers.customer_id
JOIN order_items ON orders.order_id = order_items.order_id
JOIN products ON order_items.product_id = products.product_id
WHERE customers.first_name = 'Alice' AND customers.last_name = 'Johnson';

------------------------------------------------------------------------

--2) Update Data
-- Perform an update to simulate reducing stock quantities of items after a customer places an order
UPDATE products
SET stock_quantity = stock_quantity - order_items.quantity
FROM order_items
WHERE products.product_id = order_items.product_id
AND order_items.order_id = 1;

-- Check Stock Before and After the Update Query:
SELECT product_id, product_name, stock_quantity 
FROM products
WHERE product_id IN (SELECT product_id FROM order_items WHERE order_id = 1);

----------------------------------------------------------------------------
--3) Delete Data
-- Remove one of the orders and all associated order items from the system
DELETE FROM order_items WHERE order_id = 4;
DELETE FROM orders WHERE order_id = 4;

-- Check Orders Before and After the Delete Query:
SELECT * FROM orders WHERE order_id = 4;
SELECT * FROM order_items WHERE order_id = 4;


