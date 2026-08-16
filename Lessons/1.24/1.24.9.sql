USE company_jobs;

DELETE FROM staging.priority_skills WHERE skill_id = 1;
SELECT *
FROM staging.priority_skills;

MERGE INTO main.job_skill_priorities AS tgt
USING (
    SELECT *
    FROM data_jobs.skills_job_dim AS sjd 
    JOIN staging.priority_skills AS ps
    ON sjd.skill_id = ps.skill_id
) AS src 
ON src.job_id = tgt.job_id
    AND src.skill_id = tgt.skill_id

WHEN MATCHED THEN
    UPDATE SET
        priority_lvl = src.priority_lvl

WHEN NOT MATCHED THEN
    INSERT (job_id, skill_id, skill_name, priority_lvl, status)
    VALUES (src.job_id, src.skill_id, src.skill_name, src.priority_lvl, 'NEW SKILL')

WHEN NOT MATCHED BY SOURCE THEN DELETE;

SELECT *
FROM main.job_skill_priorities;
WHERE skill_id = 1;
