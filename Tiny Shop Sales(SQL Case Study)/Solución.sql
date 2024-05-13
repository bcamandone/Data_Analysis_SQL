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
