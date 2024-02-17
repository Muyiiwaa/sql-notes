-- FUNCTIONS

-- return the products that were not sold in CANADA in 1996

SELECT *
FROM products
where not productid in (
    SELECT productid
    FROM `order details`
    WHERE orderid in (
        SELECT orderid
        from orders
        where shipcountry = "Canada" and 
            orderdate BETWEEN "1996-01-01" and "1996-12-31"
    )
);

select distinct p.productid, p.productname, o.shipcountry,o.orderdate
from `order details` od
join orders o on o.orderid = od.OrderID
join products p on p.ProductID = od.ProductID
where not o.ShipCountry = 'Canada' and 
   not o.orderdate BETWEEN '1996-01-01' and '1996-12-31'

ORDER BY p.productid;


-- FUNCTIONS 

-- query that returns the name of our employees and the years they have spent in the
-- company.

SELECT CONCAT_WS('-', firstname,lastname) as fullname,
    concat_ws(' ',YEAR(Now()) - YEAR(HireDate),'years')  as service_year
FROM employees;

-- return the name of employees, their current age and their age when employed.
SELECT CONCAT_WS('-', firstname,lastname) as fullname,
    concat_ws(' ',YEAR(Now()) - YEAR(BirthDate),'years')  as age_year,
    concat_ws(' ',YEAR(HireDate) - YEAR(BirthDate),'years')  as service_year
FROM employees;

-- returns the list of orders that were delivered late and the number of days it took
select orderid,EmployeeID, shipcountry, shippeddate, requireddate,
    datediff(shippedDate, requiredDate) as extra_days
from orders
where shippedDate > requiredDate;

-- return the name of the top 3 employees wwith most late deliveries
select firstname, lastname, count(orderid) as no_of_orders
from orders o
JOIN employees e on e.EmployeeID = o.EmployeeID
where shippedDate > requiredDate
GROUP BY firstName, lastname
ORDER BY no_of_orders DESC
LIMIT 5;

-- use any 10 functions listed at the beginning of the class to solve any 5 business
-- query of your choice

-- FUNCTIONS --


-- return the list of product that were not sold in canada in 1997

SELECT distinct ProductID, productname
FROM (
    SELECT od.productid, p.productname, o.shipcountry, year(o.orderdate) as years
    FROM `order details` od
    JOIN orders o on o.orderid = od.orderid
    JOIN products p on p.productid = od.ProductID
    where (o.shipcountry != 'Canada') and (year(orderdate) = 1997)) as temp_table
    ;

-- write a query that returns the number of days it takes to deliver an order for 
-- orders that were delivered late

SELECT shipcountry, requiredDate, shippedDate,shipcity, 
    datediff(requireddate, shippeddate) as `extra days`
FROM orders
where shippedDate > requiredDate;

-- write a query that returns the names of top 4 employees with most late deliveries.
-- and their average waiting days

SELECT fullname, count(orderid) as no_of_times, avg(extra_days) as average_extra_days
FROM (
    SELECT CONCAT_WS(' ', e.firstName,e.lastname) as fullname,
        o.orderid, datediff(shippedDate, requireddate) as extra_days
    FROM orders o
    JOIN employees e on e.EmployeeID = o.EmployeeID
    WHERE shippedDate > requiredDate) as temp_table
GROUP BY fullname
ORDER BY no_of_times DESC
LIMIT 4;


-- write a query that returns the list of orders that were sold on the last day of every
-- month in 1997

SELECT orderid, orderdate
from orders
WHERE orderdate = last_day(orderdate);

-- we want to see the names of employees reponsible for the most last day orders
-- and the number of such order they have processed


SELECT fullname,  concat(round((no_of_times/(
    SELECT count(orderid)
    from orders)) * 100, 2), '%') as percentage_late
FROM (
    SELECT CONCAT_WS(' ', e.firstname, e.lastname) as fullname,
        count(orderid) as no_of_times
    FROM orders o
    JOIN employees e on e.EmployeeID = o.EmployeeID
    WHERE orderdate = last_day(orderDate)
    GROUP BY fullname
    ORDER BY no_of_times desc) as temp_table;


-- CONDITIONAL FUNCTIONS aka CASE

SELECT CONCAT_WS(' ', firstName, lastname) as fullname,
    year(now()) - year(HireDate) as service_year,
    CASE 
        WHEN year(now()) - year(HireDate) < 31 THEN 'Not due for retirement'
        ELSE 'Due for retirement'
    END as statuss
FROM employees;
























