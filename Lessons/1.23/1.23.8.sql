SELECT
    jpf.job_id,
    jpf.job_title_short,
FROM
    job_postings_fact AS jpf
WHERE
    jpf.job_title_short = 'Data Engineer'
    AND EXISTS (
    SELECT *
    FROM skills_job_dim AS sjd 
        JOIN skills_dim AS sd 
        ON sjd.skill_id = sd.skill_id
    WHERE
        jpf.job_id = sjd.job_id
        AND sd.skills = 'python'
);


-- Another way of doing it
SELECT
    jpf.job_id,
    jpf.job_title_short,
FROM
    job_postings_fact AS jpf
    JOIN skills_job_dim AS sjd
    ON jpf.job_id = sjd.job_id
    JOIN skills_dim AS sd
    ON sjd.skill_id = sd.skill_id
WHERE
    jpf.job_title_short = 'Data Engineer'
    AND sd.skills = 'python';
