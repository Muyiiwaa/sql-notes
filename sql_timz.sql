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



-- JOINS  ---
/*
1. Inner join
2. left join
3. right join
4. self join
5. full outer join
*/

-- return the names of the top 10 most active customers in terms of number of orders

select companyname, count(orderid) as no_of_orders
from salesorder
JOIN customer on customer.custId = salesorder.custId
GROUP BY companyname
ORDER by no_of_orders DESC
LIMIT 10;

-- the names of the top 5 best performing cities in terms of revenue generated
-- in the last quarter of 2006

select shipCity, sum(unitprice * quantity) as total_Q4_revenue
from orderdetail
JOIN salesorder on salesorder.orderId = orderdetail.orderId
WHERE orderDate BETWEEN '2006-10-01' and '2006-12-31'
GROUP BY shipCity
ORDER BY total_Q4_revenue DESC
limit 5;

-- return the top 7 most expensive orders ever sold and the details of the employee
-- responsible for selling them.

select firstname, lastname, (unitprice * quantity) as total_cost
FROM orderdetail
JOIN salesorder on salesorder.orderId = orderdetail.orderId
JOIN employee on employee.employeeId = salesorder.employeeId
ORDER BY total_cost DESC
LIMIT 7;

-- return the details of customers that has never patronized the company
SELECT companyname, shipCity, freight
from customer
LEFT JOIN salesorder on salesorder.custId = customer.custId
WHERE freight is NULL;

-- solve with right join
select companyname, shipcity, freight
from salesorder
RIGHT JOIN customer on customer.custId = salesorder.custId
WHERE freight is NULL;

-- self join

-- return the name of every employee and who they report to.

select employee.firstname, manager.firstname as manager_name
from employee
left JOIN employee as manager on manager.employeeId = employee.mgrid;

-- return the names of managers and the number of people answering to them


SELECT manager.firstname, manager.lastname,
    count(employee.firstname) as no_of_employees
FROM employee
LEFT JOIN employee as manager on manager.employeeId = employee.mgrId
GROUP BY manager.firstname, manager.lastname;


-- Exercise
-- return the names of employees and the number of orders they have sent to US.




