-- Array/ List Intro
SELECT [1, 2, 3];
SELECT ['python', 'sql', 'r'] AS skills_array;

-- Converting column into an Array using ARRAY_AGG function (you can also use LIST function which is the exact same thing)
-- The second CTE is to access individual components of a list
-- In order to return the Array ordered, you have to write the function ARRAY_AGG(... ORDER BY ...)
WITH skills AS (
    SELECT 'python' AS skill
    UNION ALL
    SELECT 'sql'
    UNION ALL
    SELECT 'r'
), skills_array AS (
    SELECT ARRAY_AGG(skill ORDER BY skill) AS skills
    FROM skills
)
SELECT 
    skills[1] AS first_skill,
    skills[2] AS second_skill,
    skills[3] AS third_skill
FROM skills_array;

-- STRUCT
SELECT { skill: 'python', type: 'programming'} AS skill_struct;

-- Create a STRUCT using Function STRUCT_PACK
WITH skill_struct AS (
    SELECT
        STRUCT_PACK(
            skill := 'python',
            type := 'programming'
        ) AS s
)
SELECT
    s.skill,
    s.type
FROM skill_struct;

-- Convert a Table into a struct
WITH skill_table AS (
    SELECT 'python' AS skills, 'programming' AS types
    UNION ALL
    SELECT 'sql', 'programming'
    UNION ALL
    SELECT 'r', 'programming'
)
SELECT
    STRUCT_PACK(
        skill := skills,
        type := types
    )
FROM skill_table;

-- Array of Structs
SELECT [
    { skill: 'python', type: 'programming'},
    { skill: 'sql', type: 'query_language'}
] AS skills_array_of_structs;


-- This Initially was struct in 3 rows.
-- Now we want to make it as an Array of Sructs
-- We first make a struct from the table using STRUCT_PACK
-- Then we make an array of that struct using ARRAY_AGG
WITH skill_table AS (
    SELECT 'python' AS skills, 'programming' AS types
    UNION ALL
    SELECT 'sql', 'programming'
    UNION ALL
    SELECT 'r', 'programming'
), skills_array_struct AS (
    SELECT
        ARRAY_AGG(
            STRUCT_PACK(
                skill := skills,
                type := types
            )
        ) AS array_struct
    FROM skill_table
)
SELECT
    array_struct[1].skill,
    array_struct[2].type,
    array_struct[3]
FROM
    skills_array_struct;

-- Map
-- Map keys must be unique. Maps are same as dictionaries in Python
WITH skill_map AS (
    SELECT MAP { 'skill': 'python', 'type': 'programming'} AS skill_type
)
SELECT 
    skill_type['skill'],
    skill_type['type']
FROM 
    skill_map;

-- JSON
WITH raw_skill_json AS (
    SELECT
        '{"skill":"python", "type":"programming"}'::JSON AS skill_json
        -- You can also do it like this
        --TO_JSON('{"skill":"python", "type":"programming"}') AS skill_json;
)
SELECT
    STRUCT_PACK(
        skill := json_extract_string(skill_json, '$.skill'),
        type := json_extract_string(skill_json, '$.type')
    )
FROM
    raw_skill_json;

-- JSON to Array of Structs
with raw_json AS (
    SELECT
        '[
            {"skill":"python", "type":"programming"},
            {"skill":"sql", "type":"query_language"},
            {"skill":"r", "type":"programming"}
        ]'::JSON AS skills_json
)
SELECT
    ARRAY_AGG (
        STRUCT_PACK(
        skill := json_extract_string(e.value, '$.skill'),
        type := json_extract_string(e.value, '$.type')
        )
        ORDER BY json_extract_string(e.value, '$.skill')
    ) AS skills
FROM raw_json, json_each(skills_json) AS e;


-- Arrays - final Example
-- Build a flat skill table for co-workers to access job titles, salary info, and skills in one table

CREATE OR REPLACE TEMP TABLE job_skills_array AS 
SELECT
    jpf.job_id,
    jpf.job_title_short,
    jpf.salary_year_avg,
    ARRAY_AGG(sd.skills) AS skills_array
FROM job_postings_fact AS jpf 
LEFT JOIN skills_job_dim AS sjd 
    ON jpf.job_id = sjd.job_id
LEFT JOIN skills_dim AS sd 
    ON sjd.skill_id = sd.skill_id
GROUP BY ALL; 

-- From the perspective of a Data Analyst, analyze the median salary per skill
-- The UNNEST function from the word splits the array into individual elements

WITH flat_skills AS (
    SELECT
        job_id,
        job_title_short,
        salary_year_avg,
        UNNEST(skills_array) AS skill
    FROM
        job_skills_array
)
SELECT
    skill,
    MEDIAN(salary_year_avg) AS median_salary
FROM
    flat_skills
GROUP BY
    skill
ORDER BY
    median_salary DESC;

-- Array of Structs - Final Example
-- Build a flat skill type table for co-workers to access job titles, salary info, skills and type in one table

CREATE OR REPLACE TEMP TABLE job_skills_array_struct AS 
SELECT
    jpf.job_id,
    jpf.job_title_short,
    jpf.salary_year_avg,
    ARRAY_AGG(
        STRUCT_PACK(
            skill_type := sd.type,
            skill_name := sd.skills
        )
    ) AS skills_type
FROM job_postings_fact AS jpf 
LEFT JOIN skills_job_dim AS sjd 
    ON jpf.job_id = sjd.job_id
LEFT JOIN skills_dim AS sd 
    ON sjd.skill_id = sd.skill_id
GROUP BY ALL; 

-- From the perspective of a Data Analyst, analyze the median salary per type of skill

WITH flat_skills AS (
    SELECT
        job_id,
        job_title_short,
        salary_year_avg,
        UNNEST(skills_type).skill_type AS skill_type,
        UNNEST(skills_type).skill_name AS skill_name
    FROM
        job_skills_array_struct
)
SELECT
    skill_type,
    MEDIAN(salary_year_avg) AS median_salary
FROM
    flat_skills
GROUP BY
    skill_type;

SELECT *
FROM skills_dim;