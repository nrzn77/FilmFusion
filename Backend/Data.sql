-- Create the database (optional, if not already created)
CREATE DATABASE movie_db;
USE movie_db;

-- Table: Country
CREATE TABLE country (
    country_id INT PRIMARY KEY AUTO_INCREMENT,
    country_iso_code VARCHAR(10) NOT NULL,
    country_name VARCHAR(100) NOT NULL
);

-- Table: Language
CREATE TABLE language (
    language_id INT PRIMARY KEY AUTO_INCREMENT,
    language_code VARCHAR(10) NOT NULL,
    language_name VARCHAR(100) NOT NULL
);

-- Table: Genre
CREATE TABLE genre (
    genre_id INT PRIMARY KEY AUTO_INCREMENT,
    genre_name VARCHAR(100) NOT NULL
);

-- Table: Keyword
CREATE TABLE keyword (
    keyword_id INT PRIMARY KEY AUTO_INCREMENT,
    keyword_name VARCHAR(100) NOT NULL
);

-- Table: Production Company
CREATE TABLE production_company (
    company_id INT PRIMARY KEY AUTO_INCREMENT,
    company_name VARCHAR(100) NOT NULL
);

-- Table: Person
CREATE TABLE person (
    person_id INT PRIMARY KEY AUTO_INCREMENT,
    person_name VARCHAR(100) NOT NULL
);

-- Table: Department
CREATE TABLE department (
    department_id INT PRIMARY KEY AUTO_INCREMENT,
    department_name VARCHAR(100) NOT NULL
);

-- Table: Movie
CREATE TABLE movie (
    movie_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    budget DECIMAL(15,2),
    overview TEXT,
    release_date DATE,
    revenue DECIMAL(15,2),
    runtime INT,
    votes_avg DECIMAL(3,2),
    votes_count INT
);

-- Table: Production Country (Associates Movies with Countries)
CREATE TABLE production_country (
    movie_id INT,
    country_id INT,
    PRIMARY KEY (movie_id, country_id),
    FOREIGN KEY (movie_id) REFERENCES movie(movie_id) ON DELETE CASCADE,
    FOREIGN KEY (country_id) REFERENCES country(country_id) ON DELETE CASCADE
);

-- Table: Movie Languages (Associates Movies with Languages)
CREATE TABLE movie_languages (
    movie_id INT,
    language_id INT,
    PRIMARY KEY (movie_id, language_id),
    FOREIGN KEY (movie_id) REFERENCES movie(movie_id) ON DELETE CASCADE,
    FOREIGN KEY (language_id) REFERENCES language(language_id) ON DELETE CASCADE
);

-- Table: Movie Genre (Associates Movies with Genres)
CREATE TABLE movie_genre (
    movie_id INT,
    genre_id INT,
    PRIMARY KEY (movie_id, genre_id),
    FOREIGN KEY (movie_id) REFERENCES movie(movie_id) ON DELETE CASCADE,
    FOREIGN KEY (genre_id) REFERENCES genre(genre_id) ON DELETE CASCADE
);

-- Table: Movie Keywords (Associates Movies with Keywords)
CREATE TABLE movie_keywords (
    movie_id INT,
    keyword_id INT,
    PRIMARY KEY (movie_id, keyword_id),
    FOREIGN KEY (movie_id) REFERENCES movie(movie_id) ON DELETE CASCADE,
    FOREIGN KEY (keyword_id) REFERENCES keyword(keyword_id) ON DELETE CASCADE
);


-- Table: Movie Company (Associates Movies with Production Companies)
CREATE TABLE movie_company (
    movie_id INT,
    company_id INT,
    PRIMARY KEY (movie_id, company_id),
    FOREIGN KEY (movie_id) REFERENCES movie(movie_id) ON DELETE CASCADE,
    FOREIGN KEY (company_id) REFERENCES production_company(company_id) ON DELETE CASCADE
);

-- Table: Movie Cast (Associates Movies with Cast Members)
CREATE TABLE movie_cast (
    movie_id INT,
    person_id INT,
    character_name VARCHAR(255),
    cast_order INT,
    PRIMARY KEY (movie_id, person_id),
    FOREIGN KEY (movie_id) REFERENCES movie(movie_id) ON DELETE CASCADE,
    FOREIGN KEY (person_id) REFERENCES person(person_id) ON DELETE CASCADE
);

-- Table: Movie Crew (Associates Movies with Crew Members and Departments)
CREATE TABLE movie_crew (
    movie_id INT,
    person_id INT,
    department_id INT,
    job VARCHAR(255),
    PRIMARY KEY (movie_id, person_id, department_id),
    FOREIGN KEY (movie_id) REFERENCES movie(movie_id) ON DELETE CASCADE,
    FOREIGN KEY (person_id) REFERENCES person(person_id) ON DELETE CASCADE,
    FOREIGN KEY (department_id) REFERENCES department(department_id) ON DELETE CASCADE
);

-- Table: country
INSERT INTO country (country_iso_code, country_name) VALUES
('US', 'United States'),
('FR', 'France'),
('JP', 'Japan'),
('IN', 'India'),
('GB', 'United Kingdom'),
('DE', 'Germany'),
('IT', 'Italy'),
('CA', 'Canada');

-- Table: language
INSERT INTO language (language_code, language_name) VALUES
('EN', 'English'),
('FR', 'French'),
('JP', 'Japanese'),
('HI', 'Hindi'),
('ES', 'Spanish'),
('DE', 'German'),
('IT', 'Italian'),
('ZH', 'Chinese');

-- Table: genre
INSERT INTO genre (genre_name) VALUES
('Action'),
('Comedy'),
('Drama'),
('Horror'),
('Romance'),
('Thriller'),
('Sci-Fi'),
('Fantasy');

-- Table: keyword
INSERT INTO keyword (keyword_name) VALUES
('Adventure'),
('Hero'),
('Space'),
('Future'),
('Friendship'),
('Family'),
('Mystery'),
('Love');

-- Table: production_company
INSERT INTO production_company (company_name) VALUES
('Warner Bros.'),
('Universal Pictures'),
('Paramount Pictures'),
('Walt Disney Studios'),
('Sony Pictures'),
('20th Century Fox'),
('Lionsgate'),
('MGM');

-- Table: person
INSERT INTO person (person_name) VALUES
('Robert Downey Jr.'),
('Scarlett Johansson'),
('Chris Hemsworth'),
('Emma Watson'),
('Leonardo DiCaprio'),
('Angelina Jolie'),
('Tom Hanks'),
('Natalie Portman');

-- Table: department
INSERT INTO department (department_name) VALUES
('Directing'),
('Writing'),
('Editing'),
('Production'),
('Sound'),
('Camera'),
('Art'),
('Visual Effects');

-- Table: movie
INSERT INTO movie (title, budget, overview, release_date, revenue, runtime, votes_avg, votes_count) VALUES
('Inception', 160000000, 'A thief who steals corporate secrets...', '2010-07-16', 825532764, 148, 8.8, 2000000),
('Titanic', 200000000, 'A young aristocrat falls in love...', '1997-12-19', 2187463944, 195, 7.8, 3000000),
('Avatar', 237000000, 'A paraplegic Marine dispatched to...', '2009-12-18', 2847246203, 162, 7.9, 2500000),
('The Avengers', 220000000, 'Earth’s mightiest heroes...', '2012-05-04', 1518812988, 143, 8.1, 2100000),
('The Godfather', 6000000, 'The aging patriarch of an organized...', '1972-03-24', 134966411, 175, 9.2, 1600000),
('Jurassic Park', 63000000, 'During a preview tour, a theme park...', '1993-06-11', 1045596524, 127, 8.1, 900000),
('Pulp Fiction', 8000000, 'The lives of two mob hitmen, a boxer...', '1994-10-14', 213928762, 154, 8.9, 1700000),
('Forrest Gump', 55000000, 'The presidencies of Kennedy...', '1994-07-06', 678222284, 142, 8.8, 1500000);

-- Table: production_country
INSERT INTO production_country (movie_id, country_id) VALUES
(1, 1), (2, 1), (3, 1), (4, 1),
(5, 1), (6, 1), (7, 1), (8, 1);

-- Table: movie_languages
INSERT INTO movie_languages (movie_id, language_id) VALUES
(1, 1), (2, 1), (3, 1), (4, 1),
(5, 1), (6, 1), (7, 1), (8, 1);

-- Table: movie_genre
INSERT INTO movie_genre (movie_id, genre_id) VALUES
(1, 7), (2, 5), (3, 8), (4, 1),
(5, 3), (6, 4), (7, 2), (8, 3);

-- Table: movie_keywords
INSERT INTO movie_keywords (movie_id, keyword_id) VALUES
(1, 1), (2, 7), (3, 3), (4, 2),
(5, 6), (6, 1), (7, 4), (8, 5);

-- Table: movie_company
INSERT INTO movie_company (movie_id, company_id) VALUES
(1, 1), (2, 2), (3, 3), (4, 4),
(5, 5), (6, 6), (7, 7), (8, 8);

-- Table: movie_cast
INSERT INTO movie_cast (movie_id, person_id, character_name, cast_order) VALUES
(1, 1, 'Dom Cobb', 1), (2, 2, 'Rose DeWitt Bukater', 1),
(3, 3, 'Jake Sully', 1), (4, 4, 'Hermione Granger', 1),
(5, 5, 'Jack Dawson', 1), (6, 6, 'Jane Smith', 1),
(7, 7, 'Forrest Gump', 1), (8, 8, 'Evey Hammond', 1);

-- Table: movie_crew
INSERT INTO movie_crew (movie_id, person_id, department_id, job) VALUES
(1, 1, 1, 'Director'), (2, 2, 2, 'Screenwriter'),
(3, 3, 1, 'Director'), (4, 4, 1, 'Director'),
(5, 5, 4, 'Producer'), (6, 6, 4, 'Producer'),
(7, 7, 1, 'Director'), (8, 8, 1, 'Director');


--adding another column for movie posters
ALTER TABLE movie
ADD COLUMN poster_url VARCHAR(255);

UPDATE movie SET poster_url = 'https://image.tmdb.org/t/p/original/As0zX43h3w6kD2NS4uVHu9HKdEh.jpg' WHERE movie_id = 2
UPDATE movie SET poster_url = 'https://image.tmdb.org/t/p/original/6EiRUJpuoeQPghrs3YNktfnqOVh.jpg' WHERE movie_id = 3
UPDATE movie SET poster_url = 'https://image.tmdb.org/t/p/original/d6LbJZO8ruvXgOjjGRgjtdYpJS4.jpg' WHERE movie_id = 5
UPDATE movie SET poster_url = 'https://image.tmdb.org/t/p/original/oU7Oq2kFAAlGqbU4VoAE36g4hoI.jpg' WHERE movie_id = 6

UPDATE movie 
SET poster_url = 'https://miro.medium.com/v2/format:webp/0*ZjYSm_q36J4KChdn' 
WHERE movie_id IN (1, 4, 7, 8);