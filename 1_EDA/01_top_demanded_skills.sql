/*
Question: What are the most in demand skills for data engineers?
- Identify the top 10 in-demand skills for data engineers
- Focus on remote job postings 
- Why? Retrieves the top 10 skills with the highest demand in remote jobs
    providing insights into the most valuable skills for data engineers.
*/

SELECT 
    sd.skills,
    COUNT(jpf.*) AS demand_count
FROM job_postings_fact AS jpf
    INNER JOIN skills_job_dim AS sjd
        ON jpf.job_id = sjd.job_id
    INNER JOIN skills_dim AS sd 
        ON sjd.skill_id = sd.skill_id
WHERE
    jpf.job_title_short = 'Data Engineer'
    AND jpf.job_work_from_home IS TRUE
GROUP BY
    sd.skills
ORDER BY
    demand_count DESC
LIMIT 10;

/*
┌────────────┬──────────────┐
│   skills   │ demand_count │
│  varchar   │    int64     │
├────────────┼──────────────┤
│ sql        │        29221 │
│ python     │        28776 │
│ aws        │        17823 │
│ azure      │        14143 │
│ spark      │        12799 │
│ airflow    │         9996 │
│ snowflake  │         8639 │
│ databricks │         8183 │
│ java       │         7267 │
│ gcp        │         6446 │
└────────────┴──────────────┘
  10 rows         2 columns

Based on these results, the following conclusions can be made
-SQL and Python dominate the market** as the two most in-demand 
skills for Data Engineers worldwide, showing that strong data 
querying and programming foundations are essential.

-Cloud expertise is a major requirement, with AWS, Azure, and GCP 
all appearing in the top skills. This shows that companies are 
moving their data systems to cloud platforms.

-AWS leads the cloud demand, followed by Azure and GCP, making AWS 
the strongest global cloud skill for Data Engineers in this dataset.

-Big data tools are highly valued, especially Spark and Databricks,which 
shows that many companies need engineers who can work with large-scale data.

-Pipeline automation is important, with Airflow ranking highly. This means
companies want Data Engineers who can build reliable, automated data workflows.

-Modern data platforms are becoming standard, especially Snowflake and Databricks,
showing strong demand for cloud-based warehouses and lakehouse tools.

-Overall conclusion: The most valuable Data Engineer profile combines SQL, 
Python, cloud knowledge, big data processing, and pipeline automation.

*/