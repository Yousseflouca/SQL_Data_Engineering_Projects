USE company_jobs;
CREATE TABLE IF NOT EXISTS main.job_skill_priorities (
    job_id INTEGER,
    skill_id INTEGER,
    skill_name VARCHAR,
    priority_lvl INTEGER,
    status VARCHAR    
);

DESCRIBE
SELECT *
FROM job_skill_priorities;

INSERT INTO main.job_skill_priorities (job_id, skill_id, status)
SELECT
    sjd.job_id,
    ps.skill_id,
    'ACTIVE' AS status
FROM staging.priority_skills AS ps
INNER JOIN data_jobs.skills_job_dim AS sjd 
    ON sjd.skill_id = ps.skill_id;

SELECT *
FROM job_skill_priorities;

