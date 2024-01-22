-- GROUP BY --
-- write a query that returns the total number of orders sent to each city in the US.

SELECT shipcity, count(orderid) as `total US orders`
from orders
where ShipCountry = 'USA'
GROUP BY ShipCity
ORDER BY count(orderid) DESC;

-- return the top 7 most expensive cities to ship to on average and the number of orders
-- we've sent there

SELECT shipcity, AVG(freight) as `average freight`, count(orderid) as `No of orders`
FROM orders
GROUP BY ShipCity
ORDER BY `average freight` DESC
LIMIT 7;


-- returns the top 4 best performing countries in terms of number of orders.


SELECT ShipCountry, count(orderid) as no_of_orders
FROM orders
GROUP BY 1
ORDER BY 2 DESC
LIMIT 4;

--  JOINS --

/*

1. Inner Join (Join)
2. Left Join
3. Right Join
4. Self Join

*/

-- returns the top 5 most expensive freight cost ever paid, the country the order
-- went to and the employee responsible for the transaction.

SELECT firstname, lastname, freight, ShipCountry
FROM orders
JOIN employees on employees.employeeid = orders.employeeid
ORDER BY Freight DESC
LIMIT 5;

-- write a query that returns the names of the top 5 best performing employees
-- in terms of revenue generated

SELECT firstname, lastname, sum(unitprice * quantity) as revenue
FROM `order details`
JOIN orders on orders.OrderID = `order details`.OrderID
JOIN employees on employees.EmployeeID = orders.EmployeeID
GROUP BY firstname, lastname
ORDER BY revenue DESC
LIMIT 5;

-- query that returns the top 5 best performing cities in terms of revenue generated
-- in the last quarter of 1997






