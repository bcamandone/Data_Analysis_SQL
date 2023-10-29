--1)Si una pizza Meat Lovers cuesta $ 12 y una vegetariana cuesta $ 10 y no hubo cargos por cambios, 
--¿cuánto dinero ha ganado Pizza Runner hasta ahora si no hay tarifas de entrega?

SELECT 
SUM(CASE WHEN c.pizza_id = 1 THEN 12*1 ELSE 1*10 END) as ganancia 
FROM pizza_runner.customer_orders c	
JOIN pizza_runner.runner_orders r 
ON (c.order_id = r.order_id)
WHERE r.cancellation IS NULL

--2)¿Qué pasa si hubo un cargo adicional de $ 1 por los extras de pizza? Nota: Agregar queso cuesta $1 extra

--Creamos una cte con la misma consulta de la consigna 1, donde tenemos la ganancia sin extras
WITH ganancia_pizzas AS (
    SELECT c.Cod_id,
        SUM(
            CASE
                WHEN c.pizza_id = 1 THEN 12 * 1
                ELSE 1 * 10
            END
        ) as ganancia
    FROM pizza_runner.customer_orders c
        JOIN pizza_runner.runner_orders r ON (c.order_id = r.order_id)
    WHERE r.cancellation IS NULL
    GROUP BY c.Cod_id
),
ganancia_extras AS (
    SELECT c.Cod_id,
        --Si el topping_id de la tabla pizza_toppings coincide con extras_toppings de la vista pizza_extras_exclusion
        --entonces sumamos 1 de lo contrario, sumamos 0
        SUM(
            CASE
                WHEN t.topping_id IN(
                    SELECT extras_toppings
                    FROM pizza_runner.pizza_extras_exclusions e
                    WHERE e.Cod_ID = c.Cod_ID
                ) THEN 1
                ELSE 0
            END
        ) AS extras_menos_queso,
        --Si el topping_id de la tabla pizza_toppings coincide con extras_toppings de la vista pizza_extras_exclusion
        --y es queso, entonces sumamos 2, de lo contrario, sumamos 0
        SUM(
            CASE
                WHEN t.topping_id IN (
                    SELECT extras_toppings
                    FROM pizza_runner.pizza_extras_exclusions e
                    WHERE e.Cod_ID = c.Cod_ID
                        AND extras_toppings = 4
                ) THEN 2
                ELSE 0
            END
        ) as extra_queso
    FROM pizza_runner.customer_orders c
        JOIN pizza_runner.pizza_recipes_clean r ON(c.pizza_id = r.pizza_id)
        JOIN pizza_runner.pizza_toppings t ON (r.topping_id = t.topping_id)
        JOIN pizza_runner.runner_orders f ON (c.order_id = f.order_id)
    WHERE f.cancellation IS NULL
    GROUP BY c.Cod_id
)
SELECT SUM(ganancia) + SUM(extras_menos_queso) + SUM(extra_queso) AS ganancia_total
FROM ganancia_pizzas p
    JOIN ganancia_extras g ON(p.Cod_id = g.Cod_id)


--3)El equipo de Pizza Runner ahora quiere agregar un sistema de calificación adicional que permita a los clientes calificar a su repartidor. 
--¿Cómo diseñaría una tabla adicional para este nuevo conjunto de datos? Genere un esquema para esta nueva tabla e inserte sus propios datos para las calificaciones de cada cliente exitoso. Nota: ordene entre 1 a 5.


CREATE TABLE pizza_runner.ratings (
  order_id INT,
  runner_id INT,		
  rating INT);
  
  
INSERT INTO pizza_runner.ratings (order_id,runner_id, rating)
VALUES 
  (1,1,3),
  (2,1,5),
  (3,1,2),
  (4,2,1),
  (5,3,5),
  (7,2,3),
  (8,2,4),
  (10,1,2);

--4)Usando su tabla recién generada, ¿puede unir toda la información para formar una tabla que tenga la siguiente información para entregas exitosas? 
--customer_id,order_id,runner_id,rating,order_time,pickup_time,Time between order and pickup Delivery, duration, Average speed,Total number of pizzas

SELECT 
  c.customer_id,
  c.order_id,
  r.runner_id,
  c.order_time,
  r.pickup_time,
  EXTRACT(MINUTE FROM age(r.pickup_time,c.order_time)) as Time_between,
  r.duration,
  ROUND(AVG(r.distance::numeric/r.duration::numeric*60), 1) AS avg_speed,
  COUNT(c.order_id) AS pizza_count
FROM pizza_runner.customer_orders c	
JOIN pizza_runner.runner_orders r
  ON (r.order_id = c.order_id)
GROUP BY 
  c.customer_id,
  c.order_id,
  r.runner_id,
  c.order_time,
  r.pickup_time, 
  r.duration
ORDER BY order_id


--5)Si una pizza Meat Lovers costaba $12 y una vegetariana $10, precios fijos sin costo por extras, y a cada repartidor se le paga $0.30 por kilómetro recorrido, 
--¿cuánto dinero le queda a Pizza Runner después de estas entregas?

 WITH ganancias as(
    SELECT c.order_id,
        SUM(
            CASE
                WHEN c.pizza_id = 1 THEN 12 * 1
                ELSE 1 * 10
            END
        ) as ganancia
    FROM pizza_runner.customer_orders c
        JOIN pizza_runner.runner_orders r ON (c.order_id = r.order_id)
    WHERE r.cancellation IS NULL
    GROUP BY c.order_id
),
costo AS (
    SELECT order_id,
        SUM(distance * 0.30) as costo_repartidores
    FROM pizza_runner.runner_orders
    WHERE cancellation IS NULL
    GROUP BY order_id
)
SELECT SUM(ganancia) - SUM(costo_repartidores) AS ganancia_total
FROM ganancias g
    JOIN costo o ON (g.order_id = o.order_id)            

