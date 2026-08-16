SELECT
    cd.name AS company_name,
    ARRAY_LENGTH(ARRAY_AGG(DISTINCT jpf.job_location)) AS location_diversity_count
FROM job_postings_fact AS jpf
LEFT JOIN company_dim AS cd 
    ON jpf.company_id = cd.company_id
GROUP BY ALL
HAVING location_diversity_count > 5
ORDER BY location_diversity_count DESC;