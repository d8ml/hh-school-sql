WITH spec_data(id, name) AS (
       SELECT 
              generate_series(1, 1000) AS id,
              md5(random()::text)      AS name
)
INSERT
INTO specialization(spec_id, spec_name)
SELECT id, name
FROM spec_data;

WITH area_data(id, name) AS (
       SELECT 
              generate_series(1, 1000) AS id,
              md5(random()::text)      AS name
)
INSERT
INTO area(area_id, area_name)
SELECT id, name
FROM area_data;

WITH employer_data(id, name, area_id) AS (
       SELECT 
              generate_series(1, 10000)  AS id,
              md5(random()::text)        AS name,
              floor(random() * 1000) + 1 AS area_id
)
INSERT
INTO employer(employer_id, employer_name, employer_email, area_id)
SELECT id, name, concat(name, '@', id,'.','ru'), area_id
FROM employer_data;

WITH applicant_data(id, name) AS (
       SELECT 
              generate_series(1, 100000) AS id,
              md5(random()::text)        AS name
)
INSERT
INTO applicant(applicant_id, applicant_name, applicant_email)
SELECT id, name, concat(name, '@', id,'.','ru')
FROM applicant_data;

WITH resume_data(id, name, timestamp, area_id, spec_id, applicant_id) AS (
       SELECT 
              generate_series(1, 100000)                            AS id,
              md5(random()::text)                                   AS name,
              now() - floor(random() * 365 * 3) * '1 day'::interval AS creation_timestamp,
              floor(random() * 1000) + 1                            AS area_id,
              floor(random() * 1000) + 1                            AS specialication_id,
              floor(random() * 100000) + 1                          AS applicant_id
)
INSERT
INTO resume(resume_id, resume_description, timestamp, area_id, spec_id, applicant_id)
SELECT id, name, timestamp, area_id, spec_id, applicant_id
FROM resume_data;


WITH vacancy_data(id, name) AS (
       SELECT 
              generate_series(1, 10000)                             AS id,
              md5(random()::text)                                   AS name,
              md5(random()::text)                                   AS description,
              round((random() * 100000)::int, -3)                   as salary,
              now() - floor(random() * 365 * 3) * '1 day'::interval AS timestamp,
              floor(random() * 1000) + 1                            AS area_id,
              floor(random() * 1000) + 1                            AS spec_id,
              floor(random() * 10000) + 1                           AS employer_id
)
INSERT
INTO vacancy(vacancy_id,
             vacancy_title,
             vacancy_description,
             compensation_from,
             compensation_to,
             compensation_gross,
             timestamp,
             area_id,
             spec_id,
             employer_id
)
SELECT id,
       name,
       description,
       salary,
       salary + 10000,
       true,
       timestamp,
       area_id,
       spec_id,
       employer_id
FROM vacancy_data;

WITH response_data(id, vacancy_id, resume_id) AS (
       SELECT 
              generate_series(1, 50000)    AS id,
              floor(random() * 10000) + 1  AS vacancy_id,
              floor(random() * 100000) + 1 AS resume_id
)
INSERT
INTO response(response_id, timestamp, vacancy_id, resume_id)
SELECT id,
       (SELECT vacancy.timestamp FROM vacancy WHERE vacancy.vacancy_id = response_data.vacancy_id LIMIT 1) +
       floor(random() * 15) * '1 day'::interval,
       vacancy_id,
       resume_id
FROM response_data;
