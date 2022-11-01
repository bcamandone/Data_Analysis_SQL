-- Calcule el porcentaje de cuentas que se cerraron el 10 de enero de 2020
-- tabla: account_status

--Solución propuesta en el curso:

SELECT 
(count(case when status = 'closed' then 1 else null end) * 1.00 / 
(count(case when status = 'closed' then 1 else null end) + 
count(case when status = 'open' then 1 else null end)) ) * 100 as percentage 
FROM interviews.account_status
where date = '2020-01-10'

-- Se multiplica por 1.00, para no tener problemas con la división de enteros.

--Solución propia:

SELECT 
round(count(case when status = 'closed' then 1 else null end) * 1.00 / 
count(case when status = 'closed' or status = 'open' then 1 else null end) * 100 , 2) as percentage
FROM interviews.account_status
where date = '2020-01-10'

