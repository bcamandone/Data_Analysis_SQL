SELECT p.page_id
FROM pages p
LEFT JOIN page_likes pl
ON p.page_id = pl.page_id
where pl.liked_date is null
ORDER BY p.page_id
