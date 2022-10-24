SELECT u.city, 
COUNT(t.order_id) as count_order
FROM trades t 
JOIN users  u
ON (t.user_id = u.user_id)
WHERE t.status = 'Completed'
GROUP BY u.city
ORDER BY count_order desc 
LIMIT 3
