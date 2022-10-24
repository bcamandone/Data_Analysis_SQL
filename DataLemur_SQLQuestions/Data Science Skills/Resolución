SELECT candidate_id
FROM candidates
where skill IN ( 'Python' , 'Tableau' ,  'PostgreSQL' )
GROUP BY candidate_id
HAVING COUNT(skill) = 3
order by candidate_id ASC;
