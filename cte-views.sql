-- common table expression

-- query that returns the number of customers and suppliers we have
-- in each country
with cust_cte as (
    SELECT country, count(customerid) as no_of_customers
    from customers
    GROUP BY country
),
suppliers_cte as (
    SELECT country, count(supplierid) as no_of_suppliers
    from suppliers
    GROUP BY country
)
select k.country, k.no_of_customers,
    case
        when z.no_of_suppliers is null then 0
        else z.no_of_suppliers
    end as no_of_suppliers
from cust_cte k
left join suppliers_cte z on z.country = k.country
where not k.country is NULL;


-- returns the name of employees, year of service and their retirement
-- status

SELECT CONCAT(firstname, ' ', lastname) as fullname,
    year(now()) - YEAR(hiredate) as service_year,
    CASE 
        WHEN YEAR(NOW()) - YEAR(hiredate) <= 30 THEN 'Not Due'
        ELSE 'Due'
    END as retirement_status
FROM employees;

-- return the name of employees and the number of times they
-- are responsible for late deliveries.
WITH cte_1 as (
    SELECT concat_ws(' ', e.firstname,e.lastname) as fullname,
        DATEDIFF(o.requireddate, o.shippeddate) as waiting_days
    FROM orders o
    JOIN employees e on e.`EmployeeID` = o.`EmployeeID`
    WHERE DATEDIFF(o.requireddate, o.shippeddate) < 0
)
SELECT fullname, COUNT(fullname) as `no_of_times`
FROM cte_1
WHERE fullname in (
    select CONCAT_WS(' ', firstname, lastname)
    FROM employees
    WHERE YEAR(NOW()) - YEAR(`BirthDate`) > 70
)
GROUP BY fullname
ORDER BY no_of_times DESC;

-- how many times an employee is responsible for late delivery of priority orders

WITH cte_1 as (
    SELECT od.orderid, CONCAT_WS(' ',e.firstname, e.lastname) as fullname,
        DATEDIFF(o.requireddate, o.shippeddate) as days,
        od.unitprice * od.quantity as order_value
    FROM orders o
    JOIN `order details` od on od.orderid = o.orderid
    JOIN employees e on e.employeeid = o.employeeid
    WHERE o.shippeddate > o.requireddate and 
        od.unitprice * od.quantity > (
            select avg(unitprice * quantity)
            from `order details`)
            )
select fullname, count(distinct orderid) as no_of_times
from cte_1
GROUP BY fullname
ORDER BY no_of_times;


-- hackerrank challenge solution
with cte_1 as(
    select h.hacker_id, h.name, count(c.challenge_id) as no_chall
    from challenges c
    join hackers h on h.hacker_id = c.hacker_id
    group by h.hacker_id, h.name
    order by 3 desc
),
cte_2 as (
    select no_chall, count(no_chall) as frequency
    from cte_1
    group by no_chall
)
select a.hacker_id, a.name, a.no_chall
from cte_1 a
join cte_2 b on b.no_chall = a.no_chall
where a.no_chall =(
    select max(no_chall)
    from cte_1
)
    or b.frequency = 1
order by a.no_chall desc, a.hacker_id;

-- 74.	What is the total quantity of each product that has been ordered 
-- by customers in the year 1998 and has not been discontinued?


-- 72.	What is the total revenue earned by 
-- each category of products in the year 1998?





