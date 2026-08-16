SELECT
    DISTINCT sd.skills
FROM skills_dim AS sd
WHERE NOT EXISTS (
    SELECT 1
    FROM skills_job_dim AS sjd
        JOIN job_postings_fact AS jpf
        ON sjd.job_id = jpf.job_id
    WHERE
        sd.skill_id = sjd.skill_id AND
        jpf.job_title_short = 'Senior Data Engineer'
);

