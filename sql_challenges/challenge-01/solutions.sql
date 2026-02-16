-- LESSON 1
SELECT title FROM movies;
SELECT director FROM movies;
SELECT title, director FROM movies;
SELECT title, year FROM movies;
SELECT * FROM movies;

-- LESSON 2
SELECT * FROM movies WHERE id = 6;
SELECT * FROM movies WHERE year BETWEEN 2000 AND 2010;
SELECT * FROM movies WHERE year NOT BETWEEN 2000 AND 2010;
SELECT title, year FROM movies LIMIT 5;

-- LESSON 3
SELECT * FROM movies WHERE title LIKE "toy story%";
SELECT title FROM movies WHERE director LIKE "john lasseter";
SELECT title FROM movies WHERE director NOT LIKE "john lasseter";
SELECT title FROM movies WHERE title LIKE "wall-%";

-- LESSON 4
SELECT DISTINCT director FROM movies ORDER BY director ASC;
SELECT * FROM movies ORDER BY year DESC LIMIT 4;
SELECT * FROM movies ORDER BY title ASC LIMIT 5;
SELECT * FROM movies ORDER BY title ASC LIMIT 5 OFFSET 5;

-- LESSON 5
SELECT * FROM north_american_cities WHERE country LIKE "canada";
SELECT * FROM north_american_cities WHERE country LIKE "united states" ORDER BY latitude DESC;
SELECT * FROM north_american_cities WHERE longitude < -87.629798 ORDER BY longitude ASC;
SELECT * FROM north_american_cities WHERE country LIKE "mexico" ORDER BY population DESC LIMIT 2;
SELECT * FROM north_american_cities WHERE country LIKE "united states" ORDER BY population DESC LIMIT 2 OFFSET 2;