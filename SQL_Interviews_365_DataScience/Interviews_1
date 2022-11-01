--¿Cuáles son las tasas de éxito por día? 

-- Solución 1 

 SELECT created_at,
round((count(case when event_name = 'post' then 1 else null end) * 1.00 /
count(case when event_name = 'enter' then 1 else null end)) * 100,2) as  success_rate
FROM interviews.post_events
group by created_at
order by created_at

-- Solución 2

WITH Eventos as(
SELECT created_at, count(event_name) AS count_event
FROM interviews.post_events
WHERE event_name = 'enter'	
group by created_at
),
Post as(
SELECT created_at, count(event_name) as count_post
FROM interviews.post_events
WHERE event_name = 'post'
group by created_at
) 
select e.created_at, 
round(((p.count_post)*1.00 /e.count_event) * 100,2) as success_rate
from Eventos e join Post p ON (e.created_at = p.created_at)
order by e.created_at
