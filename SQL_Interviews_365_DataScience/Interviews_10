--Encuentre el cliente con el costo total de pedido más alto entre 2019-02-01 y 2019-05-01. MuestrE su nombre, el costo total de los artículos y la fecha.
--Suponga que cada nombre en el conjunto de datos es único y que los clientes pueden realizar varios pedidos en la misma fecha.
--Tablas: customers, orders

--Solución 1:
WITH tmp as(
SELECT c.first_name, o.order_date, 
sum((o.order_cost * o.order_quantity)) as total_cost
FROM interviews.customers c 
JOIN interviews.orders o ON (c.id = o.cust_id)
WHERE order_date between '2019-02-01' and '2019-05-01'
group by 1,2
)
SELECT first_name, order_date, total_cost
FROM tmp
WHERE total_cost = (SELECT MAX(total_cost) FROM tmp)

--Solución 2: 
WITH tmp as(
SELECT c.first_name, o.order_date, 
sum((o.order_cost * o.order_quantity)) as total_cost
FROM interviews.customers c 
JOIN interviews.orders o ON (c.id = o.cust_id)
WHERE order_date between '2019-02-01' and '2019-05-01'
group by 1,2
),
ranked as(
select first_name, order_date,total_cost,
DENSE_RANK() OVER(ORDER BY total_cost desc) AS rank_customers 
FROM tmp
)
select first_name, order_date,total_cost
FROM ranked
WHERE rank_customers  = 1 
