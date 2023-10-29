 --1) ¿Cuál es la cantidad total que gastó cada cliente en el restaurante?
 
SELECT SUM(e.price) as total_gastado, s.customer_id
FROM "menu" e 
JOIN sales s ON (e.product_id = s.product_id)
GROUP BY s.customer_id
ORDER BY s.customer_id

--2) ¿Cuántos días ha visitado cada cliente el restaurante?

SELECT count(distinct(EXTRACT(DAY FROM order_date))) as cantidad_visitas, customer_id
FROM "sales" 
GROUP BY customer_id
ORDER BY customer_id

--3) ¿Cuál fue el primer artículo del menú comprado por cada cliente?

SELECT e.product_name, s.customer_id
FROM "sales" s  JOIN menu e
ON (s.product_id = e.product_id)
WHERE order_date =  (select MIN(order_date) from "sales" )
GROUP BY  s.customer_id, e.product_name
ORDER BY s.customer_id

--4) ¿Cuál es el artículo más comprado en el menú y cuántas veces lo compraron todos los clientes?
SELECT
e.product_name,
COUNT(*) AS total_comprado
FROM sales s
JOIN menu e 
ON s.product_id = e.product_id
GROUP BY  e.product_name
ORDER BY total_comprado desc
LIMIT 1

--5) ¿Qué artículo fue el más popular para cada cliente?

WITH tmp as(
SELECT
e.product_name,
COUNT(*) AS total_comprado,
s.customer_id
FROM sales s
JOIN menu e 
ON s.product_id = e.product_id
GROUP BY  e.product_name,s.customer_id
),
top as (
SELECT product_name, customer_id, total_comprado,
DENSE_RANK() OVER( PARTITION BY customer_id ORDER BY total_comprado desc) as rank_product
FROM tmp
)
SELECT product_name, customer_id, total_comprado
FROM top
where rank_product = 1

--6) ¿Qué artículo compró primero el cliente después de convertirse en miembro?

WITH tmp as(
SELECT
e.product_name,
s.customer_id,
b.join_date,
s.order_date,
DENSE_RANK() OVER(PARTITION BY s.customer_id ORDER BY s.order_date ASC ) as rank_
FROM sales s
JOIN menu e 
ON (s.product_id = e.product_id)
JOIN members b
ON (s.customer_id = b.customer_id) 
WHERE s.order_date >= b.join_date
) 
SELECT product_name, customer_id, join_date, order_date
FROM tmp
where rank_ = 1 

--7) --¿Qué artículo se compró justo antes de que el cliente se convirtiera en miembro?

WITH tmp as(
SELECT
e.product_name,
s.customer_id,
b.join_date,
s.order_date,
DENSE_RANK() OVER(PARTITION BY s.customer_id ORDER BY s.order_date DESC ) as rank_
FROM sales s
JOIN menu e 
ON (s.product_id = e.product_id)
JOIN members b
ON (s.customer_id = b.customer_id) 
WHERE s.order_date < b.join_date
) 
SELECT product_name, customer_id, join_date, order_date
FROM tmp
where rank_ = 1 

--8) ¿Cuál es el total de artículos y la cantidad gastada por cada miembro antes de convertirse en miembro?

SELECT
s.customer_id,
COUNT(e.product_id) as total_comprado,
SUM(e.price) as total_gastado
FROM sales s
JOIN menu e 
ON (s.product_id = e.product_id)
JOIN members b
ON (s.customer_id = b.customer_id) 
WHERE s.order_date < b.join_date
GROUP BY s.customer_id
ORDER BY s.customer_id

--9) Si cada $ 1 gastado equivale a 10 puntos y el sushi tiene un multiplicador de puntos 2x, ¿cuántos puntos tendría cada cliente?
--Suposición: Solo los clientes que son miembros reciben puntos al comprar artículos, los puntos los reciben en las ordenes iguales o posteriores a la fecha
--en la que se convierten en miembros. 

WITH tmp as(
SELECT
s.customer_id,
SUM(CASE WHEN e.product_name = 'sushi' THEN e.price*20 ELSE 0 END) as total_puntos_sushi,
SUM(CASE WHEN e.product_name <> 'sushi' THEN e.price*10 ELSE 0 END) as total_puntos_otros_productos
FROM sales s
JOIN menu e 
ON (s.product_id = e.product_id) JOIN members b
ON (s.customer_id = b.customer_id)
WHERE s.order_date >= b.join_date
GROUP BY s.customer_id
)
SELECT customer_id,
(total_puntos_sushi + total_puntos_otros_productos) as total_puntos
FROM tmp
ORDER BY customer_id


--10) En la primera semana después de que un cliente se une al programa (incluida la fecha de ingreso), gana el doble de puntos en todos los artículos, no solo en sushi.
--¿Cuántos puntos tienen los clientes A y B a fines de enero?
--Suposición: Solo los clientes que son miembros reciben puntos al comprar artículos, los puntos los reciben en las ordenes iguales o posteriores a la fecha
--en la que se convierten en miembros. Solo las ordenes de la primer semana en la que se convierten en miembros suman 20 puntos para todos los articulos. 

WITH fechas AS (
  SELECT 
    customer_id, 
    join_date,
    join_date + CAST('6 days' AS INTERVAL) AS primera_semana, 
    date('2021-01-31') AS ultima_fecha
  FROM members
)
SELECT 
  f.customer_id,
  SUM(CASE 
      	WHEN s.order_date BETWEEN f.join_date AND f.primera_semana THEN e.price*20
      	WHEN e.product_name = 'sushi' THEN e.price*20
        ELSE e.price*10 END) AS total_puntos
FROM sales s
JOIN fechas f 
  ON (s.customer_id = f.customer_id)
JOIN menu e 
  ON (s.product_id = e.product_id)
WHERE s.order_date <= ultima_fecha and s.order_date >= f.join_date
GROUP BY f.customer_id
ORDER BY f.customer_id

