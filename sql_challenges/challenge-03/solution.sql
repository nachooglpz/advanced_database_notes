-- LESSON 10
SELECT MAX(years_employed) FROM employees;
SELECT role, AVG(years_employed) FROM employees GROUP BY role;
SELECT building, SUM(years_employed) FROM employees GROUP BY building;

-- LESSON 11
SELECT COUNT(name) FROM employees WHERE role = "Artist";
SELECT role, COUNT(*) FROM employees GROUP BY role;
SELECT role, SUM(years_employed) FROM employees WHERE role = "Engineer";

-- Aggregating Rows: Databases for Developers
SELECT COUNT(DISTINCT shape) AS NUMBER_OF_SHAPES, STDDEV(DISTINCT weight) AS DISTINCT_WEIGHT_STDDEV FROM bricks;
SELECT shape AS SHAPE, SUM(weight) AS SHAPE_WEIGHT FROM bricks GROUP BY shape;
SELECT shape AS SHAPE, SUM(weight) AS "SUM(WEIGHT)" FROM bricks GROUP BY shape HAVING SUM(weight) < 4;

