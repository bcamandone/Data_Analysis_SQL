--Data cleaning

--Tabla customer_orders

--Convertir valores nulos y valores de texto 'nulo' en la columna extras y en la columna exclusions en espacios en blanco '' 

UPDATE pizza_runner."customer_orders"
SET exclusions = ''
WHERE exclusions IS NULL OR exclusions LIKE 'null'

UPDATE pizza_runner."customer_orders"
SET extras = ''
WHERE extras IS NULL OR extras LIKE 'null'

--Tabla runner_orders

--Convertir valores de texto 'nulo' en pickup_time, duration, distance y cancellation  en valores nulos.

UPDATE pizza_runner."runner_orders"
SET pickup_time = NULL
WHERE pickup_time LIKE 'null'

UPDATE pizza_runner."runner_orders"
SET distance = NULL
WHERE distance LIKE 'null'

UPDATE pizza_runner."runner_orders"
SET duration = NULL
WHERE duration LIKE 'null'

UPDATE pizza_runner."runner_orders"
SET cancellation = NULL
WHERE cancellation LIKE 'null'


--Convertir valores vacios en la columna cancellation  en valores nulos.

UPDATE pizza_runner."runner_orders"
SET cancellation = NULL
WHERE cancellation IN ('')


--Extraer los 'km' de la columna  distance y convertir a tipo de datos FLOAT

UPDATE pizza_runner."runner_orders"
SET distance = TRIM('km' FROM distance)
WHERE distance LIKE '%km'

ALTER TABLE pizza_runner."runner_orders"
ALTER COLUMN  distance TYPE float
USING distance::float

--Convertir la columna pickup_time  a tipo de datos timestamp without time zone

ALTER TABLE pizza_runner."runner_orders"
ALTER COLUMN  pickup_time TYPE timestamp without time zone 
USING pickup_time:: timestamp without time zone 

--Extraer los 'minutos' de la columna Duration y convertir a tipo de datos INT

UPDATE pizza_runner."runner_orders"
SET duration = TRIM('mins' FROM duration)
WHERE duration LIKE '%mins'

UPDATE pizza_runner."runner_orders"
SET duration = TRIM('minute' FROM duration)
WHERE duration LIKE '%minute'

UPDATE pizza_runner."runner_orders"
SET duration = TRIM('minutes' FROM duration)
WHERE duration LIKE '%minutes'

ALTER TABLE pizza_runner."runner_orders"
ALTER COLUMN  duration TYPE INTEGER 
USING duration:: INTEGER 
