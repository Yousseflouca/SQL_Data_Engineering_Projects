WITH job_skill_counts AS (
    SELECT
        jpf.job_id,
        jpf.job_title_short,
        ARRAY_LENGTH(ARRAY_AGG(sjd.skill_id)) AS skills_count
    FROM job_postings_fact AS jpf
    LEFT JOIN skills_job_dim AS sjd
        ON jpf.job_id = sjd.job_id
    WHERE
        job_title_short = 'Data Engineer' OR
        job_title_short = 'Data Analyst'
    GROUP BY ALL
)
SELECT
    job_title_short,
    AVG(skills_count) AS skill_count_average
FROM
    job_skill_counts
GROUP BY job_title_short;