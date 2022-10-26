WITH transaction as (
SELECT user_id, spend, transaction_date,
RANK () OVER ( PARTITION BY user_id ORDER BY transaction_date ) as count_transaction
FROM transactions
)
SELECT user_id, spend, transaction_date
from transaction 
where count_transaction = 3 
