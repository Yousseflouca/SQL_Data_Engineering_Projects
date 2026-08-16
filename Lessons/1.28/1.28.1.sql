USE company_jobs;
CREATE SCHEMA  IF NOT EXISTS work_mode_mart;

CREATE OR REPLACE TABLE work_mode_mart.remote_jobs AS
SELECT
    j.job_title,
    j.company_id,
    j.job_location
FROM
    data_jobs.job_postings_fact AS j
WHERE
    j.job_work_from_home IS TRUE
    AND j.job_location = 'Anywhere';

SELECT
    COUNT(*) AS remote_rows
FROM 
    work_mode_mart.remote_jobs;

