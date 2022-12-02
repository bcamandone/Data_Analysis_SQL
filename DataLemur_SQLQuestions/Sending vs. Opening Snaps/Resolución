WITH tmp AS (
SELECT e.age_bucket,
SUM(case when a.activity_type = 'send' then a.time_spent
ELSE 0 END) AS time_sending,
SUM(case when a.activity_type = 'open' then a.time_spent
ELSE 0 END) AS time_opening
FROM activities a
JOIN age_breakdown e   
ON (a.user_id = e.user_id)
GROUP BY age_bucket
)
SELECT age_bucket,
ROUND((time_sending / (time_sending + time_opening)) * 100.00,2) AS send_perc,
ROUND((time_opening / (time_sending + time_opening)) * 100.00,2) AS open_perc
FROM tmp
