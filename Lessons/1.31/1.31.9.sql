WITH unique_skill_count AS (
    SELECT
        jpf.job_id,
        jpf.company_id,
        ARRAY_LENGTH(ARRAY_AGG(DISTINCT sjd.skill_id)) AS skill_count
    FROM job_postings_fact AS jpf
    JOIN skills_job_dim AS sjd
        ON jpf.job_id = sjd.job_id
    GROUP BY ALL
), avg_num_of_skills AS (
    SELECT
        company_id,
        AVG(skill_count) AS avg_skills_per_company
    FROM unique_skill_count
    GROUP BY company_id
)
SELECT
    usc.job_id,
    usc.skill_count,
    anos.avg_skills_per_company
FROM unique_skill_count AS usc 
JOIN avg_num_of_skills AS anos
    ON usc.company_id = anos.company_id
WHERE usc.skill_count > anos.avg_skills_per_company
ORDER BY skill_count DESC
LIMIT 100;