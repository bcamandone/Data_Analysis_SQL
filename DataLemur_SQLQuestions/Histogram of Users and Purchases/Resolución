--Opción con CTE

with tmp AS(
SELECT 
transaction_date,
user_id,
COUNT(product_id) AS purchase_count,
DENSE_RANK() OVER(PARTITION BY user_id ORDER BY transaction_date DESC) as rank_count 
FROM user_transactions
GROUP BY 1,2 
)
SELECT transaction_date, user_id,purchase_count
FROM tmp
WHERE rank_count = 1 
ORDER BY transaction_date

--Opción con subconsulta

select
  u.transaction_date,
  u.user_id,
  count(*) as purchase_count
from user_transactions as u
inner join (
  select user_id, max(transaction_date) as maximos
  from user_transactions group by user_id
  ) as m
on u.user_id = m.user_id 
and u.transaction_date = m.maximos
GROUP BY 1,2; 
