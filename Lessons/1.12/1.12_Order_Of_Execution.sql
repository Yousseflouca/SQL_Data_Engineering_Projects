/* 
Find the top 10 companies for posting jobs 
They must have >3000 postings
LIMIT this to only US jobs
*/
-- MY CODE
SELECT
    jpf.job_via,
    COUNT(jpf.job_via) AS job_count
FROM 
    job_postings_fact AS jpf 
GROUP BY
    jpf.job_via
HAVING
    job_count > 3000
ORDER BY
    job_count DESC
LIMIT 10;

-- LUKE's CODE
-- EXPLAIN (without execution) different from EXPLAIN ANALYZE (after execution)
EXPLAIN ANALYZE
    SELECT
        cd.name AS company_name,
        COUNT(jpf.*) AS posting_count
    FROM job_postings_fact AS jpf 
        LEFT JOIN company_dim AS cd 
            ON jpf.company_id = cd.company_id
    WHERE
        jpf.job_country = 'United States'
    GROUP BY cd.name
    HAVING
        COUNT(jpf.*) > 3000
    ORDER BY
        posting_count DESC
    LIMIT 10;

SELECT job_title_short
FROM job_postings_fact
WHERE salary_year_avg > 100_000
LIMIT 10;