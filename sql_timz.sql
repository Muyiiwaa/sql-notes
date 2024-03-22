use levels;


-- select, from, where, order by, limit.

-- returns the names of employees in the company

SELECT firstname, lastname,title
from employee;

-- returns the names of employees that are sales manager

SELECT firstname, lastname, title
FROM employee
WHERE title = 'Sales Manager';

-- return the top 10 orders with the highest freight cost

SELECT *
FROM salesorder
ORDER BY freight DESC
LIMIT 10;

-- return the top 10 most expensive orders ever sold

SELECT *
from orderdetail
ORDER BY (unitPrice * quantity) DESC
LIMIT 10;

-- return the names, address,city and country of our customers in france

SELECT companyname, contactname,city,country
FROM customer
WHERE country = 'France';

-- AGGREGATION (SUM, COUNT, MIN, MAX, AVG)

-- return the total number of orders we sent to canada
SELECT count(orderid) as no_of_canada_orders
FROM salesorder
WHERE shipCountry = 'Canada';

-- returns the total amount spent on delivery to the uk

select sum(freight) as UK_total_freight
FROM salesorder
WHERE shipCountry = 'UK';


-- return the details of the least expensive product in our inventory

select min(unitprice)
from product;

select *
FROM product
where unitPrice = 2.50;

-- return the details of the order with the most expensive freight charge

select max(freight)
FROM salesorder;

SELECT *
from salesorder
WHERE freight = 1007.64;

-- 2nd method 

select *
from salesorder
ORDER BY freight ASC
LIMIT 1;

-- how much does it cost on average to send a good to london

SELECT AVG(freight) as London_charges
FROM salesorder
WHERE shipCity = 'London';

-- GROUPING

-- what does it cost on average to send goods to each city

SELECT shipCity, AVG(freight) as average_freight
FROM salesorder
GROUP BY shipCity;

-- the most expensive cities to ship to (top 5)
SELECT shipCity, AVG(freight) as average_freight
FROM salesorder
GROUP BY shipCity
ORDER BY average_freight DESC
limit 5;

-- return the number of orders that has been sent to each country

SELECT shipCountry, count(orderid) as no_of_orders
FROM salesorder
GROUP BY shipCountry
ORDER BY no_of_orders desc;

-- exercise.
-- return the no of employees that we have in each country
-- return the top 10 cities with most customers