-- return the names of customers that has never bought anything from us

-- right join solution
select c.customerid, c.companyname
from orders as o
right join customers as c on o.customerid = c.customerid
where o.orderid IS NULL
ORDER BY o.freight;

-- left join solution
select c.customerid, c.companyname
from customers c
left join orders o on o.customerid = c.customerid
where o.orderid IS NULL
ORDER BY o.freight;


-- query that returns the name of employees and the name of their managers

-- self join

select s.firstname as staff,  m.firstname as manager
from employees s 
left join employees m on m.EmployeeID = s.reportsTo;

-- query that returns the name, salary of staff and managers. Only for staff that
-- collect more salary than their managers. Also return the percentage difference
-- in salary.

select concat_ws(' ', s.firstname, s.lastname) as staff, s.salary,
    concat_ws(' ', m.firstname, m.lastname) as managers, m.salary,
    round(((s.Salary - m.Salary)/m.Salary) * 100, 2) as percentage_difference
from employees s 
join employees m on m.EmployeeID = s.reportsTo
WHERE s.Salary > m.Salary;




