-- Encuentre la fecha con el mayor consumo total de energía de nuestros centros de datos, imprima la fecha junto con la energía total consumida
en todos los centros de datos
-- Tablas: eu_energia, asia_energia, na_energia

-- Solución propuesta en el curso:
WITH total as (
SELECT *
FROM interviews.na_energy
UNION ALL 
SELECT *
FROM interviews.asia_energy
UNION ALL 
SELECT *
FROM interviews.eu_energy
),
sum_consumption as (
select t.date, sum(t.consumption)  as total_consumption
from total t
group by t.date
)
select s.date, s.total_consumption
from sum_consumption s
where s.total_consumption = (select max(total_consumption) from sum_consumption)

-- Solución propia
-- Crear una vista con la unión de las 3 tablas con el objetivo de mejorar la performance 
CREATE VIEW as interviews.consumption_by_center
SELECT *
FROM interviews.na_energy
UNION ALL 
SELECT *
FROM interviews.asia_energy
UNION ALL 
SELECT *
FROM interviews.eu_energy

-- Obtener el consumo de energía total de todos los centros  por fecha y utilizar dense_rank 
with
sum_consumption as (
select date, sum(consumption)  as total_consumption
from interviews.consumption_by_center
group by date
)
select s.date, total_consumption, DENSE_RANK() OVER( ORDER BY total_consumption desc) 
from sum_consumption s
