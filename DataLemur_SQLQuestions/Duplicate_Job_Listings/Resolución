WITH duplicate_jobs AS
(SELECT company_id, 
  COUNT(company_id) OVER(PARTITION BY company_id, title, description) AS count_jobs
  FROM job_listings)

  SELECT count(DISTINCT company_id)
  FROM duplicate_jobs
  WHERE count_jobs > 1
