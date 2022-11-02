-- Desarrolle un pronóstico para una nueva métrica llamada "distancia por dólar" mensual, definida como ((distance_to_travel/monetary_cost)) 
-- en nuestro conjunto de datos y mida su precisión. Utilice RSME para evaluar la precisión. (Error de raíz cuadrada media (RMSE) es la desviación estándar)
-- Tabla: request_logs

-- POWER():Esta función se usa para encontrar un resultado después de elevar un número de exponente específico a un número base específico.

WITH tmp as(
SELECT date_trunc('month',request_date) as month_year, 
sum(distance_to_travel)/sum(monetary_cost) as distance_per_dollar_actual
FROM interviews.request_logs
group by 1 
),
model as(
SELECT month_year, distance_per_dollar_actual, 
LAG(distance_per_dollar_actual, 1) OVER (ORDER BY month_year) distance_per_dollar_model
FROM tmp
group by 1,2
)
SELECT SQRT(AVG(POWER(distance_per_dollar_actual - distance_per_dollar_model,2))) AS RMSE
FROM model 
