WITH average as(
SELECT employee_id, title, salary,
(AVG(salary) OVER(PARTITION BY title)) * 2 as two_average_salary,
(AVG(salary) OVER(PARTITION BY title)) / 2 as half_average_salary
FROM employee_pay
)

SELECT  employee_id, salary,
CASE WHEN salary > two_average_salary THEN 'Overpaid'
WHEN salary < half_average_salary THEN 'Underpaid'
END AS outlier_status
FROM average
WHERE salary > two_average_salary OR salary < half_average_salary
