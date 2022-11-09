WITH sender AS(
SELECT  sender_id, COUNT(message_id) as message_count
FROM  messages 
where sent_date BETWEEN '2022-08-01' AND '2022-08-31' 
GROUP BY sender_id
)
SELECT sender_id, message_count
from sender
ORDER BY  message_count DESC
LIMIT 2 
