-- What is the total quantity of each product that 
-- has been ordered by customers in the year 1997
-- and has not been discontinued?

SELECT p.productname, sum(od.quantity) as total_quantity
from `order details` od
JOIN orders o on o.`OrderID` = od.`OrderID`
JOIN products p on p.`ProductID` = od.`ProductID`
WHERE YEAR(o.`OrderDate`) = 1997
GROUP BY p.`ProductName`
ORDER BY total_quantity;

-- return the top 5 best performing employees 
-- in terms of revenue and number of orders sold

SELECT CONCAT_WS(' ', e.firstname, e.lastname) as full_name,
    round(sum(od.unitprice * od.quantity), 2) as total_revenue,
    count(o.orderid) as no_of_orders,
    round(avg(od.unitprice * od.quantity), 2) as average_revenue
FROM `order details` od
join orders o on o.`OrderID` = od.`OrderID`
join employees e on e.`EmployeeID` = o.`EmployeeID`
GROUP BY full_name
ORDER BY total_revenue desc;



-- Create a report that shows the EmployeeID, 
-- the LastName and FirstName as employee, and the LastName and FirstName of
-- who they report to as manager from the employees table 
-- sorted by Employee





