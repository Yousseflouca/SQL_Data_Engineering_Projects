SELECT *
FROM
    job_postings_fact
WHERE
    TRIM(job_title) <> ''
    AND job_location <> 'N/A';