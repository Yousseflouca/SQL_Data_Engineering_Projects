with location_stage AS(
    SELECT
        job_id,
        LOWER(TRIM(job_location)) AS job_location_cleaned
    FROM
        job_postings_fact
)

SELECT
    job_id,
    job_location_cleaned,
    CASE
        WHEN (job_location_cleaned LIKE '%remote%' OR job_location_cleaned LIKE '%Anywhere%') THEN 'Remote'
        WHEN (job_location_cleaned = '' OR job_location_cleaned IS NULL) THEN 'Global'
        ELSE 'On-site/Hybrid'
    END AS location_category
FROM
    location_stage;