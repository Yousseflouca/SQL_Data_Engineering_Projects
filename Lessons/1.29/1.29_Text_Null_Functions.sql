-- Length
SELECT LENGTH('SQL');
SELECT CHAR_LENGTH('SQL');

SELECT LOWER('SQL');
SELECT UPPER('Sql');

--Substring Extraction
SELECT LEFT('SQL',2);
SELECT RIGHT('SQL',2);
SELECT SUBSTRING('SQL', 2, 2);

SELECT CONCAT('SQL', '-', 'Functions');
SELECT 'SQL'||'-'||'Functions';

--TRIMMING (removing extra space)
SELECT '  SQL  ';
SELECT TRIM('  SQL  '); -- There is also LTRIM and RTRIM

--Replacement
SELECT REPLACE('SQL', 'Q', '_');

SELECT regexp_extract('youssefdiaassd@gmail.com', '@([A-Za-z0-9.-]+\.[A-Za-z]{2,})', 1); -- using CHATGPT

-- Final Example - Cleanup this using Text Functions
with title_lower AS (
    SELECT
        job_title,
        LOWER(TRIM(job_title)) AS job_title_clean
    FROM
        job_postings_fact
)

SELECT
    job_title,
    CASE
        WHEN job_title_clean LIKE '%data%' AND job_title_clean LIKE '%analyst%' THEN 'Data Analyst'
        WHEN job_title_clean LIKE '%data%' AND job_title_clean LIKE '%engineer%' THEN 'Data Engineer'
        WHEN job_title_clean LIKE '%data%' AND job_title_clean LIKE '%scientist%' THEN 'Data Scientist'
        ELSE 'Other'
    END AS job_title_category
FROM title_lower
ORDER BY RANDOM()
LIMIT 20;

SELECT NULLIF(10, 10);
SELECT NULLIF(11, 30);
SELECT NULLIF(5 + 5, 20);

SELECT
    MEDIAN(NULLIF(salary_year_avg, 0)),
    MEDIAN(NULLIF(salary_hour_avg, 0))
FROM
    job_postings_fact
WHERE salary_hour_avg IS NOT NULL OR salary_year_avg IS NOT NULL
LIMIT 10;

SELECT
    salary_year_avg,
    salary_hour_avg,
    COALESCE(salary_year_avg, salary_hour_avg*2080)
FROM
    job_postings_fact
WHERE salary_hour_avg IS NOT NULL OR salary_year_avg IS NOT NULL
LIMIT 10;

-- COALESCE Returns first Non-Null value 

SELECT COALESCE(NULL, NULL, 2);