--1)¿Cuántos repartidores se inscribieron para cada período de 1 semana? (es decir, la semana comienza el 2021-01-01)

SELECT 
EXTRACT(WEEK FROM registration_date)  AS Semana,
COUNT(runner_id) as cantidad_repartidores
FROM pizza_runner.runners
GROUP BY EXTRACT(WEEK  FROM registration_date) 

--2)¿Cuál fue el tiempo promedio en minutos que tardó cada repartidor en llegar a la sede de Pizza Runner para recoger el pedido?

WITH tmp AS (
SELECT
r.runner_id, c.order_id,r.pickup_time,c.order_time,
EXTRACT(MINUTE FROM age(r.pickup_time,c.order_time)) as tiempo_minutos
FROM pizza_runner.customer_orders c
JOIN  pizza_runner.runner_orders r 
ON (c.order_id = r.order_id)
WHERE r.cancellation IS NULL
GROUP BY r.runner_id, c.order_id,r.pickup_time,c.order_time
)
SELECT 
runner_id,
ROUND(AVG(tiempo_minutos),2) AS promedio_minutos
FROM tmp
GROUP BY runner_id

--3)¿Existe alguna relación entre la cantidad de pizzas y el tiempo de preparación del pedido?

WITH tmp AS (
SELECT
COUNT(c.order_id) as cantidad_pizzas,
EXTRACT(MINUTE FROM age(r.pickup_time,c.order_time)) as tiempo_minutos
FROM pizza_runner.customer_orders c
JOIN  pizza_runner.runner_orders r 
ON (c.order_id = r.order_id)
WHERE r.cancellation IS NULL
GROUP BY r.pickup_time,c.order_time
)
SELECT 
cantidad_pizzas, ROUND(AVG(tiempo_minutos),2) as promedio_preparación
FROM tmp
GROUP BY cantidad_pizzas

--"cantidad_pizzas" "promedio_preparación"
-- 1                 12.0
-- 2                 18.0
-- 3                 29.0
--A mayor cantidad de pizzas, mas tiempo de preparación. 

--4)¿Cuál fue la distancia promedio recorrida por cada cliente?

SELECT
c.customer_id,
ROUND(AVG(distance :: numeric),2) AS distancia_promedio
FROM pizza_runner.customer_orders c
JOIN  pizza_runner.runner_orders r 
ON (c.order_id = r.order_id)
WHERE r.cancellation IS NULL
GROUP BY c.customer_id

--5)¿Cuál fue la diferencia entre los tiempos de entrega más largos y más cortos para todos los pedidos?

SELECT
MAX(duration) - MIN(duration) AS diferencia_tiempos_entrega
FROM pizza_runner.runner_orders 

--6)¿Cuál fue la velocidad promedio de cada repartidor para cada entrega? ¿Observa alguna tendencia para estos valores?

SELECT
order_id,
runner_id,
distance, 
duration,
ROUND(AVG(distance::numeric/duration*60 :: numeric),2) AS  velocidad_promedio
FROM  pizza_runner.runner_orders r 
WHERE r.cancellation IS NULL
GROUP BY runner_id,order_id,distance, duration

-- El repartidor 1 tuvo una velocidad promedio de 37,5 km/h a 60 km/h.El repartidor 2 tenía una velocidad promedio de 35,1 km/h a 93,6 km/h. 
-- Con la misma distancia (23,4 km), el pedido 4 se entregó a 35,1 km/h, mientras que el pedido 8 se entregó a 93,6 km/h. Se sugiere revisar los datos de origen. 
-- El repartidor 3 tiene una velocidad promedio de 40 km/h.

--7)¿Cuál es el porcentaje de entrega exitosa para cada repartidor?

SELECT 
runner_id,
COUNT(distance) AS entregado,
COUNT(order_id) AS total_ordenes,
100 * COUNT(distance) / COUNT(order_id) AS porcentaje_exito
FROM  pizza_runner.runner_orders 
GROUP BY runner_id
ORDER BY runner_id
