SELECT
    jpf.job_title_short,
    jpf.job_no_degree_mention::INTEGER AS job_no_degree_mention,
    COUNT(job_id) AS job_postings
FROM
    job_postings_fact AS jpf
WHERE
    job_posted_date::DATE BETWEEN '2024-12-01' AND '2024-12-31'
GROUP BY
    job_title_short,
    job_no_degree_mention
ORDER BY
    job_title_short,
    job_no_degree_mention;

