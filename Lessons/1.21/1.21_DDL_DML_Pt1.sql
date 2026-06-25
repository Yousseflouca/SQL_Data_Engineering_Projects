-- .read Lessons/1.21/1.21_DDL_DML_Pt1.sql (f you just want 1 termnal command to run the code)
-- I want the script to be idempotent (basically every time you run it you get the same output)
USE data_jobs;
DROP DATABASE IF EXISTS jobs_mart;
--CREATE DATABASE jobs_mart
-- you cand do this also

CREATE DATABASE IF NOT EXISTS jobs_mart;
SHOW DATABASES;
-- DROP DATABASE IF EXISTS jobs_mart;

SELECT *
FROM information_schema.schemata;

USE jobs_mart; -- you can use ths to navigate to the jobs_mart database
CREATE SCHEMA IF NOT EXISTS staging;

--CREATE SCHEMA jobs_mart.staging;

-- DROP SCHEMA IF EXISTS staging;


CREATE TABLE IF NOT EXISTS staging.preferred_roles (
    role_id INTEGER PRIMARY KEY,
    role_name VARCHAR
);

SELECT *
FROM information_schema.tables
WHERE table_catalog = 'jobs_mart';

-- DROP TABLE IF EXISTS main.preferred_roles;

INSERT INTO staging.preferred_roles (role_id, role_name)
VALUES 
    (1, 'Data Engineer'),
    (2, 'Senior Data Engineer'),
    (3, 'Software Engineer');

SELECT *
FROM staging.preferred_roles;
    

ALTER TABLE staging.preferred_roles
ADD COLUMN preferred_role BOOLEAN;

/*
ALTER TABLE staging.preferred_roles
DROP COLUMN preferred_role;
*/

UPDATE staging.preferred_roles
SET preferred_role = TRUE
WHERE role_id = 1 OR role_id = 2;

UPDATE staging.preferred_roles
SET preferred_role = FALSE
WHERE role_id = 3;

ALTER TABLE staging.preferred_roles
RENAME TO priority_roles;

SELECT *
FROM staging.priority_roles;

ALTER TABLE staging.priority_roles
RENAME COLUMN preferred_role TO priority_lvl;

ALTER TABLE staging.priority_roles
ALTER COLUMN priority_lvl TYPE INTEGER;

UPDATE staging.priority_roles
SET priority_lvl = 3
WHERE role_id = 3;

SELECT *
FROM staging.priority_roles;