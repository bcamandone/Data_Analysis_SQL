--Obtenga  el cambio porcentual mensual en los ingresos. La tabla de salida debe tener la forma de año y mes y el cambio porcentual,
--redondear a 2 decimales y ordenar desde el comienzo del año hasta el final del año.
--Tabla: transactions


-- Solución:
-- Columnas resultantes: mes - porcentaje_cambio
-- utilizar date_trunc para extraer el mes
-- utilizar LAG para obtener de un registro, el valor anterior


SELECT date_trunc('month',created_at) as month_year, 
ROUND((SUM(value) - LAG(SUM(value),1) OVER(ORDER BY date_trunc('month', created_at))) /
LAG(SUM(value),1) OVER(ORDER BY date_trunc('month',created_at)) * 100 , 2) percentage_change
FROM interviews.transactions
GROUP BY 1 
ORDER BY 1 
