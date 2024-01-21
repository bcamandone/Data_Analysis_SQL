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
