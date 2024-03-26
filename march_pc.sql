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











