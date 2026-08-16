SELECT
    job_title_short,
    salary_year_avg,
    job_posted_date,
    LEAD(salary_year_avg) OVER(
        PARTITION BY job_title_short
        ORDER BY job_posted_date
    ) AS next_posting_salary,
    CASE
        WHEN salary_year_avg < LEAD(salary_year_avg) OVER(PARTITION BY job_title_short ORDER BY job_posted_date)
        THEN 'Increasing'
        WHEN salary_year_avg > LEAD(salary_year_avg) OVER(PARTITION BY job_title_short ORDER BY job_posted_date)
        THEN 'Decreasing'
        ELSE 'Stable'
    END AS trend_directon
FROM
    job_postings_fact
WHERE
    salary_year_avg IS NOT NULL
    AND job_title_short = 'Data Analyst';

