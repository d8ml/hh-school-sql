WITH months_count AS (SELECT count(timestamp)                 AS vacancy_count,
                             to_char(timestamp, 'Month YYYY') AS month_year
                      FROM vacancy
                      GROUP BY month_year)
SELECT month_year
FROM months_count
WHERE vacancy_count = (SELECT max(vacancy_count) FROM months_count);


WITH months_count AS (SELECT count(timestamp)                 AS resume_count,
                             to_char(timestamp, 'Month YYYY') AS month_year
                      FROM resume
                      GROUP BY month_year)
SELECT month_year
FROM months_count
WHERE resume_count = (SELECT max(resume_count) FROM months_count);
