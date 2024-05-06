-- PULLING DATA WITHOUT CONTEXT


-- q1. query that returns the names, salary and country of all our employees

select firstname,lastname,salary,country
FROM employees;

-- pulling data with context

-- return the names, salary and title of employees living in the UK.

SELECT firstname, lastname, salary,title,Country
FROM employees
WHERE Country = 'UK';

-- return the orderid,orderdate,freight cost and city of all orders sent to canada

select orderid,orderdate,freight,shipcity,shipCountry
FROM orders
where ShipCountry = 'Canada';

-- LOGICAL OPERATORS (AND, OR, NOT)

-- return the orderid, city and freight cost of orders sent to Mexico with freight
-- below 50

SELECT orderid, shipcity, freight, shipCountry
FROM orders
WHERE Freight < 50 and ShipCountry = 'Mexico';

-- return the names of female employees in our companies

select firstName, lastname, TitleOfCourtesy
from employees
WHERE TitleOfCourtesy = 'Ms.' OR TitleOfCourtesy = 'Mrs.';

-- method 2

select firstname, lastname, TitleOfCourtesy
from employees
WHERE TitleOfCourtesy IN ('Mrs.','Ms.');

-- return the names of customers that are not based in US

SELECT companyname, contactname, country
FROM customers
WHERE not country = 'USA';

-- handling date ranges

-- return the orderid, orderdate, city and country of all orders sent to canada
-- in the first quarter of 1997

select orderid, orderdate, shipcity, shipCountry
FROM orders
where (ShipCountry = 'Canada') AND
    (orderDate BETWEEN '1997-01-01' and '1997-03-31');

-- EXERCISE 

-- 1. RETURN THE NAMES OF PRODUCTS COSTING MORE THAN 20 DOLLARS THAT WE HAVE 
-- IN STOCK

SELECT productname, unitprice,unitsinstock
FROM products
WHERE unitprice > 20 and UnitsInStock > 0;
-- 2. RETURN THE NAMES OF CUSTOMERS IN ALL UK CITIES EXCEPT LONDON

SELECT companyname,contactname,city,country
FROM customers
WHERE country = 'UK' AND city != "London";

-- 3. RETURN THE LIST OF US ORDERS SENT IN DECEMBER 1997

SELECT *
FROM orders
WHERE (ShipCountry = "USA") AND 
    (shippedDate BETWEEN "1997-12-01" AND "1997-12-31");

-- SORTING AND AGGREGATION

-- return the orderid, productid and total cost of the top 10 most expensive orders

SELECT orderid, productid, (unitprice *  quantity) as total_cost
FROM `order details` 
ORDER BY UnitPrice * Quantity DESC
LIMIT 10;

-- return the top five most expensive freight paid on orders
-- sent to the united states

SELECT orderid, freight, shipCountry
FROM orders
WHERE ShipCountry = "USA"
ORDER BY Freight DESC
LIMIT 5;

-- return the names and title of the 3 lowest paid employees in the company
SELECT firstname, lastname, salary
from employees
ORDER BY salary
limit 3;

-- performance
-- efficiency
-- readability verbose

-- AGGREGATION (SUM, MIN, MAX, COUNT, AVG)

--  return the total number of orders sent to canada

SELECT COUNT(orderid) as total_orders
FROM orders
WHERE ShipCountry = 'Canada';

-- return the value of the highest amount ever paid in salary
SELECT MAX(salary) as highest_salary
FROM employees;

-- return the amount it costs on average to ship to Mexico

SELECT AVG(freight) as average_freight
FROM orders
where ShipCountry = 'Mexico';

--  GROUPING WITH AGGREGATION

-- return the top 5 most expensive countries to ship to on average
SELECT shipCountry, AVG(freight) as average_freight
FROM orders
GROUP BY ShipCountry
ORDER BY average_freight DESC
LIMIT 5;

-- return the top 7 best performing cities in terms of total freight revenue
-- and number of orders sold

SELECT shipCountry, sum(freight) as total_freight, count(OrderID) as no_orders
from orders
GROUP BY ShipCountry
ORDER BY total_freight desc
LIMIT 7;


-- ASSIGNMENT
-- solution
-- RETURN THE NUMBER OF CUSTOMERS WE HAVE IN EACH COUNTRY
select country, count(customerid) as no_of_customers
FROM customers
GROUP BY country;
-- RETURN THE NUMBER OF EMPLOYEES WE HAVE IN EACH COUNTRY
SELECT country, count(employeeid) as no_of_employees
FROM employees
GROUP BY country;


-- return the names of the top 5 best performing employees in terms of revenue
SELECT firstname, lastname, sum(unitprice*quantity) as revenue
FROM orders
JOIN `order details` ON `order details`.OrderID = orders.OrderID
JOIN employees on employees.EmployeeID = orders.EmployeeID
GROUP BY firstName, LastName
ORDER BY revenue DESC
LIMIT 5;


-- return the names of the top 3 best selling products
-- in terms of number of orders and quantity sold

SELECT productname, count(products.ProductID) as no_of_times, sum(Quantity) as total_quantity
FROM `order details`
JOIN products ON products.ProductID = `order details`.ProductID
GROUP BY productName
ORDER BY no_of_times DESC, total_quantity desc
LIMIT 3;

-- return the list of the orders sent to canada in 1997 and the names of
-- the employees responsible for the order

select firstname, lastname, orderid, orderdate, shipCountry
from orders
JOIN employees ON employees.EmployeeID = orders.EmployeeID
WHERE year(orderdate) = 1997 AND ShipCountry = 'Canada';


-- return the top 10 customers with the highest purchase and the total
-- amount they paid in freight.
select contactname, sum(unitprice * quantity) as max_spent, 
    sum(freight) as total_freight
from `order details`
JOIN orders on orders.orderid = `order details`.OrderID
JOIN customers on customers.CustomerID = orders.CustomerID
GROUP BY ContactName
ORDER BY max_spent desc
limit 10;

-- soluions to the assignment

-- Create a report that shows the SupplierID, CompanyName, CategoryName, 
-- ProductName and UnitPrice from the products,suppliers and categories table

SELECT products.SupplierID, companyname, CategoryName, productName, unitprice
FROM products
JOIN suppliers on suppliers.SupplierID = products.SupplierID
JOIN categories on categories.categoryID = products.categoryID;

--Create a report that shows the OrderID ContactName,
-- UnitPrice, Quantity, Discount from the order details, orders and
-- customers table with discount given on every purchase.

select orders.OrderID ContactName,unitprice, quantity, discount
FROM `order details`
JOIN orders on orders.orderid = `order details`.OrderID
join customers on customers.customerid = orders.CustomerID;


-- LEFT AND RIGHT JOIN
-- return the names of customers and the number of orders they have
-- bought from us

SELECT companyname, contactname, count(orderid) as no_of_orders
FROM customers
LEFT JOIN orders ON orders.CustomerID = customers.CustomerID
GROUP BY CompanyName, contactname
ORDER BY no_of_orders;



-- return the names of customers that has never bought anything from us
-- left join solution

SELECT companyname, contactname, count(orderid) as no_of_orders
FROM customers 
LEFT JOIN orders ON orders.CustomerID = customers.CustomerID
WHERE OrderID is NULL
GROUP BY CompanyName, contactname
ORDER BY no_of_orders
;

-- right join
SELECT companyname, contactname, count(orderid) as no_of_orders
FROM orders 
RIGHT JOIN customers ON customers.CustomerID = orders.CustomerID
WHERE OrderID is NULL
GROUP BY CompanyName, contactname
ORDER BY no_of_orders
;


-- assignment
--  ProductDetails that shows the ProductID, CompanyName, ProductName, 
-- CategoryName, Description,QuantityPerUnit, UnitPrice,
-- UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued from the supplier, 
-- products and categories tables.




















-- SELF JOIN

-- return the name of employees and the name of their manager 



-- ASSIGNMENT 
-- solution
-- return the names of employees that were hired ealier than their manager




-- SUBQUERIES,Functions AND CTEs

-- FUNCTIONS

-- return the full names of employees that were hired ealier than their manager


-- return the total number orders and revenue generated by each employee in
-- the second quarter of 1997



-- SUBQUERIES 

-- return the names of customers that has never bought anything from us



-- return the names and salaries of employees that earns above average


-- return the names and salaries of employees that earns above average and the
-- percentage difference


-- return the names of employees and the number of lated deliveries they were
-- responsible for

-- EXECRCISE 
-- extend the last solution to generate the percentage of late deliveries by each
-- employee
















