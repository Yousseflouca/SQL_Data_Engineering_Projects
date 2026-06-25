USE company_jobs;

ALTER TABLE dev.applications_fact
ALTER COLUMN follow_up_timestamp TYPE DATE;

SELECT *
FROM dev.applications_fact;