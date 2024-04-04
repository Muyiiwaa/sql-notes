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

-- JOINS (INNER, LEFT, RIGHT, SELF)

-- return the names of the top 5 best performing employees in terms of revenue

SELECT firstname, lastname, sum(unitprice * quantity) as revenue
FROM `order details` as od
JOIN orders as o on o.orderid = od.OrderID
JOIN employees as e on e.EmployeeID = o.EmployeeID
GROUP BY firstName, lastName
ORDER BY revenue DESC
LIMIT 5;

-- return the names of the top 3 best selling products
-- in terms of number of orders and quantity sold

select productname, count(orderid) as no_orders, sum(quantity) as total_quantity
FROM `order details` as od
JOIN products as p on p.productid = od.ProductID
GROUP BY ProductName
ORDER BY no_orders DESC, total_quantity DESC
LIMIT 5;

-- return the top 10 customers with the highest purchase and the total
-- amount they paid in freight.

select companyname, count(orderid) as no_orders,
    sum(freight) as total_freight
FROM orders as o
JOIN customers as c on c.CustomerID = o.CustomerID
GROUP BY CompanyName
ORDER BY no_orders DESC
LIMIT 10;


-- LEFT AND RIGHT JOIN

-- return the names of customers and the number of orders they have
-- bought from us

SELECT companyname, count(orderid) as no_orders
FROM orders as o
JOIN customers as c on c.CustomerID = o.CustomerID
GROUP BY CompanyName
ORDER BY no_orders;

-- return the names of customers that has never bought anything from us
-- left join solution
SELECT companyname, count(orderid) as no_orders
FROM customers as c
LEFT JOIN orders as o on o.CustomerID = c.CustomerID
GROUP BY CompanyName
HAVING no_orders = 0
ORDER BY no_orders;

-- right join solution
SELECT companyname, count(orderid) as no_orders
FROM orders as o
RIGHT JOIN customers as c on c.CustomerID = o.CustomerID
GROUP BY CompanyName
HAVING no_orders = 0
ORDER BY no_orders;


-- SELF JOIN

-- return the name of employees and the name of their manager 
select staff.firstname as staff_name, manager.firstname as manager_name
from employees as staff
left join employees as manager on manager.employeeId = staff.ReportsTo;


-- ASSIGNMENT 
-- solution
-- return the names of employees that were hired ealier than their manager
select staff.firstname as staff_name, staff.hiredate as employees_hiredate,
     manager.firstname as manager_name, manager.hiredate as manager_hiredate
from employees as staff
left join employees as manager on manager.employeeId = staff.ReportsTo
WHERE staff.hiredate < manager.hiredate;



-- SUBQUERIES,Functions AND CTEs

-- FUNCTIONS

-- return the full names of employees that were hired ealier than their manager
select concat(e.firstname, ' ', e.lastname) as fullname, 
    e.hiredate as employees_hiredate,
    concat(m.firstname, ' ', m.lastname) as manager,
    m.hiredate as m_hiredate
from employees as e
left join employees as m on m.employeeId = e.ReportsTo
WHERE e.hiredate < m.hiredate;

-- return the total number orders and revenue generated by each employee in
-- the second quarter of 1997

SELECT concat(e.firstname,' ', e.lastname) as employee,
    count(o.orderid) as no_orders, sum(unitprice * quantity) as revenue
FROM `order details` as od
JOIN orders as o on o.orderid = od.OrderID
JOIN employees as e on e.EmployeeID = o.EmployeeID
WHERE YEAR(orderdate) = 1997 and 
    (MONTH(orderDate) >= 4  and MONTH(orderDate) <= 6)
GROUP BY employee
ORDER BY no_orders DESC, revenue DESC;


-- SUBQUERIES 

-- return the names of customers that has never bought anything from us

SELECT distinct companyname
FROM customers 
WHERE NOT CustomerID IN (
    SELECT DISTINCT CustomerID
    FROM orders
);

-- return the names and salaries of employees that earns above average

SELECT concat(firstname, ' ', lastname) as fullname,salary
FROM employees
WHERE salary > (
    select avg(salary)
    from employees
);

-- return the names and salaries of employees that earns above average and the
-- percentage difference

with cte_1 as (
    SELECT concat(firstname, ' ', lastname) as fullname,salary,
        round(((salary - (
            select avg(salary)
            from employees))/salary) * 100, 2) as percentage_diff
    FROM employees
    WHERE salary > (
        select avg(salary)
        from employees)
)
select fullname, salary, concat(percentage_diff, '%') as percent_diff
from cte_1;

-- return the names of employees and the number of lated deliveries they were
-- responsible for
with cte_1 as (
select concat(e.firstname, ' ', e.lastname) as employees,
    o.orderid, datediff(o.shippedDate, o.requireddate) as no_of_days,
    o.shippedDate, o.requireddate 
from orders o
join employees e on e.employeeId = o.employeeId
where o.shippedDate > o.requireddate
)
select employees, count(orderid) as no_of_times, avg(no_of_days) as avg_days
from cte_1
GROUP BY employees
order BY no_of_times desc, avg_days desc;

-- EXECRCISE 
-- extend the last solution to generate the percentage of late deliveries by each
-- employee



















