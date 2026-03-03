# RANK() Function

## My understanding
The `RANK()` function is used to assign a rank or a position to each row within a result set based on a specified order.

Rows in the same values receive the same rank, and the next rank is skipped for ties.

## Why it matters
This allows to sort rows based on a window function.

## Example
```sql
SELECT
    name,
    department,
    salary,
    RANK() OVER (ORDER BY salary DESC) ASK rank
FROM employees;
```

## Resources
- [RANK() Function in SQL Server](https://www.geeksforgeeks.org/sql/rank-function-in-sql-server/)