--Motor de base de datos utilizado: Postgre SQL

--1)¿Qué producto tiene el precio más alto? Devuelva una sola fila

SELECT product_name
FROM products_tiny
WHERE price=(SELECT MAX(price) FROM products_tiny)

--2)¿Qué cliente ha realizado más pedidos?

WITH ordenes AS (
SELECT CONCAT(first_name,' ',last_name) AS name, COUNT(order_id) AS ordenes
FROM customers c
JOIN orders o 
ON c.customer_id=o.customer_id
GROUP BY 1),
top AS (
SELECT name,ordenes,DENSE_RANK() OVER(ORDER BY ordenes DESC) AS rnk
FROM ordenes)
SELECT name
FROM top
WHERE rnk=1

--3)¿Cuál es el ingreso total por producto?

SELECT p.product_id,product_name,SUM(price*quantity) AS ingreso
FROM products_tiny p 
JOIN order_items o 
ON p.product_id=o.product_id
GROUP BY  1,2
ORDER BY ingreso DESC

--4)Encuentra el día con mayores ingresos.

SELECT order_date,COUNT(o.order_id) AS ordenes,SUM(price*quantity) AS ingreso
FROM orders o 
JOIN order_items oi 
ON o.order_id=oi.order_id
JOIN products_tiny p 
ON p.product_id=oi.product_id
GROUP BY order_date
ORDER BY ingreso DESC, ordenes DESC

--5)Encuentre el primer pedido (por fecha) para cada cliente.

WITH primera_orden AS (
SELECT CONCAT(first_name,' ',last_name) AS name, product_name,
DENSE_RANK() OVER(PARTITION BY first_name,last_name ORDER BY order_date) AS rnk
FROM customers c
JOIN orders o
ON c.customer_id=o.customer_id
JOIN order_items oi 
ON o.order_id=oi.order_id
JOIN products_tiny p 
ON p.product_id=oi.product_id)
SELECT name, string_agg(product_name, ',') AS productos_ordenados_1ero
FROM primera_orden
WHERE rnk=1
GROUP BY 1

--6)Encuentre los 3 principales clientes que han pedido la mayor cantidad de productos distintos

WITH customer AS (
SELECT CONCAT(first_name,' ',last_name) AS name,COUNT(DISTINCT(product_id)) AS productos_distintos
FROM customers c 
JOIN orders o 
ON c.customer_id=o.customer_id
JOIN order_items oi 
ON oi.order_id=o.order_id
GROUP BY 1)
SELECT name,productos_distintos,
DENSE_RANK() OVER(ORDER BY productos_distintos DESC) AS rnk
FROM customer

--7)¿Qué producto se ha comprado menos en cantidad?

WITH productos AS (
SELECT product_name,SUM(quantity) AS total_qty
FROM products_tiny p 
JOIN order_items o 
ON p.product_id=o.product_id
GROUP BY product_name),
menos_comprado AS (
SELECT product_name,
DENSE_RANK() OVER(ORDER BY total_qty ASC) AS rnk
FROM productos)
SELECT 
string_agg(product_name, ' , ') AS productos_menos_comprados
FROM menos_comprado
where rnk = 1

--8)¿Cuál es la mediana del pedido total?

WITH pedido_total AS (
SELECT quantity*price AS total
FROM products_tiny p 
JOIN order_items oi 
ON p.product_id=oi.product_id)
SELECT
PERCENTILE_CONT(0.5)  within group (order by total)
FROM pedido_total

--9)Para cada pedido, determine si fue "Caro" (en total más de 300), "Asequible" (en total más de 100) o "Barato".

SELECT
order_id,
SUM(price*quantity) AS monto_pedido,
CASE WHEN SUM(price*quantity) > 300 THEN 'Caro'
     WHEN SUM(price*quantity) > 100 AND SUM(price*quantity) <= 300 THEN 'Asequible'
	 ELSE 'Barato' END AS Segmentacion
FROM products_tiny p 
JOIN order_items o 
ON p.product_id=o.product_id
GROUP BY  1
ORDER BY  1


--10)Encuentre clientes que hayan pedido el producto con el precio más alto.

SELECT CONCAT(first_name,' ',last_name) AS name,
product_name
FROM customers c 
JOIN orders o 
ON c.customer_id=o.customer_id
JOIN order_items oi 
ON oi.order_id=o.order_id
JOIN products_tiny p 
ON p.product_id=oi.product_id
WHERE price=(SELECT MAX(price) FROM products_tiny)
