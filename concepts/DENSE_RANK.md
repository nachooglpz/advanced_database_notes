# DENSE_RANK() Function

## My understanding
This is literally the [`Rank() Function`](./RANK.md) but this does not skip ranks when there is a tie.

## Why it matters
This function allows to maintain a ranking order without skipping places.

## Example
```sql
SELECT
    name,
    score,
    DENSE_RANK OVER (ORDER BY score DESC) AS dense_rank
FROM students;
```

## Resources
- [Rank and Dense Rank in SQL Server](https://www.geeksforgeeks.org/sql-server/rank-and-dense-rank-in-sql-server/)