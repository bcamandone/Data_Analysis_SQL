Consigna: Escribir una consulta SQL que seleccione el id del producto, el año, la cantidad y el precio
para el primer año de cada producto vendido.

Tabla de Ventas:
+---------+------------+------+----------+-------+
 id_venta | id_producto| año  | cantidad | precio|
+---------+------------+------+----------+-------+
| 1       | 100        | 2007 | 10       | 10000 |
| 2       | 100        | 2009 | 12       | 5000  |
| 7       | 200        | 2012 | 15       | 9000  |
+---------+------------+------+----------+-------+
Tabla de Productos:
+------------+--------------+
| id_producto| nombre_producto 
+------------+--------------+
| 100        | Nokia 
| 200        | Apple 
| 300        | Samsung 
+------------+--------------+
Salida:
+------------+------------+----------+-------+
|id_producto | primer_año | cantidad | precio |
+------------+------------+----------+-------+
| 100        | 2007       | 10       | 10000 |
| 200        | 2012       | 15       | 9000  |
+------------+------------+----------+-------+


Solución:

WITH ventas AS(
SELECT s.id_producto, s."año" AS primer_año, s.cantidad, s.precio,
RANK() OVER(PARTITION BY s.id_producto ORDER BY s."año" ASC) as rank_ventas
FROM public."Sales1" s
)
SELECT id_producto, primer_año, cantidad, precio
FROM ventas 
WHERE rank_ventas =  1

