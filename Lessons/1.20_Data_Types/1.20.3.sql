SELECT
    jpf.job_title_short,
    (AVG(salary_hour_avg)*40*52)::DECIMAL(12,2) AS salary_hour_annual,
    (AVG(salary_hour_avg)*40*52)::DECIMAL(12,0) AS salary_hour_annual_zero_decimals
FROM
    job_postings_fact AS jpf
WHERE
    jpf.job_country = 'United States' AND 
    jpf.salary_hour_avg IS NOT NULL 
GROUP BY
    job_title_short
ORDER BY
    salary_hour_annual DESC;