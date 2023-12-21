DROP TABLE response;
DROP TABLE resume;
DROP TABLE vacancy;
DROP TABLE specialization;
DROP TABLE applicant;
DROP TABLE employer;
DROP TABLE area;

CREATE TABLE area (
    area_id   SERIAL PRIMARY KEY,
    area_name TEXT NOT NULL
);

CREATE TABLE employer (
    employer_id    SERIAL PRIMARY KEY,
    employer_name  TEXT NOT NULL,
    employer_email TEXT NOT NULL UNIQUE,
    area_id        INTEGER REFERENCES area (area_id)
);

CREATE TABLE applicant (
    applicant_id    SERIAL PRIMARY KEY,
    applicant_name  VARCHAR(100) NOT NULL,
    applicant_email TEXT NOT NULL UNIQUE
);

CREATE TABLE specialization (
    spec_id   SERIAL PRIMARY KEY,
    spec_name TEXT NOT NULL
);

CREATE TABLE vacancy (
    vacancy_id          SERIAL PRIMARY KEY,
    vacancy_title       TEXT         NOT NULL,
    vacancy_description TEXT         NOT NULL,
    compensation_from   INTEGER      NOT NULL,
    compensation_to     INTEGER      NOT NULL,
    compensation_gross  BOOLEAN      NOT NULL,
    timestamp           TIMESTAMP    NOT NULL DEFAULT NOW(),
    area_id             INTEGER NOT NULL REFERENCES area (area_id),
    spec_id             INTEGER NOT NULL REFERENCES specialization (spec_id),
    employer_id         INTEGER NOT NULL REFERENCES employer (employer_id) NOT NULL
);

CREATE TABLE resume (
    resume_id          SERIAL PRIMARY KEY,
    resume_description TEXT      NOT NULL,
    timestamp          TIMESTAMP NOT NULL DEFAULT NOW(),
    area_id            INTEGER NOT NULL REFERENCES area (area_id),
    spec_id            INTEGER NOT NULL REFERENCES specialization (spec_id),
    applicant_id       INTEGER NOT NULL REFERENCES applicant (applicant_id)
);

CREATE TABLE response (
    response_id        SERIAL PRIMARY KEY,
    timestamp          TIMESTAMP NOT NULL DEFAULT NOW(),
    vacancy_id         INTEGER NOT NULL REFERENCES vacancy (vacancy_id),
    resume_id          INTEGER NOT NULL REFERENCES resume (resume_id)
);
