WITH capacity AS(
SELECT DISTINCT datacenter_id, monthly_capacity 
FROM  datacenters 
),
demand as(
SELECT DISTINCT datacenter_id, sum(monthly_demand) OVER(PARTITION BY datacenter_id) as month_demand
FROM  forecasted_demand
)
SELECT 
distinct c.datacenter_id,
(c.monthly_capacity  - d.month_demand) as spare_capacity
FROM capacity c JOIN demand d   
ON (c.datacenter_id = d.datacenter_id)
ORDER BY c.datacenter_id
