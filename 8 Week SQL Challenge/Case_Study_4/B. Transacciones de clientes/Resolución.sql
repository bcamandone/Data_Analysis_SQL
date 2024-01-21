-- 1) ¿Cuál es el recuento único y el monto total para cada tipo de transacción?
SELECT 
  txn_type,
  COUNT(*) AS recuento_unico,
  SUM(txn_amount) AS monto_total
FROM customer_transactions
GROUP BY txn_type;
