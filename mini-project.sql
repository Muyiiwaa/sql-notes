with cte_1 as(
    SELECT c.customerid, c.companyname, sum(od.quantity * od.UnitPrice) as order_total
    from `order details` od 
    JOIN orders o on o.OrderID = od.OrderID
    JOIN customers c ON c.customerid = o.customerid
    WHERE year(o.orderDate) = 1997
    GROUP BY c.companyname, c.customerid
),
cte_2 as (
    select customerid,companyname, order_total, 
        CASE
            WHEN order_total < 1000 THEN 'Tier 1'
            WHEN order_total < 5000 THEN 'Tier 2'
            WHEN order_total < 10000 THEN 'Tier 3'
            ELSE 'Tier 4'
        END as customergroup
    FROM cte_1
)
SELECT customergroup,count(customerid) as no_customers, round(count(customerid)/(
                        select count(distinct customerid) 
                        from orders
                        WHERE year(orderdate) = 1997) * 100, 2) as percentage_
FROM cte_2
GROUP BY customergroup
order by no_customers
;
--



