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
