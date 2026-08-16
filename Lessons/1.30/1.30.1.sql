SELECT
    ROW_NUMBER() OVER (
        ORDER BY job_posted_date
    ) AS global_row_id,
    job_id,
    job_posted_date
FROM
    job_postings_fact
ORDER BY
    job_posted_date;