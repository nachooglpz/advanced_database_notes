# HAVING Clause

## My understanding
This clause, used in conjuction with the `GROUP BY` clause, provides a condition on the summary information regarding the group of tuples associated with each value of the grouping attributes.

Only the groups that satisfy the condition are retrieved in the result of the query.

This can be used as a `WHERE` clause for aggregation operators.

## Why it matters
This allows us to retrieve values only for groups that satisfy certain conditions.

If we used a `WHERE` and then included an aggregate operator, we would get an [`Error 1111`](./ERROR_1111.md)

## Example
```sql
SELECT customer_id, rentals FROM rental HAVING count(*) >= 40;
```

## Resources
- [Elmasri, R. and Navathe, S. (7th Edition) (2016) *Fundamentals of Database Systems.* Pearson.](https://repository.gctu.edu.gh/files/original/40d4b26d17431add03c83ca3a8ea0125.pdf)