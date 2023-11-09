--MOTOR DE BASE DE DATOS UTILIZADO: PostgreSQL 

--1. ¿Cuál fue la cantidad total vendida de todos los productos?
SELECT
SUM(qty) AS cantidad_productos
FROM public.ventas

--2. ¿Cuál es el ingreso total generado por todos los productos antes de los descuentos?
SELECT
SUM(qty*precio) AS ingreso_total
FROM public.ventas
 
--3. ¿Cuál es el ingreso promedio generado por todos los productos antes de descuentos?
SELECT
ROUND(AVG(precio*qty),2) AS ingreso_total_medio
FROM public.ventas
 
--4. ¿Cuál es el ingreso total generado por cada producto antes de los descuentos?
-- Mostrar el nombre del producto y el ingreso, ordenar de mayor a menor por ingreso total
SELECT
pd.nombre_producto,
SUM(v.precio*v.qty) AS ingreso_total
FROM public.ventas v
JOIN public.producto_detalle pd
ON pd.id_producto = v.id_producto
GROUP BY pd.nombre_producto
ORDER BY ingreso_total DESC
 
--5. ¿Cuál es el porcentaje total de descuento (sobre el ingreso total) para todos los productos?
 
SELECT
SUM(descuento) AS descuento_total,
SUM(qty*precio) AS ingreso_total,
ROUND((100.0 *  SUM(descuento)/SUM(qty*precio) :: numeric),2) AS porcentaje_descuento 
FROM public.ventas
 
--6. ¿Cuál es el porcentaje total de descuento (sobre el ingreso total) por cada producto?
 
SELECT
nombre_producto,
SUM(descuento) AS descuento_total,
SUM(qty*v.precio) AS ingreso_total,
ROUND((100.0 *  SUM(descuento)/SUM(qty*v.precio) :: numeric),2) AS porcentaje_descuento 
FROM public.ventas v
JOIN public.producto_detalle pd
ON pd.id_producto = v.id_producto
GROUP BY pd.nombre_producto
 
--7. ¿Cuántas transacciones únicas hubo?
SELECT
COUNT(DISTINCT id_txn) AS transacciones_unicas
FROM public.ventas
 
--8. ¿Cuáles son las ventas totales brutas de cada transacción?
SELECT
id_txn,
SUM(qty*precio) AS ventas_totales_brutas
FROM ventas
GROUP BY id_txn
ORDER BY ventas_totales_brutas

--9. ¿Qué cantidad de productos totales se compran en cada transacción?
SELECT
id_txn,
SUM(qty) AS cantidad_total
FROM public.ventas
GROUP BY id_txn

--10. ¿Cuál es el valor de descuento promedio por transacción?
SELECT
id_txn,
ROUND(AVG(descuento),2) AS promedio_descuento
FROM ventas
GROUP BY id_txn

--11. ¿Cuál es el ingreso promedio neto por transacción  para  miembros “t”?
SELECT
id_txn,
ROUND(AVG(qty*precio-descuento),2) AS promedio_ingresos_neto
FROM ventas
WHERE miembro='t' 
GROUP BY id_txn

--12. ¿Cuáles son los 3 productos mas vendidos en función a los ingresos totales? 
SELECT
pd.nombre_producto,
SUM(v.qty*v.precio) AS ingresos_brutos
FROM public.ventas v
JOIN public.producto_detalle pd
ON pd.id_producto=v.id_producto
GROUP BY nombre_producto
ORDER BY ingresos_brutos DESC
LIMIT 3

--13. ¿Cuál es la cantidad total vendida, los ingresos brutos y el descuento de cada segmento de producto?
SELECT
nombre_segmento,
SUM(qty) AS cantidad_total,
SUM(qty*v.precio) AS ingresos_brutos,
SUM(descuento) AS descuento_total
FROM ventas v
JOIN producto_detalle pd
ON pd.id_producto=v.id_producto
GROUP BY nombre_segmento

--14. ¿Cuál es el producto más vendido de cada categoría?
WITH tmp as (
SELECT 
pd.nombre_categoria,
pd.nombre_producto,
SUM(v.qty) cantidad_vendida,
RANK () OVER ( PARTITION BY pd.nombre_categoria ORDER BY SUM(v.qty) DESC ) as rankeado
FROM ventas v
JOIN producto_detalle pd
ON pd.id_producto=v.id_producto
GROUP BY pd.nombre_categoria,
pd.nombre_producto
)
SELECT nombre_categoria,
nombre_producto,
cantidad_vendida
from tmp
where rankeado = 1

--15. ¿Cuál es el producto más vendido para cada segmento?

WITH tmp as (
SELECT 
pd.nombre_segmento,
pd.nombre_producto,
SUM(v.qty) cantidad_vendida,
RANK () OVER ( PARTITION BY pd.nombre_segmento ORDER BY SUM(v.qty) DESC ) as rankeado
FROM public.ventas v
JOIN public.producto_detalle pd
ON pd.id_producto=v.id_producto
GROUP BY pd.nombre_segmento,
pd.nombre_producto
)
SELECT nombre_segmento,
nombre_producto,
cantidad_vendida
from tmp
where rankeado = 1
