-- Ustes es cientifico de datos para una compañia que desea entender mejor el comportamiento de sus usuarios en su plataforma. Obtenga el tiempo de sesión promedio 
-- de los usuarios en orden ascendente. Suponga que un usuario tiene solo una sesión por día.La duración de la sesión es (page exit- page load)
--Tabla: web_log

- Columnas a obtener: usuario / sesión media
- Cacular cada sesión por usuario por día (cte)
- obtener el promedio de la sesión por usuario en orden ascendente 

WITH session_users as(
SELECT a.user_id, a."timestamp" as date_session, 
MIN(b."timestamp" - a."timestamp") as duration 
FROM interviews.web_log a 
JOIN interviews.web_log b
ON (a.user_id = b.user_id)
where a.action = 'page_load'
and b.action  = 'page_exit'
and b."timestamp"  > a."timestamp"
group by a.user_id, a."timestamp"
)
SELECT user_id, AVG(duration) as avg_session
FROM session_users
group by 1 
order by avg_session ASC 
