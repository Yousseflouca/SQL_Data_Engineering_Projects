USE company_jobs;

CREATE OR REPLACE TEMP TABLE top_hiring_companies_temp AS
SELECT
    jpf.company_id,
    cd.name AS company_name,
    COUNT(job_id) AS posting_count
FROM data_jobs.job_postings_fact AS jpf
JOIN data_jobs.company_dim AS cd 
    ON jpf.company_id = cd.company_id
GROUP BY
    jpf.company_id,
    company_name 
HAVING
    posting_count > 10;

SELECT *
FROM top_hiring_companies_temp;

