-- ¿Qué día de la semana tiene la tasa de éxito más baja?

SELECT extract (dow from created_at) as day_of_week, 
round((count(case when event_name = 'post' then 1 else null end) * 1.00 /
count(case when event_name = 'enter' then 1 else null end)) * 100,2) as  success_rate
FROM interviews.post_events
group by 1
order by 2 asc 
