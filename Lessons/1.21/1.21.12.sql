USE company_jobs;

ALTER TABLE dev.internal_applications_fact
DROP COLUMN internal_candidate;

DESCRIBE dev.internal_applications_fact;

SELECT *
FROM dev.internal_applications_fact;