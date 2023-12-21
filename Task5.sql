SELECT vacancy_id, vacancy_title
FROM vacancy
INNER JOIN response USING (vacancy_id)
WHERE vacancy.timestamp + '1 week'::interval > response.timestamp
GROUP BY vacancy_id, vacancy_title
HAVING count(*) > 5;
