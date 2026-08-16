USE company_jobs;
INSERT INTO staging.priority_skills (skill_id, skill_name, priority_lvl)
VALUES
    (77, 'aws', 3);

SELECT *
FROM staging.priority_skills;

MERGE INTO main.job_skill_priorities AS tgt
USING (
    SELECT *
    FROM data_jobs.skills_job_dim AS sjd
    JOIN staging.priority_skills AS ps
    ON sjd.skill_id = ps.skill_id
) AS src
ON src.job_id = tgt.skill_id

WHEN MATCHED THEN
    UPDATE SET
        priority_lvl = src.priority_lvl,
        skill_name = src.skill_name

WHEN NOT MATCHED THEN
    INSERT (
        job_id,
        skill_id,
        skill_name,
        priority_lvl,
        status
    )
    VALUES (
        src.job_id,
        src.skill_id,
        src.skill_name,
        src.priority_lvl,
        'NEW SKILL'
    );

-- DELETE FROM main.job_skill_priorities
-- WHERE rowid NOT IN (
--     SELECT
--         MIN(rowid)
--     FROM main.job_skill_priorities
--     GROUP BY
--         job_id,
--         skill_id,
--         skill_name
-- );




DESCRIBE
SELECT *
FROM main.job_skill_priorities
ORDER BY job_id;