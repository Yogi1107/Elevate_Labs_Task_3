# SQL for Data Analysis - Ecommerce Dataset

This project demonstrates how to perform structured data analysis using SQL. Using a sample Ecommerce database, it covers everything from database creation to advanced querying and optimization using indexes.

---

## Objective

To analyze and extract insights from an Ecommerce dataset using core SQL features and techniques.

---

## Tools Used

- SQL Engine: MySQL / PostgreSQL / SQLite
- Optional: DB Browser for SQLite / phpMyAdmin / PgAdmin
- IDEs: VS Code, DBeaver, or Online SQL Editors

---

## 🗃Dataset Overview

We simulate an Ecommerce system with 3 tables:

### `customers`
| customer_id | name   | email             | city       |
|-------------|--------|-------------------|------------|
| INT         | TEXT   | TEXT              | TEXT       |

### `products`
| product_id | name        | category     | price     |
|------------|-------------|--------------|-----------|
| INT        | TEXT        | TEXT         | DECIMAL   |

### `orders`
| order_id | customer_id | product_id | quantity | order_date |
|----------|-------------|------------|----------|------------|
| INT      | FK          | FK         | INT      | DATE       |

---

## Features Implemented

### Database Operations

- Created and populated `customers`, `products`, `orders` tables with 20 entries each.
- Maintained proper foreign key relationships.

### SQL Analysis Techniques

- `SELECT`, `WHERE`, `GROUP BY`, `ORDER BY`
- Aggregate functions: `SUM`, `AVG`
- `JOIN`s: `INNER`, `LEFT`
- `Subqueries`
- `Views` for reusable queries
- `Indexes` for performance optimization

---

## Example Queries

### 1. Total Sales Per Product
```sql
SELECT p.name, SUM(o.quantity * p.price) AS total_sales
FROM orders o
JOIN products p ON o.product_id = p.product_id
GROUP BY p.name;
```
2. Customer Order View
```sql
CREATE VIEW customer_orders AS
SELECT c.name, p.name AS product, o.quantity, o.order_date
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN products p ON o.product_id = p.product_id;
```

3. Customers who ordered products above ₹30,000
```sql
SELECT name FROM customers
WHERE customer_id IN (
  SELECT customer_id FROM orders
  WHERE product_id IN (
    SELECT product_id FROM products WHERE price > 30000
  )
);
```

# Optimization
Indexes Created:
```sql
CREATE INDEX idx_customer_id ON orders(customer_id);
CREATE INDEX idx_product_id ON orders(product_id);
```
These indexes significantly boost performance of JOINs and WHERE filters.

## Deliverables
ecommerce_analysis.sql: SQL script with table creation and data insertion, SQL analysis queries
Screenshots folder: Output of queries
README.md: Documentation and usage instructions

## How to Use
Clone the repo:

```bash
git clone https://github.com/yourusername/sql-ecommerce-analysis.git
cd sql-ecommerce-analysis
```
Open the .sql files in your SQL client (MySQL, PostgreSQL, SQLite).

Execute the schema and insert script:
```sql
-- ecommerce_schema.sql
```

Run analysis queries from:
```sql
-- ecommerce_queries.sql
```

##Learning Outcome
Strong understanding of SQL syntax and logic
Practical knowledge of analyzing structured data
Insights into performance tuning using indexes
Ability to create views and subqueries for reusable logic
