USE company_jobs;

CREATE SCHEMA IF NOT EXISTS staging;

SELECT
    catalog_name,
    schema_name
FROM information_schema.schemata;

CREATE OR REPLACE TABLE staging.priority_skills (
    skill_id INTEGER PRIMARY KEY,
    skill_name VARCHAR,
    priority_lvl INTEGER
);

SELECT 
    table_schema,
    table_name
FROM information_schema.tables
WHERE table_catalog = 'company_jobs';

INSERT INTO staging.priority_skills (skill_id, skill_name, priority_lvl)
VALUES
    (1,     'python',   1),
    (0,     'sql',      1),
    (183,   'tableau',  2);

SELECT *
FROM staging.priority_skills;

SELECT *
SELECT
    job_id,
    skill_id,
    COUNT(*) AS duplicate_count
FROM main.job_skill_priorities
GROUP BY
    job_id,
    skill_id
HAVING COUNT(*) > 1;