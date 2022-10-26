WITH depositar as (
SELECT account_id, sum(amount) OVER(PARTITION BY account_id) AS de
FROM transactions
WHERE transaction_type = 'Deposit'

), 
retirar as (
SELECT account_id, sum(amount) OVER(PARTITION BY account_id) as wa
FROM transactions
WHERE transaction_type = 'Withdrawal'

) 
select 
DISTINCT(d.account_id),
(d.de-w.wa) as balance
FROM
depositar d 
JOIN retirar w ON (d.account_id = w.account_id)

