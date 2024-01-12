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








