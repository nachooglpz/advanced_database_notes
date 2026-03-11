-- Union, Minus, and Intersect: Databases for Developers
SELECT colour FROM my_brick_collection
UNION
SELECT colour FROM your_brick_collection
ORDER BY colour;

SELECT shape FROM my_brick_collection
UNION ALL
SELECT shape FROM your_brick_collection
ORDER BY shape;

SELECT shape FROM my_brick_collection
MINUS
SELECT shape FROM your_brick_collection
ORDER BY shape;

SELECT colour FROM my_brick_collection
INTERSECT
SELECT colour FROM your_brick_collection
ORDER BY colour;