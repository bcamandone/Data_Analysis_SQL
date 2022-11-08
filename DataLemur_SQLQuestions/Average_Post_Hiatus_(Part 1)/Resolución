SELECT user_id, 
MAX(post_date::date) -  MIN(post_date::date) as days_between
FROM posts
WHERE DATE_PART('year', post_date::date) = '2021'
GROUP BY user_id
HAVING COUNT(post_id)>1
