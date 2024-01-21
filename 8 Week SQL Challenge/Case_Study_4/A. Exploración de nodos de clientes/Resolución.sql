--1) ¿Cuántos nodos únicos hay en el sistema del Banco de Datos?--
SELECT COUNT(DISTINCT node_id) AS nodos_unicos
FROM customer_nodes;

--2)¿Cuál es la cantidad de nodos por región?
SELECT c.region_id, COUNT(node_id) AS nodos, region_name
FROM customer_nodes c
JOIN regions r 
ON c.region_id = r.region_id
GROUP BY 1,3
ORDER BY 1

--3)¿Cuántos clientes están asignados a cada región?
SELECT R.region_id,region_name,COUNT(DISTINCT n.customer_id) as clientes
FROM customer_nodes n
JOIN regions r
ON n.region_id = r.region_id
GROUP BY 1,2
ORDER BY 1 

--4) ¿En cuántos días en promedio se reasignan los clientes a un nodo diferente?
WITH dias AS (
  SELECT 
    customer_id,
    region_id,
    node_id,
    MIN(start_date) AS first_date --por cliente, región y nodo busco la 1er fecha
  FROM customer_nodes
  GROUP BY customer_id, region_id, node_id
),
movimientos AS (
  SELECT
    customer_id,
    node_id,
    region_id,
    first_date,
   (LEAD(first_date) OVER(PARTITION BY customer_id ORDER BY first_date))  - (first_date) as dias_movimiento
  FROM dias
)

SELECT 
  ROUND(AVG(dias_movimiento),0) AS promedio_de_dias
FROM movimientos;

--5)¿Cuál es la mediana, percentil 80 y 95 para esta misma métrica de días de reasignación para cada región?
WITH dias AS (
  SELECT 
    customer_id,
    r.region_id,
	r.region_name,
    node_id,
    MIN(start_date) AS first_date --por cliente, región y nodo busco la 1er fecha
  FROM customer_nodes c
  JOIN regions r 
  ON c.region_id = r.region_id
  GROUP BY customer_id, r.region_id, node_id,r.region_name
),
movimientos AS (
  SELECT
    customer_id,
    node_id,
    region_id,
	region_name,
    first_date,
   (LEAD(first_date) OVER(PARTITION BY  region_id  ORDER BY first_date))  - (first_date) as dias_movimiento
  FROM dias
)

SELECT 
  region_id,
  region_name,
  PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY dias_movimiento) OVER(PARTITION BY region_id)  AS mediana,
  PERCENTILE_CONT(0.8) WITHIN GROUP (ORDER BY  dias_movimiento) OVER(PARTITION BY region_id)  AS percentil_80,
  PERCENTILE_CONT(0.95) WITHIN GROUP (ORDER BY dias_movimiento)OVER(PARTITION BY region_id)  AS percentil_95
FROM movimientos
ORDER BY 1
