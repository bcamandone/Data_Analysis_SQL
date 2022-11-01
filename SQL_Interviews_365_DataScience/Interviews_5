-- Encuentre los tres mejores salarios de cada departamento, mostrar los resultados alfabéticamente por departamento y por sueldo mayor a
a menor.
-- tabla: twitter_employee

with ranked as(
SELECT department, salary, 
DENSE_RANK() OVER(PARTITION BY department ORDER BY salary DESC) AS rank_salaries
FROM interviews.twitter_employee
)
select department, salary, rank_salaries
from ranked 
where rank_salaries <= 3 and salary is not null	
order by department, salary desc 
