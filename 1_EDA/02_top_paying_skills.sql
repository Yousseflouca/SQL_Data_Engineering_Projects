/*
Question: What are the highest-paying skills for Data Engineers?
- Calculate the Median Salary for each sqill required in data engineering positions
- Focus on remote positions with specific salaries
- Include skill frequency to identify both salary and demand
- Why? Helps identify which skills command he highest compensation while also showing
how common those skills are, providing a more complete picture for skill development priorities
*/
SELECT 
    sd.skills,
    ROUND(MEDIAN(jpf.salary_year_avg), 0) AS median_salary,
    COUNT(jpf.*) AS demand_count
FROM job_postings_fact AS jpf
    INNER JOIN skills_job_dim AS sjd
        ON jpf.job_id = sjd.job_id
    INNER JOIN skills_dim AS sd 
        ON sjd.skill_id = sd.skill_id
WHERE
    jpf.job_title_short = 'Data Analyst'
    AND jpf.job_work_from_home IS TRUE
GROUP BY
    sd.skills
HAVING
    COUNT(jpf.*) > 100
ORDER BY
    median_salary DESC
LIMIT 25;

/*
Here is a breakdown of the highest paying skilss for Data Engineers
around the world
- Rust is the highest-paying skill, with a median salary of $210,000, but demand is 
relatively low at 232 postings. This suggests it is a niche but highly rewarded skill.

- Golang and Terraform both have very high median salaries at $184,000. However, 
Terraform has much stronger demand, with 3,248 postings compared to 912 for Golang.

- Terraform stands out as one of the best skills in this list because it 
combines both high salary and strong demand.

- Skills such as Spring, Neo4j, GDPR, GraphQL, Mongo, and FastAPI also show high 
salaries, but their demand counts are lower. This means they are more specialized skills.

- Some skills offer high salary potential but are niche, such as Rust, Neo4j, Zoom,
 Mongo, and FastAPI. These may be valuable for specific roles but are not as widely requested.

- Overall, the highest-paying remote Data Engineer roles reward candidates with a mix 
of backend engineering, cloud infrastructure, database, and modern data platform skills.

- Main takeaway: Terraform appears to be the strongest high-value skill because it has both
 a high median salary and a strong demand count among the top-paying skills.

┌────────────┬───────────────┬──────────────┐
│   skills   │ median_salary │ demand_count │
│  varchar   │    double     │    int64     │
├────────────┼───────────────┼──────────────┤
│ rust       │      210000.0 │          232 │
│ golang     │      184000.0 │          912 │
│ terraform  │      184000.0 │         3248 │
│ spring     │      175500.0 │          364 │
│ neo4j      │      170000.0 │          277 │
│ gdpr       │      169616.0 │          582 │
│ zoom       │      168438.0 │          127 │
│ graphql    │      167500.0 │          445 │
│ mongo      │      162250.0 │          265 │
│ fastapi    │      157500.0 │          204 │
│ bitbucket  │      155000.0 │          478 │
│ django     │      155000.0 │          265 │
│ crystal    │      154224.0 │          129 │
│ c          │      151500.0 │          444 │
│ atlassian  │      151500.0 │          249 │
│ typescript │      151000.0 │          388 │
│ kubernetes │      150500.0 │         4202 │
│ ruby       │      150000.0 │          736 │
│ node       │      150000.0 │          179 │
│ airflow    │      150000.0 │         9996 │
│ css        │      150000.0 │          262 │
│ redis      │      149000.0 │          605 │
│ vmware     │      148798.0 │          136 │
│ ansible    │      148798.0 │          475 │
│ jupyter    │      147500.0 │          400 │
└────────────┴───────────────┴──────────────┘
  25 rows                         3 columns
*/