with normalized_salary AS(
    SELECT
        job_id,
        job_title_short,
        salary_year_avg,
        MIN(salary_year_avg) OVER(PARTITION BY job_title_short) AS min_s,
        MAX(salary_year_avg) OVER(PARTITION BY job_title_short) AS max_s
    FROM
        job_postings_fact
    WHERE
        salary_year_avg IS NOT NULL
)

SELECT
    *,
    CASE
        WHEN max_s = min_s THEN 1 
        ELSE (salary_year_avg - min_s)/ (max_s - min_s) 
    END AS normalized_salary_score
FROM
    normalized_salary;