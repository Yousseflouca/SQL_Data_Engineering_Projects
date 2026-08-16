
SELECT
    jpf.job_id,
    jpf.job_title_short,
    jpf.job_location
FROM job_postings_fact AS jpf
INNER JOIN company_dim AS cd 
    ON jpf.company_id = cd.company_id
WHERE jpf.salary_year_avg > 1_00_000
    AND cd.name = 'Google';



SELECT
    jpf.job_id,
    jpf.job_title_short,
    jpf.job_location
FROM job_postings_fact AS jpf
WHERE jpf.salary_year_avg > 1_00_000
    AND company_id = ( 
        SELECT company_id
        FROM company_dim
        WHERE name = 'Google'
    );

