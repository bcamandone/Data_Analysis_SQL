--Para responder a las preguntas de negocio, realizaremos la siguientes sentencias:

--Agregamos una columna con un ID autoincremental  en la tabla customer_orders

ALTER TABLE pizza_runner.customer_orders
ADD COLUMN Cod_ID serial

--Creamos una vista a partir de la tabla pizza_recipes, con una fila para cada topping de cada categoría de pizza.  

CREATE VIEW pizza_runner.pizza_recipes_clean AS
SELECT pizza_id,  CAST(unnest(string_to_array(toppings, ',')) AS INT) AS topping_id
FROM pizza_runner.pizza_recipes 

--Creamos una segunda vista, con el numero de orden, la pizza pedida y si hubo extras o exclusiones 

CREATE VIEW pizza_runner.pizza_extras_exclusions AS
SELECT order_id, pizza_id,  CAST(unnest(string_to_array(exclusions, ',')) AS INT) AS exclusions_toppings,
CAST(unnest(string_to_array(extras, ',')) AS INT) AS extras_toppings
FROM pizza_runner.customer_orders

--1)¿Cuáles son los ingredientes estándar para cada pizza?

SELECT pizza_name, 
STRING_AGG(topping_name,  ', ') AS ingredientes
FROM pizza_runner.pizza_names n JOIN pizza_runner.pizza_recipes_clean r
ON (n.pizza_id = r.pizza_id) JOIN pizza_runner.pizza_toppings  t
ON  (r.topping_id = t.topping_id)
GROUP BY  pizza_name

--2)¿Cuál fue el extra más comúnmente añadido?

SELECT t.topping_name, COUNT(r.extras_toppings) AS extras 
FROM pizza_runner.pizza_extras_exclusions r
JOIN pizza_runner.pizza_toppings  t
ON  (r.extras_toppings = t.topping_id)
GROUP BY t.topping_name
ORDER BY extras DESC

--3)¿Cuál fue la exclusión más común?

SELECT t.topping_name, COUNT(r.exclusions_toppings) AS exclusions 
FROM pizza_runner.pizza_extras_exclusions r
JOIN pizza_runner.pizza_toppings  t
ON  (r.exclusions_toppings = t.topping_id)
GROUP BY t.topping_name
ORDER BY exclusions DESC

--4)Genere un artículo de pedido para cada registro en la tabla customers_orders en el formato de uno de los siguientes: 
--Meat Lovers / Meat Lovers - Exclude Beef / Meat Lovers - Extra Bacon / Meat Lovers - Exclude Cheese, Bacon - Extra Mushroom, Peppers

WITH extras AS (
SELECT 
e.Cod_ID,
CONCAT('Extra  ', STRING_AGG(t.topping_name, ' , ')) AS detalle
FROM 
pizza_runner.pizza_extras_exclusions e
JOIN  pizza_runner.pizza_toppings t
ON (e.extras_toppings = t.topping_id)
GROUP BY e.Cod_ID
), 
exclusions AS (
SELECT 
e.Cod_ID,
CONCAT('Exclusion  ' , STRING_AGG(t.topping_name, ', ')) AS detalle
FROM  pizza_runner.pizza_extras_exclusions e 
JOIN  pizza_runner.pizza_toppings t
ON (e.exclusions_toppings = t.topping_id)
GROUP BY e.Cod_ID
), 
tmp AS (
SELECT * FROM extras
UNION
SELECT * FROM exclusions
)
SELECT 
c.order_id,
c.Cod_ID,
c.customer_id,
c.pizza_id,
c.order_time,
CONCAT_WS(' - ', p.pizza_name, STRING_AGG(tmp.detalle, ' - ')) AS pizza_info
FROM pizza_runner.customer_orders c
LEFT JOIN tmp 
ON (c.Cod_ID = tmp.Cod_ID)
JOIN pizza_names p
ON (c.pizza_id = p.pizza_id)
GROUP BY
c.order_id,
c.Cod_ID,
c.customer_id,
c.pizza_id,
c.order_time,
p.pizza_name


--5)Genere una lista de ingredientes separados por comas ordenados alfabéticamente para cada pedido de pizza de la tabla customer_orders y agregue 2x 
--delante de cualquier ingrediente relevante Por ejemplo: "Amantes de la carne: 2xTocino, Carne de res, ... , Salami" /"Meat Lovers: 2xBacon, Beef, ... , Salami"

WITH ingredientes AS (
  SELECT 
    c.*,
    n.pizza_name,
    --Agregar '2x' delante de topping_names si su topping_id aparece en la vista extras y exclusiones 
    CASE WHEN t.topping_id IN (
          SELECT extras_toppings 
          FROM pizza_runner.pizza_extras_exclusions e 
          WHERE e.Cod_ID = c.Cod_ID)
      THEN CONCAT('2x  ', t.topping_name)  
	-- Excluir ingredientes si su topping_id aparece en la vista extras y exclusiones
      WHEN t.topping_id IN (
          SELECT exclusions_toppings 
          FROM pizza_runner.pizza_extras_exclusions e 
          WHERE e.Cod_ID = c.Cod_ID)
      THEN ''
      ELSE t.topping_name
   END AS ingrediente	
FROM pizza_runner.customer_orders c	
JOIN pizza_runner.pizza_recipes_clean r
ON(c.pizza_id = r.pizza_id)
JOIN pizza_runner.pizza_toppings  t
ON (r.topping_id = t.topping_id)
JOIN pizza_runner.pizza_names n
ON(c.pizza_id = n.pizza_id)	
)
SELECT 
Cod_ID,
order_id,
customer_id,
pizza_id,
order_time,
CONCAT(pizza_name , ': ', STRING_AGG(ingrediente, ', '))  AS lista_ingredientes
FROM ingredientes
GROUP BY 
Cod_ID, 
order_id,
customer_id,
pizza_id,
order_time,
pizza_name


--6)¿Cuál es la cantidad total de cada ingrediente utilizado en todas las pizzas entregadas ordenadas por el más frecuente primero?

WITH Ingredientes AS (
  SELECT 
    c.Cod_ID,
    t.topping_name,
    CASE
      -- Ingredientra extra, suma 2
      WHEN t.topping_id IN (
          SELECT extras_toppings
          FROM pizza_runner.pizza_extras_exclusions e
          WHERE e.Cod_ID = c.Cod_ID) 
      THEN 2
      -- Si se excluye un ingrediente, entonces es 0
      WHEN t.topping_id IN (
          SELECT exclusions_toppings 
          FROM pizza_runner.pizza_extras_exclusions e 
          WHERE e.Cod_ID = c.Cod_ID)
      THEN 0
      -- sin extras ni exclusiones a cantidad es 1
      ELSE 1
    END AS cantidad
FROM pizza_runner.customer_orders c	
JOIN pizza_runner.pizza_recipes_clean r
ON(c.pizza_id=r.pizza_id)
JOIN pizza_runner.pizza_toppings  t
ON (r.topping_id = t.topping_id)
)
SELECT 
  topping_name,
  SUM(cantidad) as cantidad_total
FROM Ingredientes
GROUP BY topping_name
ORDER BY cantidad_total DESC
