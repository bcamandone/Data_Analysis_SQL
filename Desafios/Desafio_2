-- Table: Salary
| employee_id | amount | pay_date   |
|-------------|--------|------------|
| 1           | 9000   | 2017-03-31 |
| 2           | 6000   | 2017-03-31 |
| 3           | 10000  | 2017-03-31 |
| 1           | 7000   | 2017-02-28 |
| 2           | 6000   | 2017-02-28 |
| 3           | 8000   | 2017-02-28 |
 
Table: Employee 

| employee_id | department_id |
|-------------|---------------|
| 1           | 1             |
| 2           | 2             |
| 3           | 2             |


--employee_id  es PK en la tabla Salary y FK en la tabla Employee

--Dada las siguientes tablas, escriba una consulta para mostrar:

--El mes correspondiente al pago 
--El id de empleado
--El resultado de la comparación por mes, del salario de cada empleado con el salario promedio de la empresa. Las categorias deberan ser:  (mayor/mejor/igual)
--El resultado de la comparación por mes, del salario de cada empleado con el salario promedio de cada departamento.Las categorias deberan ser:  (mayor/mejor/igual)




--Solución 
WITH tmp AS
(
	SELECT EXTRACT(MONTH FROM pay_date) AS MES, e.employee_id,amount,
	AVG(amount) OVER(PARTITION BY EXTRACT(MONTH FROM pay_date)) as salario_promedio,
	AVG(amount) OVER(PARTITION BY EXTRACT(MONTH FROM pay_date), department_id) as salario_promedio_departamento
	FROM salary as s 
	JOIN employee as e
	ON s.employee_id = e.employee_id
)
SELECT DISTINCT MES, employee_id,
       CASE WHEN amount > salario_promedio THEN 'mayor'
            WHEN amount = salario_promedio THEN 'igual'
            ELSE 'menor'
       END AS comparacion_promedio_compañia,

       CASE WHEN amount > salario_promedio_departamento  THEN 'mayor'
            WHEN amount = salario_promedio_departamento THEN 'igual'
            ELSE 'menor'
       END AS comparacion_promedio_departamento
FROM tmp
ORDER BY 1 DESC
