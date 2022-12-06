WITH tmp as(
SELECT 
category,product,
SUM(spend) as total_spend
FROM product_spend
WHERE transaction_date BETWEEN  '2022-01-01' AND '2022-12-31' 
GROUP BY category,product
),
top as(
SELECT
category, product, total_spend,
RANK() OVER(PARTITION BY category ORDER BY total_spend DESC) as rank_product
FROM tmp
)
SELECT  category, product, total_spend
FROM top
WHERE rank_product <= 2 
ORDER BY category,rank_product
