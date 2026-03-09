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