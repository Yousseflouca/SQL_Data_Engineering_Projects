SELECT
    job_title_short,
    job_work_from_home,
    AVG(salary_year_avg)::INTEGER annual_salary_avg,
    (260*(annual_salary_avg/2080)*(job_work_from_home::INTEGER))::INTEGER AS annual_commute_cost_savings,
    annual_salary_avg + annual_commute_cost_savings AS adjusted_annual_salary_avg
FROM
    job_postings_fact
WHERE
    job_country = 'United States' AND
    job_title_short LIKE '%Data%'
GROUP BY
    job_title_short,
    job_work_from_home
ORDER BY
    job_title_short DESC,
    job_work_from_home;