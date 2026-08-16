USE company_jobs;

DELETE FROM main.job_skill_priorities AS tgt
WHERE NOT EXISTS (
    SELECT 1
    FROM staging.priority_skills AS src
    WHERE src.skill_id = tgt.skill_id
);

SELECT
    skill_name,
    COUNT(skill_name)
FROM main.job_skill_priorities
GROUP BY ALL;