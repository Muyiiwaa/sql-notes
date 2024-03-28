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

-- RETURN THE NUMBER OF CUSTOMERS WE HAVE IN EACH COUNTRY
-- RETURN THE NUMBER OF EMPLOYEES WE HAVE IN EACH COUNTRY


























