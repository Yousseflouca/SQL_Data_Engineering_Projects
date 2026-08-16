USE company_jobs;

DELETE FROM staging.priority_skills WHERE skill_id = 183;

SELECT *
FROM staging.priority_skills;

MERGE INTO main.job_skill_priorities AS tgt
USING staging.priority_skills AS src
ON src.skill_id = tgt.skill_id

WHEN NOT MATCHED BY SOURCE THEN
    UPDATE SET 
        status = 'INACTIVE';

SELECT
    skill_name,
    COUNT(skill_name) AS skill_count,
    status
FROM main.job_skill_priorities
GROUP BY skill_name, status;