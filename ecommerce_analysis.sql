-- Create database
CREATE DATABASE ecommerce;

-- Use the database (for MySQL/PostgreSQL)
USE ecommerce;


--Creating Tables

-- Customers table
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    city VARCHAR(100)
);

-- Products table
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    name VARCHAR(100),
    category VARCHAR(100),
    price DECIMAL(10, 2)
);

-- Orders table
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    quantity INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);


--Inserting Values


INSERT INTO customers VALUES
(1, 'Alice', 'alice@example.com', 'Mumbai'),
(2, 'Bob', 'bob@example.com', 'Delhi'),
(3, 'Charlie', 'charlie@example.com', 'Bangalore'),
(4, 'David', 'david@example.com', 'Kolkata'),
(5, 'Eva', 'eva@example.com', 'Chennai'),
(6, 'Frank', 'frank@example.com', 'Hyderabad'),
(7, 'Grace', 'grace@example.com', 'Pune'),
(8, 'Henry', 'henry@example.com', 'Ahmedabad'),
(9, 'Ivy', 'ivy@example.com', 'Jaipur'),
(10, 'Jack', 'jack@example.com', 'Lucknow'),
(11, 'Kate', 'kate@example.com', 'Nagpur'),
(12, 'Leo', 'leo@example.com', 'Indore'),
(13, 'Mia', 'mia@example.com', 'Bhopal'),
(14, 'Nina', 'nina@example.com', 'Surat'),
(15, 'Oscar', 'oscar@example.com', 'Patna'),
(16, 'Paul', 'paul@example.com', 'Ranchi'),
(17, 'Queen', 'queen@example.com', 'Chandigarh'),
(18, 'Rick', 'rick@example.com', 'Guwahati'),
(19, 'Sara', 'sara@example.com', 'Mangalore'),
(20, 'Tom', 'tom@example.com', 'Coimbatore');

INSERT INTO products VALUES
(101, 'Laptop', 'Electronics', 55000.00),
(102, 'Smartphone', 'Electronics', 25000.00),
(103, 'Tablet', 'Electronics', 18000.00),
(104, 'Headphones', 'Accessories', 3000.00),
(105, 'Monitor', 'Electronics', 12000.00),
(106, 'Keyboard', 'Accessories', 1500.00),
(107, 'Mouse', 'Accessories', 800.00),
(108, 'Printer', 'Electronics', 8000.00),
(109, 'Desk', 'Furniture', 6000.00),
(110, 'Chair', 'Furniture', 3500.00),
(111, 'Bookshelf', 'Furniture', 4000.00),
(112, 'Notebook', 'Stationery', 50.00),
(113, 'Pen', 'Stationery', 20.00),
(114, 'Bag', 'Accessories', 1200.00),
(115, 'Router', 'Electronics', 3000.00),
(116, 'Hard Disk', 'Electronics', 5000.00),
(117, 'SSD', 'Electronics', 7000.00),
(118, 'Smartwatch', 'Electronics', 9000.00),
(119, 'Speakers', 'Electronics', 3500.00),
(120, 'Webcam', 'Electronics', 2500.00);

INSERT INTO orders VALUES
(1001, 1, 101, 1, '2024-05-10'),
(1002, 2, 102, 2, '2024-05-12'),
(1003, 3, 103, 1, '2024-05-13'),
(1004, 4, 104, 3, '2024-05-14'),
(1005, 5, 105, 1, '2024-05-15'),
(1006, 6, 106, 2, '2024-05-16'),
(1007, 7, 107, 1, '2024-05-17'),
(1008, 8, 108, 1, '2024-05-18'),
(1009, 9, 109, 1, '2024-05-19'),
(1010, 10, 110, 2, '2024-05-20'),
(1011, 11, 111, 1, '2024-05-21'),
(1012, 12, 112, 10, '2024-05-22'),
(1013, 13, 113, 5, '2024-05-23'),
(1014, 14, 114, 2, '2024-05-24'),
(1015, 15, 115, 1, '2024-05-25'),
(1016, 16, 116, 1, '2024-05-26'),
(1017, 17, 117, 1, '2024-05-27'),
(1018, 18, 118, 1, '2024-05-28'),
(1019, 19, 119, 2, '2024-05-29'),
(1020, 20, 120, 1, '2024-05-30');


-- Queries


--BASIC QUERIES(SELECT, WHERE, ORDER BY, GROUP BY)
-- 1. List all customers in Mumbai
SELECT * FROM customers WHERE city = 'Mumbai';

-- 2. List orders by order date descending
SELECT * FROM orders ORDER BY order_date DESC;

-- 3. Total quantity ordered per product
SELECT product_id, SUM(quantity) AS total_quantity
FROM orders
GROUP BY product_id;


--JOINS(INNER, LEFT)
-- INNER JOIN: Show customer name and product name for each order
SELECT c.name AS customer_name, p.name AS product_name, o.order_date
FROM orders o
INNER JOIN customers c ON o.customer_id = c.customer_id
INNER JOIN products p ON o.product_id = p.product_id;

-- LEFT JOIN: Show all customers and their orders (if any)
SELECT c.name, o.order_id
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id;


--SUBQUERIES
-- Customers who ordered products priced over 30,000
SELECT name FROM customers
WHERE customer_id IN (
    SELECT customer_id FROM orders
    WHERE product_id IN (
        SELECT product_id FROM products WHERE price > 30000
    )
);


--AGGREGATE FUNCTIONS (SUM, AVG)
-- Total sales value
SELECT SUM(p.price * o.quantity) AS total_sales
FROM orders o
JOIN products p ON o.product_id = p.product_id;

-- Average order quantity
SELECT AVG(quantity) AS avg_order_quantity FROM orders;


--VIEWS
-- Create a view of customer orders
CREATE VIEW customer_orders AS
SELECT c.name AS customer_name, p.name AS product_name, o.quantity, o.order_date
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN products p ON o.product_id = p.product_id;

-- Use the view
SELECT * FROM customer_orders;


--INDEXES
-- Add indexes to improve JOIN/filter performance
CREATE INDEX idx_customer_id ON orders(customer_id);
CREATE INDEX idx_product_id ON orders(product_id);


