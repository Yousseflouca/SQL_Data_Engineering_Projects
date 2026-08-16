SELECT
    job_id,
    NULLIF(salary_year_avg, 0) AS salary_cleaned
FROM
    job_postings_fact
WHERE
    salary_cleaned IS NULL;