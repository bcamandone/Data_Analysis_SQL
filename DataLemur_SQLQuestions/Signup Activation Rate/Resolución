WITH tmp as(
SELECT COUNT(user_id) AS total_users, 
SUM(case when signup_action = 'Confirmed' then 1 ELSE 0 END) as activation_count
FROM texts t JOIN emails e 
ON (t.email_id = e.email_id)
)
SELECT 
ROUND(activation_count::DECIMAL / total_users,2) as  activation_rate
FROM tmp
