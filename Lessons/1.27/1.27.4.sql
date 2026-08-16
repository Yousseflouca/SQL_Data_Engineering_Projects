SELECT
    EXTRACT(QUARTER FROM job_posted_date) AS job_posted_quarter,
    EXTRACT(YEAR FROM job_posted_date) AS job_posted_year,
    CONCAT(EXTRACT(YEAR FROM job_posted_date), '-', EXTRACT(QUARTER FROM job_posted_date)) AS job_posted_year_quarter,
    COUNT(job_id) AS job_posts
FROM
    job_postings_fact
WHERE
    EXTRACT(YEAR FROM job_posted_date) BETWEEN 2023 AND 2024
GROUP BY
    EXTRACT(QUARTER FROM job_posted_date),
    EXTRACT(YEAR FROM job_posted_date),
    CONCAT(EXTRACT(YEAR FROM job_posted_date), '-', EXTRACT(QUARTER FROM job_posted_date))
ORDER BY
    job_posted_year_quarter;