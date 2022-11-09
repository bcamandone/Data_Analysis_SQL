with total_count as (
select cast(count(business_id) as float) from reviews),
top_rated_count as (
SELECT cast(count(business_id) as float) FROM reviews
where review_stars in (4,5))

select
(select * from top_rated_count) as business_count,
((select * from top_rated_count)/(select * from total_count))*100 as top_rated_pct
