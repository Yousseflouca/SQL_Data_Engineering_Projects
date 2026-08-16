WITH salary_array AS (
    SELECT
        company_id,
        ARRAY_AGG(salary_year_avg) AS company_salaries
    FROM job_postings_fact
    WHERE salary_year_avg IS NOT NULL
    GROUP BY company_id
), salary_flattened AS (
    SELECT
        company_id,
        UNNEST(company_salaries) AS specific_salary,
        LIST_AVG(company_salaries) AS avg_company_salary
    FROM salary_array
)
SELECT
    company_id,
    specific_salary,
    avg_company_salary
FROM salary_flattened
WHERE specific_salary > (1.5*avg_company_salary);