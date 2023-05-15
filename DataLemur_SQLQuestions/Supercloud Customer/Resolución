SELECT customer_id
FROM (
  SELECT customers.customer_id
  FROM customer_contracts AS customers
  LEFT JOIN products 
    ON customers.product_id = products.product_id
  GROUP BY customers.customer_id
  HAVING COUNT(DISTINCT products.product_category) = 3
) AS supercloud
ORDER BY customer_id;
