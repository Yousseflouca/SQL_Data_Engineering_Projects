USE company_jobs;
CREATE TEMPORARY TABLE ds_skills_count_temp AS
SELECT 
    sd.skills,
    COUNT(jpf.job_id) AS skill_count,
FROM data_jobs.job_postings_fact AS jpf 
    JOIN data_jobs.skills_job_dim AS sjd 
        ON jpf.job_id = sjd.job_id
    JOIN data_jobs.skills_dim AS sd 
        ON sjd.skill_id = sd.skill_id
WHERE
    jpf.job_title_short = 'Data Scientist'
GROUP BY
    sd.skills;

SELECT *
FROM ds_skills_count_temp;