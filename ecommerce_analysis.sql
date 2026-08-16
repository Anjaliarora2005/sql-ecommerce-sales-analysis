-- SQL E-Commerce Sales Analysis
-- Database: SQLite

-- 1. Display all records from Customers
SELECT * FROM Customers;

-- 2. Display customer_name, city, and state
SELECT customer_name, city, state FROM Customers;

-- 3. Find all unique cities
SELECT DISTINCT city FROM Customers;

-- 4. Calculate total number of customers
SELECT COUNT(*) AS total_customer FROM Customers;

-- 5. Find total Male and Female customers
SELECT gender, COUNT(*) AS total_customers
FROM Customers
GROUP BY gender;

-- 6. Find all customers from Delhi
SELECT customer_name
FROM Customers
WHERE city = 'Delhi';

-- 7. Find customers who signed up after 2024
SELECT *
FROM Customers
WHERE signup_date >= '2025-01-01';

-- 8. Sort products from highest price to lowest
SELECT * FROM products
ORDER BY price DESC;

-- 9. Find the top 10 most expensive products
SELECT * FROM products
ORDER BY price DESC
LIMIT 10;

-- 10. Calculate total number of products
SELECT COUNT(*) AS total_products
FROM products;

-- 11. Calculate total number of orders
SELECT COUNT(*) AS total_orders
FROM Orders;

-- 12. Find number of orders for each order status
SELECT order_status, COUNT(*) AS total_orders
FROM Orders
GROUP BY order_status;

-- 13. Calculate number of orders for each payment method
SELECT payment_method, COUNT(*) AS total_orders
FROM Orders
GROUP BY payment_method;

-- 14. Calculate average order value
SELECT AVG(sales_amount) AS avg_order_value
FROM Order_Details;

-- 15. Calculate total sales revenue
SELECT SUM(sales_amount) AS total_sales_revenue
FROM Order_Details;

-- 16. Calculate month-wise total sales
SELECT strftime('%Y-%m', order_date) AS month,
       SUM(sales_amount) AS total_sales
FROM Orders
JOIN Order_Details USING (order_id)
GROUP BY month;

-- 17. Calculate year-wise total sales
SELECT strftime('%Y', order_date) AS year,
       SUM(sales_amount) AS total_sales
FROM Orders
JOIN Order_Details USING (order_id)
GROUP BY year
ORDER BY year;

-- 18. Find the top 10 highest-value orders
SELECT order_id, sales_amount
FROM Order_Details
ORDER BY sales_amount DESC
LIMIT 10;

-- 19. Find total orders placed by each customer
SELECT customer_id, COUNT(order_id) AS total_orders
FROM Orders
GROUP BY customer_id;

-- 20. Find customers who have placed more than 5 orders
SELECT customer_id, COUNT(order_id) AS total_orders
FROM Orders
GROUP BY customer_id
HAVING COUNT(order_id) > 5;

-- 21. Display customer names along with their order details
SELECT customer_name, Orders.*
FROM Customers
JOIN Orders ON Customers.customer_id = Orders.customer_id;

-- 22. Display Order ID, Customer Name, Order Date, and Order Status
SELECT o.order_id, c.customer_name, o.order_date, o.order_status
FROM Orders o
JOIN Customers c ON o.customer_id = c.customer_id;

-- 23. Display Product Name along with Sales Amount
SELECT p.product_name, od.sales_amount
FROM Products p
JOIN Order_Details od ON p.product_id = od.product_id;

-- 24. Display Customer Name, Product Name, Quantity, and Sales Amount
SELECT c.customer_name, p.product_name, od.quantity, od.sales_amount
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
JOIN Order_Details od ON o.order_id = od.order_id
JOIN Products p ON od.product_id = p.product_id;

-- 25. Calculate total spending of each customer
SELECT c.customer_name, SUM(od.sales_amount) AS total_spending
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
JOIN Order_Details od ON o.order_id = od.order_id
GROUP BY c.customer_name;

-- 26. Find the top 10 highest-spending customers
SELECT c.customer_name, SUM(od.sales_amount) AS total_spending
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
JOIN Order_Details od ON o.order_id = od.order_id
GROUP BY c.customer_name
ORDER BY total_spending DESC
LIMIT 10;

-- 27. Calculate total sales for each product
SELECT p.product_name, SUM(od.sales_amount) AS total_sales
FROM Products p
JOIN Order_Details od ON p.product_id = od.product_id
GROUP BY p.product_name;

-- 28. Find the top 10 best-selling products by sales
SELECT p.product_name, SUM(od.sales_amount) AS total_sales
FROM Products p
JOIN Order_Details od ON p.product_id = od.product_id
GROUP BY p.product_name
ORDER BY total_sales DESC
LIMIT 10;

-- 29. Calculate category-wise total revenue
SELECT p.category, SUM(od.sales_amount) AS total_revenue
FROM Products p
JOIN Order_Details od ON p.product_id = od.product_id
GROUP BY p.category;

-- 30. Find customers who have never placed an order
SELECT c.customer_id, c.customer_name
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;
