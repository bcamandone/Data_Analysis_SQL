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

--3)Para cada mes, ¿cuántos clientes de Data Bank realizan más de 1 depósito y 1 compra o 1 retiro en un solo mes?
WITH transacciones AS (
  SELECT 
    customer_id,
    EXTRACT(MONTH FROM txn_date) AS mes,
    SUM(CASE WHEN txn_type = 'deposit' THEN 1 ELSE 0 END) AS depositos,
    SUM(CASE WHEN txn_type = 'purchase' THEN 1 ELSE 0 END) AS compra,
    SUM(CASE WHEN txn_type = 'withdrawal' THEN 1 ELSE 0 END) AS retiro
  FROM customer_transactions
  GROUP BY customer_id,  EXTRACT(MONTH FROM txn_date)
)

SELECT 
  mes,
  COUNT(customer_id) AS clientes
FROM transacciones
WHERE depositos > 1
  AND (compra = 1 OR retiro = 1)
GROUP BY mes;
