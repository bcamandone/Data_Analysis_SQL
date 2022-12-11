-- 1) Join All The Things

SELECT
s.customer_id,
s.order_date,
e.product_name,
e.price,
(CASE WHEN s.order_date >= b.join_date THEN 'Y' ELSE 'N' END) as member
FROM sales s
JOIN menu e 
ON (s.product_id = e.product_id) 
LEFT JOIN members b
ON (s.customer_id = b.customer_id)
ORDER BY s.customer_id, s.order_date 


--2) Rank All The Things

WITH tmp as (
SELECT
s.customer_id,
s.order_date,
e.product_name,
e.price,
(CASE WHEN s.order_date >= b.join_date THEN 'Y' ELSE 'N' END) as member
FROM sales s
JOIN menu e 
ON (s.product_id = e.product_id) 
LEFT JOIN members b
ON (s.customer_id = b.customer_id)
)
SELECT *,
  CASE WHEN member = 'Y' 
  	THEN DENSE_RANK() OVER(PARTITION BY customer_id, member ORDER BY order_date)
  ELSE null END AS ranking
FROM tmp
