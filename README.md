# Mintclassics-SQL-Case-Study

Project Overview

This project analyzes the Mint Classics dataset, a relational database with 9 interconnected tables covering customers, employees, offices, orders, order details, payments, products, product lines, and warehouses.

The goal was to demonstrate SQL proficiency and business insight generation by exploring customer behavior, sales performance, inventory distribution, and operational challenges.

 Database Schema
Customers – client information, credit limits, sales reps

Employees – staff details, reporting structure

Offices – office locations and territories

Orders – order lifecycle, status, comments

OrderDetails – product-level sales transactions

Payments – customer payments and amounts

Products – product catalog, pricing, stock, warehouse assignment

ProductLines – product categories and descriptions

Warehouses – warehouse capacity and inventory distribution

 Approach
Import & Validation – Loaded all tables, verified schema integrity.

Data Exploration – Profiled customers, employees, and offices.

Analysis Queries – Built joins and aggregations to uncover sales, payments, and inventory insights.

Business Insights – Connected technical results to strategic recommendations.

 Key Queries & Insights
 
Revenue by Product Line
sql
SELECT pl.productLine,
       SUM(od.quantityOrdered * od.priceEach) AS total_revenue
FROM productlines pl
JOIN products p ON pl.productLine = p.productLine
JOIN orderdetails od ON p.productCode = od.productCode
GROUP BY pl.productLine
ORDER BY total_revenue DESC;
Insight: Classic Cars dominate revenue, followed by Vintage Cars.

Top Customers by Payments
sql
SELECT c.customerName,
       SUM(p.amount) AS total_payments
FROM customers c
JOIN payments p ON c.customerNumber = p.customerNumber
GROUP BY c.customerName
ORDER BY total_payments DESC
LIMIT 10;
Insight: A small group of high-credit customers account for the majority of payments.

Warehouse Inventory Value
sql
SELECT w.warehouseName,
       SUM(p.quantityInStock * p.buyPrice) AS inventory_value
FROM warehouses w
JOIN products p ON w.warehouseCode = p.warehouseCode
GROUP BY w.warehouseName
ORDER BY inventory_value DESC;
Insight: The South warehouse holds the highest inventory value (~75% capacity), while the West warehouse is underutilized.

Order Status & Shipping
sql
SELECT status, COUNT(*) AS total_orders
FROM orders
GROUP BY status;
Insight: Most orders ship successfully, but disputes and cancellations highlight risks in customer satisfaction and credit management.

 Conclusions & Recommendations
 
Expand inventory capacity in South warehouse to avoid bottlenecks.

Prioritize high-credit customers with dedicated account managers.

Improve dispute resolution by monitoring order comments.

Diversify product focus beyond Classic Cars to grow Motorcycles and Planes.

Optimize shipping logistics to reduce delays and improve customer satisfaction.

 Portfolio Value
 
This project demonstrates:

Technical skill: SQL joins, aggregations, grouping, filtering, calculations.

Business acumen: Translating raw data into actionable insights.

Communication: Clear recommendations aligned with business strategy.
