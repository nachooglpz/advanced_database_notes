-- LESSON 6
SELECT movies.title, boxoffice.domestic_sales, boxoffice.international_sales FROM movies JOIN boxoffice ON movies.id = boxoffice.movie_id;
SELECT movies.title, boxoffice.domestic_sales, boxoffice.international_sales FROM movies JOIN boxoffice ON movies.id = boxoffice.movie_id WHERE boxoffice.international_sales > boxoffice.domestic_sales;
SELECT movies.title, boxoffice.rating FROM movies JOIN boxoffice ON movies.id = boxoffice.movie_id ORDER BY rating DESC;

-- LESSON 7
SELECT DISTINCT buildings.building_name FROM employees LEFT JOIN buildings ON employees.building = buildings.building_name;
SELECT * FROM buildings;
SELECT DISTINCT buildings.building_name, employees.role FROM buildings LEFT JOIN employees ON buildings.building_name = employees.building;

-- DATALEMUR CHALLENGE
SELECT pages.page_id FROM pages LEFT JOIN page_likes ON pages.page_id = page_likes.page_id WHERE page_likes.page_id IS NULL ORDER BY pages.page_id ASC;

-- ALTERNATIVE SOLUTION TO DATALEMUR CHALLENGE
SELECT page_id FROM pages EXCEPT SELECT page_id FROM page_likes ORDER BY page_id ASC;