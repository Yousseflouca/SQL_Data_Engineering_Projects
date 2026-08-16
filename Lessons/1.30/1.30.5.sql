with ranked_postings AS (
    SELECT
        ROW_NUMBER() OVER(
            PARTITION BY company_id
            ORDER BY job_posted_date DESC
        ) AS rank,
        company_id,
        job_id,
        job_posted_date
    FROM
        job_postings_fact
)
SELECT *
FROM ranked_postings
WHERE rank = 1;
