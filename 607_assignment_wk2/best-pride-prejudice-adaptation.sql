-- Database: wk2assignment

CREATE DATABASE wk2assignment
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'C'
    LC_CTYPE = 'C'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;
    
-- Scheme: wk2assignment
    
CREATE SCHEMA IF NOT EXISTS wk2assignment
    AUTHORIZATION postgres;

COMMENT ON SCHEMA wk2assignment
    IS 'standard public schema';

GRANT ALL ON SCHEMA wk2assignment TO PUBLIC;

GRANT ALL ON SCHEMA wk2assignment TO postgres;
    
-- Table: wk2assignment.movies

CREATE TABLE IF NOT EXISTS wk2assignment.movies
(
    id integer NOT NULL,
    title text COLLATE pg_catalog."default" NOT NULL,
    year integer NOT NULL,
    actor text COLLATE pg_catalog."default" NOT NULL,
    actress text COLLATE pg_catalog."default" NOT NULL,
    imdb numeric NOT NULL,
    CONSTRAINT movies_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS wk2assignment.movies
    OWNER to postgres;

INSERT INTO movies(
	id, title, year, actor, actress, imdb)
	VALUES 
   (1, 'Bridge and Prejudice', 2004, 'Martin Henderson', 'Aishwarya Rai Bachchan', 6.2),
    (2, 'Bridget Jones Diary', 2001, 'Mark Darcy', 'Renee Zellwger', 6.8),
    (3, 'Pride and Prejudice', 2005, 'Matthew Macfadyen', 'Keira Knightley', 7.8),
	(4, 'Pride and Prejudice and Zombies', 2016, 'Sam Riley', 'Lily James', 5.8),
	(5, 'Pride and Prejudice', 1940, 'Laurence Olivier', 'Greer Garson', 7.4),
	(6, 'Pride and Prejudice', 1980, 'David Rintoul', 'Elizabeth Garvie', 7.4);

-- Table: surveytakers
	
CREATE TABLE IF NOT EXISTS wk2assignment.surveytakers
(
    id integer NOT NULL,
    name text COLLATE pg_catalog."default",
    CONSTRAINT surveytakers_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS wk2assignment.surveytakers
    OWNER to postgres;

INSERT INTO wk2assignment.surveytakers(
	id, name)
	VALUES (1, 'Dad'),
	(2, 'Mom'),
	(3, 'Sister'),
	(4, 'Husband'),
	(5, 'BFF'),
	(6, 'Cat'),
	(7, 'Coworker'),
	(8, 'Deli Guy'),
	(9, 'Bus Driver')

-- Table: ratings

CREATE TABLE IF NOT EXISTS wk2assignment.ratings
(
    person_id integer NOT NULL,
    movie_id integer NOT NULL,
    rating integer,
    CONSTRAINT ratings_pkey PRIMARY KEY (person_id, movie_id),
    CONSTRAINT movies FOREIGN KEY (movie_id)
        REFERENCES wk2assignment.movies (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT surveytakers FOREIGN KEY (person_id)
        REFERENCES wk2assignment.surveytakers (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS wk2assignment.ratings
    OWNER to postgres;
    
  
COPY ratings (id,
    brideandprejudice,
    bridgetjonesdiary,
    pandp2005,
    pandpzombies,
    pandp1940,
    pandp1980,
FROM '/Downloads/ratings.csv' 
DELIMITER ',';
	
-- Export tables to .csv

COPY movies TO '/Downloads/wk2assignment.movies.csv' DELIMITER ',' CSV HEADER;

COPY surveytakers TO '/Downloads/wk2assignment.surveytakers.csv' DELIMITER ',' CSV HEADER;

COPY ratings TO '/Downloads/wk2assignment.ratings.csv' DELIMITER ',' CSV HEADER;