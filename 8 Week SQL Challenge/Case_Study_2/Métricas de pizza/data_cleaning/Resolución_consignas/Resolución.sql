--1)¿Cuántas pizzas se pidieron?

SELECT COUNT(order_id) as cantidad_pizzas
FROM pizza_runner.customer_orders

--2)¿Cuántos pedidos únicos de clientes se realizaron?
 
SELECT COUNT(DISTINCT(order_id)) as pedidos_unicos
FROM pizza_runner.customer_orders

--3)¿Cuántos pedidos exitosos entregó cada repartidor?

SELECT COUNT(order_id) AS pedidos_exitosos, runner_id
FROM pizza_runner.runner_orders
WHERE cancellation IS NULL 
GROUP BY runner_id

--4)¿Cuántas pizzas de cada tipo se entregaron?

SELECT n.pizza_name, COUNT(*) as  cantidad_pizzas
FROM pizza_runner.customer_orders c 
JOIN pizza_runner.pizza_names n 
ON (c.pizza_id = n.pizza_id)
JOIN pizza_runner.runner_orders r 
ON (c.order_id = r.order_id)
WHERE r.cancellation IS NULL
GROUP BY n.pizza_name

--5)¿Cuántas pizzas vegetarianas y amantes de la carne ordenó cada cliente?

SELECT c.customer_id, 
SUM(CASE WHEN n.pizza_name = 'Meatlovers' THEN 1 ELSE 0 END) as cantidad_Meatlovers,
SUM(CASE WHEN n.pizza_name = 'Vegetarian' THEN 1 ELSE 0 END) as cantidad_Vegetarian
FROM pizza_runner.customer_orders c 
JOIN pizza_runner.pizza_names n 
ON (c.pizza_id = n.pizza_id)
GROUP BY c.customer_id
ORDER BY c.customer_id

--6)¿Cuál fue el número máximo de pizzas entregadas en un solo pedido?

WITH tmp as(
SELECT c.order_id, count(pizza_id) as cantidad_pizzas
FROM pizza_runner.customer_orders c 
JOIN pizza_runner.runner_orders r 
ON (c.order_id = r.order_id)
WHERE r.cancellation IS NULL
GROUP BY c.order_id
)
SELECT MAX(cantidad_pizzas)  AS cantidad_maxima
FROM tmp

--7)Para cada cliente, ¿cuántas pizzas entregadas tenían al menos 1 cambio y cuántas no tenían cambios?

SELECT c.customer_id, 
SUM(CASE WHEN c.exclusions <> ''  OR c.extras <> '' THEN 1 ELSE 0 END) as pizzas_con_cambios,
SUM(CASE WHEN c.exclusions = '' AND c.extras = '' THEN 1 ELSE 0 END) as pizzas_sin_cambios
FROM pizza_runner.customer_orders c 
JOIN pizza_runner.runner_orders r 
ON (c.order_id = r.order_id)
WHERE r.cancellation IS NULL
GROUP BY c.customer_id

--8)¿Cuántas pizzas se entregaron que tenían exclusiones y extras?

SELECT 
SUM(CASE WHEN c.exclusions <> ''  AND c.extras <> '' THEN 1 ELSE 0 END) as pizzas_entregadas
FROM pizza_runner.customer_orders c 
JOIN pizza_runner.runner_orders r 
ON (c.order_id = r.order_id)
WHERE r.cancellation IS NULL

--9)¿Cuál fue el volumen total de pizzas ordenadas para cada hora del día?

SELECT 
EXTRACT(HOUR FROM order_time) as Hora,
COUNT(order_id) as cantidad_pizzas
FROM pizza_runner.customer_orders 
GROUP BY EXTRACT(HOUR FROM order_time)
ORDER BY Hora

--10)¿Cuál fue el volumen de pedidos para cada día de la semana?

SELECT 
to_char(order_time, 'Day') as Dia,
COUNT(order_id) as cantidad_pizzas
FROM pizza_runner.customer_orders 
GROUP BY Dia
