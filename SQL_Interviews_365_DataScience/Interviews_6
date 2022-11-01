-- Para cada fecha, encuentra la diferencia entre la distancia por dólar para esa fecha y el promedio de distancia por dólar para ese año/mes
-- Suponga que todas las fechas son únicas en el conjunto de datos y también cuente los viajes fallidos.
-- tabla: request_logs

SELECT request_date,  
ROUND(ABS(CAST(distance_to_travel / monetary_cost -
AVG(distance_to_travel / monetary_cost) OVER(PARTITION BY date_trunc('month',request_date)) AS DECIMAL)),2) as difference
FROM interviews.request_logs
ORDER BY request_date
