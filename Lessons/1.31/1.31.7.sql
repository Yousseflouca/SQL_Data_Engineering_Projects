WITH skills_count AS (
    SELECT
        jpf.company_id,
        ARRAY_LENGTH(ARRAY_AGG(DISTINCT sjd.skill_id)) AS skill_count
    FROM job_postings_fact AS jpf
    JOIN skills_job_dim AS sjd
        ON jpf.job_id = sjd.job_id
    GROUP BY jpf.company_id
), company_name AS (
    SELECT
        cd.name,
        skill_count,
        DENSE_RANK() OVER(
            ORDER BY skill_count DESC
        ) AS diversity_rank
    FROM skills_count AS sc 
    JOIN company_dim AS cd 
        ON sc.company_id = cd.company_id
)
SELECT *
FROM company_name
WHERE diversity_rank <= 10;
