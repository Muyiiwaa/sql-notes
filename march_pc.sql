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
-- 2. RETURN THE NAMES OF CUSTOMERS IN ALL UK CITIES EXCEPT LONDON
-- 3. RETURN THE LIST OF US ORDERS SENT IN DECEMBER 1997














