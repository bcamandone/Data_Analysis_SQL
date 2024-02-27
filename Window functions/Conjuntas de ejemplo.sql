--1) Ejemplo Aggregate Window Functions
--La siguiente consulta devuelve el nombre del producto, el precio, el nombre del grupo de productos, junto con los precios promedio de cada grupo de productos.

SELECT
	product_name,
	price,
	group_name,
	ROUND(AVG(price) OVER (PARTITION BY group_name),2) AS precio_promedio
FROM
	products p 
	INNER JOIN product_groups pg ON p.group_id = pg.group_id;

