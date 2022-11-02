-- Usted es un científico de datos en una empresa que ejecuta una plataforma de redes sociales.La empresa quiere echar un vistazo al nivel de participación en su
-- plataforma. Calcular la distribución de comentarios por el conteo de usuarios que se unieron la plataforma entre 2018 y 2020, solo para el mes de enero 2020. 
-- Ordenar la salida desde el menor número de comentarios hasta el más alto
-- tablas: users, comments

-- Solución: 
-- contar los comentarios y la cantidad de usuarios que hicieron esos comentarios, solo para enero 2020
-- solo aquellos usuarios que se unieron entre 2018 y 2020
-- solo aquellos usuarios que su fecha de union sea anterior a la del posteo 
-- ordenar de la menor cantidad de comentarios a la mayor 

with tmp as (
SELECT c.user_id , count(body) as total_comments
FROM interviews.comments c
JOIN interviews.users u ON (u.id = c.user_id)
where u.joined_at between '2018-01-01'   and '2020-12-31' 
AND created_at > joined_at 
AND created_at between '2020-01-01' and '2020-01-31' 
group by user_id
)
select 
count(user_id) as num_users , total_comments as num_comments
from tmp
group by num_comments
order by num_comments
