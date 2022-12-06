WITH tmp as(
SELECT  a.artist_name,
COUNT(s.song_id)  as song_count
FROM  songs s JOIN global_song_rank g
ON ( s.song_id = g.song_id) JOIN artists a
ON (a.artist_id = s.artist_id)
WHERE g.rank <= 10
GROUP BY  a.artist_name
),
top as(
SELECT
artist_name, 
DENSE_RANK() OVER(ORDER BY song_count DESC) AS artist_rank
FROM tmp
)
SELECT artist_name, artist_rank
FROM top
WHERE artist_rank <= 5
ORDER BY artist_rank 
