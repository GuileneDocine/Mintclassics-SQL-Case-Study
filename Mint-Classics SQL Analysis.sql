-- Mint Classics SQL Case Study
-- Master Analysis Script

/* ============================
   CUSTOMER ANALYSIS
   ============================ */

-- Customer distribution by country
SELECT country, COUNT(*) AS num_customers
FROM customers
GROUP BY country
ORDER BY num_customers DESC;

-- Top 5 customers by credit limit
SELECT customerName, country, creditLimit
FROM customers
ORDER BY creditLimit DESC
LIMIT 5;


/* ============================
   ORDER ANALYSIS
   ============================ */

-- Orders by status
SELECT status, COUNT(*) AS total_orders
FROM orders
GROUP BY status;

-- Average shipping delay (days)
SELECT AVG(DATEDIFF(shippedDate, orderDate)) AS avg_shipping_days
FROM orders
WHERE shippedDate IS NOT NULL;


/* ============================
   PAYMENT ANALYSIS
   ============================ */

-- Top 10 customers by total payments
SELECT c.customerName,
       SUM(p.amount) AS total_payments
FROM customers c
JOIN payments p ON c.customerNumber = p.customerNumber
GROUP BY c.customerName
ORDER BY total_payments DESC
LIMIT 10;

-- Payments by year
SELECT YEAR(paymentDate) AS year,
       SUM(amount) AS total_amount
FROM payments
GROUP BY YEAR(paymentDate)
ORDER BY year;


/* ============================
   PRODUCT & PRODUCT LINE ANALYSIS
   ============================ */

-- Revenue by product line
SELECT pl.productLine,
       SUM(od.quantityOrdered * od.priceEach) AS total_revenue
FROM productlines pl
JOIN products p ON pl.productLine = p.productLine
JOIN orderdetails od ON p.productCode = od.productCode
GROUP BY pl.productLine
ORDER BY total_revenue DESC;

-- Top 10 products by revenue
SELECT p.productName,
       SUM(od.quantityOrdered * od.priceEach) AS total_revenue
FROM products p
JOIN orderdetails od ON p.productCode = od.productCode
GROUP BY p.productName
ORDER BY total_revenue DESC
LIMIT 10;

-- Inventory risk: low stock but high sales
SELECT p.productName, p.quantityInStock,
       SUM(od.quantityOrdered) AS total_units_sold
FROM products p
JOIN orderdetails od ON p.productCode = od.productCode
GROUP BY p.productName, p.quantityInStock
HAVING p.quantityInStock < 500 AND total_units_sold > 2000
ORDER BY total_units_sold DESC;


/* ============================
   WAREHOUSE ANALYSIS
   ============================ */

-- Inventory by warehouse
SELECT w.warehouseName,
       SUM(p.quantityInStock) AS total_units
FROM warehouses w
JOIN products p ON w.warehouseCode = p.warehouseCode
GROUP BY w.warehouseName
ORDER BY total_units DESC;

-- Inventory value by warehouse
SELECT w.warehouseName,
       SUM(p.quantityInStock * p.buyPrice) AS inventory_value
FROM warehouses w
JOIN products p ON w.warehouseCode = p.warehouseCode
GROUP BY w.warehouseName
ORDER BY inventory_value DESC;

-- Capacity utilization check
SELECT w.warehouseName,
       w.warehousePctCap,
       SUM(p.quantityInStock) AS total_units
FROM warehouses w
JOIN products p ON w.warehouseCode = p.warehouseCode
GROUP BY w.warehouseName, w.warehousePctCap;



