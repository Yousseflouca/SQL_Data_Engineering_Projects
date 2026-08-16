WITH skills_array AS (
    SELECT
        job_id,
        ARRAY_AGG(skill_id) AS skill_id_array
    FROM skills_job_dim
    GROUP BY job_id
), flattened_skills_array AS (
    SELECT
        job_id,
        UNNEST(skill_id_array) AS skill_id
    FROM skills_array
)
SELECT
    fsa.job_id,
    sd.skills AS skill_name
FROM flattened_skills_array AS fsa
JOIN skills_dim AS sd
    ON fsa.skill_id = sd.skill_id;