-- 1) ¿Cuál es el recuento único y el monto total para cada tipo de transacción?
SELECT 
  txn_type,
  COUNT(*) AS recuento_unico,
  SUM(txn_amount) AS monto_total
FROM customer_transactions
GROUP BY txn_type;

--2) ¿Cuál es el promedio total histórico de depósitos y montos de todos los clientes?
WITH depositos AS (
  SELECT 
    customer_id,
    txn_type,
    COUNT(*) AS cuenta,
    SUM(txn_amount) AS total
  FROM customer_transactions
  WHERE txn_type = 'deposit'
  GROUP BY customer_id, txn_type
)

SELECT
  ROUND(AVG(cuenta),0) AS promedio_casos,
  ROUND(AVG(total),2) AS promedio_montos
FROM depositos
