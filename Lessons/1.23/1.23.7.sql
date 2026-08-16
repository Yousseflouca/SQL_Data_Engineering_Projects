SELECT
    name
FROM company_dim AS src
WHERE EXISTS (
    SELECT 1
    FROM job_postings_fact AS tgt
    WHERE src.company_id = tgt.company_id
);