select merchant_id,
SUM(case when lower(payment_method) = 'apple pay' then transaction_amount
ELSE 0 END) AS volume
FROM transactions
GROUP BY merchant_id
ORDER BY volume DESC
