
-- Для поиска по названию вакансии
CREATE INDEX vacancy_title_idx ON vacancy(vacancy_title);

-- Для поиска по имени работодателя
CREATE INDEX employer_name_idx ON employer(employer_name);

-- Индекс, чтобы ускорить фильтровать резюме по дате публикации
CREATE INDEX resume_timestamp_idx ON resume(timestamp);

-- Для поиска по вилке зарплаты
CREATE INDEX vacancy_compensation_idx ON vacancy(compensation_to, compensation_from);

-- Для поиска вакансии по конкретному id работодателя
CREATE INDEX vacancy_company_id_idx ON vacancy(employer_id);

-- Для поиска резюме по названию специализации
CREATE INDEX specialization_id_idx ON resume(spec_id);
