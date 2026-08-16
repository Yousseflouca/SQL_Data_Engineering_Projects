USE data_jobs;
SELECT
    job_id,
    job_title_short,
    job_location
FROM job_postings_fact
WHERE
    job_country IN (
        WITH country_postings_count AS (
            SELECT
                job_country,
                COUNT(*) AS job_count,
                (
                    SELECT COUNT(*)
                    FROM job_postings_fact
                )/(
                    SELECT COUNT(DISTINCT job_country)
                    FROM job_postings_fact
                ) AS avg_count_per_country
            FROM job_postings_fact
            GROUP BY job_country
            HAVING job_count > avg_count_per_country
        )
        SELECT job_country 
        FROM country_postings_count
    )
ORDER BY 
    job_country,
    job_id;




-- Another Solution
SELECT
    jpf.job_id,
    jpf.job_title_short,
    jpf.job_location
FROM
    job_postings_fact AS jpf
WHERE
    jpf.job_country IN (
        SELECT
            job_country
        FROM
            job_postings_fact
        GROUP BY
            job_country
        HAVING
            COUNT(job_id) > (
                SELECT AVG(country_count)
                FROM (
                    SELECT COUNT(job_id) AS country_count
                    FROM job_postings_fact
                    GROUP BY job_country
                ) AS country_counts
            )
    )
ORDER BY
    jpf.job_country, jpf.job_id;



USE data_jobs;
SELECT
    job_id,
    job_title_short,
    job_location
FROM
    job_postings_fact
WHERE
    job_country IN (
        SELECT
            job_country 
        FROM
            job_postings_fact 
        GROUP BY
            job_country
        HAVING
            COUNT(job_id) > (
                SELECT AVG(job_count)
                FROM (
                    SELECT
                        COUNT(*) AS job_count
                    FROM
                        job_postings_fact
                    GROUP BY
                        job_country
                )
            )
    );








