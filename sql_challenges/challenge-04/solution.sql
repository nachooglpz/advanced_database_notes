-- Analytic Functions: Databases for Developers
SELECT b.*,
       COUNT(*) OVER (
         PARTITION BY shape
       ) AS bricks_per_shape,
       MEDIAN ( weight ) OVER (
         PARTITION BY shape
       ) median_weight_per_shape
FROM bricks b
ORDER BY shape, weight, brick_id;

SELECT b.brick_id, b.weight,
       ROUND ( AVG ( weight ) OVER (
         ORDER BY brick_id
       ), 2 ) running_average_weight
FROM   bricks b
ORDER  BY brick_id;

SELECT b.*,
       MIN ( colour ) OVER (
         ORDER BY brick_id
         ROWS BETWEEN 2 PRECEDING AND 1 PRECEDING
       ) first_colour_two_prev,
       COUNT (*) OVER (
         ORDER BY weight
         RANGE BETWEEN CURRENT ROW AND 1 FOLLOWING
       ) count_values_this_and_next
FROM   bricks b
ORDER  BY weight;


-- Top Three Salaries
WITH ranked_salary AS (
  SELECT
  name,
  salary,
  department_id,
  DENSE_RANK() OVER (PARTITION BY department_id ORDER BY salary DESC) as ranking
  FROM employee
)

SELECT
  department.department_name,
  ranked_salary.name,
  ranked_salary.salary
FROM ranked_salary
JOIN department
ON ranked_salary.department_id = department.department_id
WHERE ranked_salary.ranking <= 3 
ORDER BY department_name, salary DESC, name;