# Tables as Sets in SQL

## My understanding
SQL treats a table not as a set, but as a multiset, where duplicate tuples can appear more than once.

There are 3 main reasons why SQL does not automatically eliminate duplicate tuples in the results of queries:
- Duplicate elimination is expensive.
    - A way of implement it is to sort the tuples and then eliminate duplicates.
- The user may want to see duplicate tuples in the result of a query.
- When an aggregate function is applied to tuples, we do not wan't to eliminate duplicates (in most cases).

If we *do* want to eliminate duplicate tuples from the result of an SQL query, we use the `DISTINCT` keyword.

Using `SELECT` is completely the same as using `SELECT ALL`.

## Why it matters
It is important to understand how SQL manages set operations.

## Example
```sql
-- Multiset query result
SELECT * FROM salaries;

-- Set query result (eliminating duplicates)
SELECT DISTINCT name FROM person;
```

## References
- [Elmasri, R. and Navathe, S. (7th Edition) (2016) *Fundamentals of Database Systems.* Pearson.](https://repository.gctu.edu.gh/files/original/40d4b26d17431add03c83ca3a8ea0125.pdf)