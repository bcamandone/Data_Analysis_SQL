--1)¿Cuántos clientes ha tenido Foodie-Fi?

SELECT COUNT(DISTINCT(customer_id)) AS cantidad_clientes
FROM foodie_fi.subscriptions 

--2)¿Cuál es la distribución mensual de los valores de la fecha de inicio del plan de prueba para nuestro conjunto de datos? 
--Utilice el inicio del mes como el grupo por valor

SELECT date_part('month', start_date) as mes, count(*) as cantidad
FROM foodie_fi.subscriptions s
JOIN foodie_fi.plans p
ON (s.plan_id = p.plan_id)
WHERE plan_name = 'trial'
GROUP BY date_part('month', start_date) 
ORDER BY mes

--3)¿Qué valores de plan start_date ocurren después del año 2020 para nuestro conjunto de datos? Mostrar el desglose por conteo de eventos para cada plan_name

SELECT date_part('year', start_date) AS año, plan_name, count(*) as cantidad
FROM foodie_fi.subscriptions s
JOIN foodie_fi.plans p
ON (s.plan_id = p.plan_id)
WHERE date_part('year', start_date) > 2020
GROUP BY plan_name, date_part('year', start_date)

--4)¿Cuál es el recuento de clientes y el porcentaje de clientes que se han retirado redondeado a 1 decimal?

SELECT
SUM(CASE WHEN P.plan_name = 'churn' THEN 1 ELSE 0 END) as cantidad_clientes_baja, 
CAST(100*SUM(CASE WHEN p.plan_name = 'churn' THEN 1 ELSE 0 END) AS FLOAT(1))/ COUNT(DISTINCT(customer_id)) AS porcentaje_baja
FROM foodie_fi.subscriptions s
JOIN foodie_fi.plans p
ON (s.plan_id = p.plan_id)

--5)¿Cuántos clientes abandonaron inmediatamente después de su prueba gratuita inicial? ¿Qué porcentaje se redondea al número entero más cercano?

WITH nextPlan AS (
  SELECT 
    s.customer_id,
    s.start_date,
    p.plan_name,
    LEAD(p.plan_name) OVER(PARTITION BY s.customer_id ORDER BY p.plan_id) AS next_plan
  FROM foodie_fi.subscriptions s
  JOIN foodie_fi.plans p ON s.plan_id = p.plan_id
)

SELECT 
  COUNT(*) AS clientes_abandonaron,
  100*COUNT(*) / (SELECT COUNT(DISTINCT customer_id) FROM foodie_fi.subscriptions) AS porcentaje_abandono
FROM nextPlan
WHERE plan_name = 'trial' 
  AND next_plan = 'churn'

--6)¿Cuál es el número y porcentaje de planes de clientes después de su prueba gratuita inicial?

WITH nextPlan AS (
  SELECT 
    s.customer_id,
    s.start_date,
    p.plan_name,
    LEAD(p.plan_name) OVER(PARTITION BY s.customer_id ORDER BY p.plan_id) AS next_plan
  FROM foodie_fi.subscriptions s
  JOIN foodie_fi.plans p ON s.plan_id = p.plan_id
)

SELECT 
  next_plan, 
  COUNT(*) AS cantidad,
  100*COUNT(*) / (SELECT COUNT(DISTINCT customer_id) FROM foodie_fi.subscriptions) AS porcentaje
FROM nextPlan
WHERE plan_name = 'trial' 
  AND next_plan <> 'churn'
GROUP BY next_plan


--7)¿Cuál es el conteo de clientes y el desglose porcentual de los 5 valores de plan_name al 2020-12-31?

WITH plansDate AS (
  SELECT 
    s.customer_id,
    s.start_date,
	p.plan_id,
    p.plan_name,
    LEAD(s.start_date) OVER(PARTITION BY s.customer_id ORDER BY s.start_date) AS next_date
  FROM foodie_fi.subscriptions s
  JOIN foodie_fi.plans p ON s.plan_id = p.plan_id
)

SELECT 
  plan_id,
  plan_name,
  COUNT(*) AS customers,
  CAST(100*COUNT(*) AS FLOAT) 
      / (SELECT COUNT(DISTINCT customer_id) FROM foodie_fi.subscriptions) AS rate
FROM plansDate
WHERE (next_date IS NOT NULL AND (start_date < '2020-12-31' AND next_date > '2020-12-31'))
  OR (next_date IS NULL AND start_date < '2020-12-31')
GROUP BY plan_id, plan_name
ORDER BY plan_id

--8)¿Cuántos clientes han actualizado a un plan anual en 2020?

SELECT 
  COUNT(DISTINCT customer_id) AS clientes
FROM  foodie_fi.subscriptions s
JOIN foodie_fi.plans p ON s.plan_id = p.plan_id
WHERE p.plan_name = 'pro annual'
  AND EXTRACT(YEAR FROM s.start_date ) = 2020

--9)¿Cuántos días en promedio le toma a un cliente cambiar a un plan anual desde el día en que se une a Foodie-Fi?

WITH trialPlan AS (
  SELECT 
    s.customer_id,
    s.start_date AS trial_date
  FROM foodie_fi.subscriptions s
  JOIN foodie_fi.plans p ON s.plan_id = p.plan_id
  WHERE p.plan_name = 'trial'
),
annualPlan AS (
  SELECT 
    s.customer_id,
    s.start_date AS annual_date
  FROM foodie_fi.subscriptions s
  JOIN foodie_fi.plans p ON s.plan_id = p.plan_id
  WHERE p.plan_name = 'pro annual'
)

SELECT 
  round(AVG(extract(day from annual_date::timestamp - trial_date::timestamp)),0)
FROM trialPlan t
JOIN annualPlan a 
ON t.customer_id = a.customer_id

--10)¿Puede desglosar este valor promedio en períodos de 30 días (es decir, 0-30 días, 31-60 días, etc.)

WITH trialPlan AS (
  SELECT 
    s.customer_id,
    s.start_date AS trial_date
  FROM foodie_fi.subscriptions s
  JOIN foodie_fi.plans p ON s.plan_id = p.plan_id
  WHERE p.plan_name = 'trial'
),
annualPlan AS (
  SELECT 
    s.customer_id,
    s.start_date AS annual_date
  FROM foodie_fi.subscriptions s
  JOIN foodie_fi.plans p ON s.plan_id = p.plan_id
  WHERE p.plan_name = 'pro annual'
),
datesDiff AS(
SELECT 
extract(day from annual_date::timestamp - trial_date::timestamp) AS diferencia_dias
FROM trialPlan t
JOIN annualPlan a 
ON t.customer_id = a.customer_id
)
SELECT
COUNT(*) AS cantidad,
CASE WHEN  diferencia_dias >= 0 AND diferencia_dias <= 30 THEN '0-30 días'
     WHEN  diferencia_dias > 30 AND diferencia_dias <= 60 THEN '31-60 días'
	 WHEN  diferencia_dias > 60 AND diferencia_dias <= 90 THEN '61-90 días'
	 ELSE 'Mayor a 90 días' END AS clasificacion_dias
FROM datesDiff
GROUP BY 2

--11)¿Cuántos clientes bajaron de un plan mensual profesional a un plan mensual básico en 2020?

WITH nextPlan AS (
  SELECT 
    s.customer_id,
    s.start_date,
    p.plan_name,
    LEAD(p.plan_name) OVER(PARTITION BY s.customer_id ORDER BY p.plan_id) AS next_plan
  FROM foodie_fi.subscriptions s
  JOIN foodie_fi.plans p ON s.plan_id = p.plan_id
)
SELECT 
  COUNT(*) AS cantidad
FROM nextPlan
WHERE plan_name = 'pro monthly'
  AND next_plan = 'basic monthly'
  AND EXTRACT(YEAR FROM start_date ) = 2020
GROUP BY next_plan

