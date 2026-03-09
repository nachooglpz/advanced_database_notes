# GROUP BY Statement

## My understanding
The `GROUP BY` statement allows to create subsubgroups of a relation.

Each group (partition) will consist of the tuples that have the same value of some attributes (grouping attributes).

The statement also allows to partition by using multidimensional aggregation. When grouping by multiple columns, the subsubgroups generated are based on every possible combination of the attributes stated.


## Why it matters
This allows to create summary information about each group.

## Example
```sql
-- GROUP BY clause specifies the grouping attributes
SELECT customer_id FROM rental GROUP BY customer_id;

-- Multidimensional aggregation by multi-column grouping
SELECT customer_id FROM rental GROUP BY customer_id, region;
```

## Resources
- [Elmasri, R. and Navathe, S. (7th Edition) (2016) *Fundamentals of Database Systems.* Pearson.](https://repository.gctu.edu.gh/files/original/40d4b26d17431add03c83ca3a8ea0125.pdf)
- [SQL GROUP BY Multiple Column: Tips and Best Practices](https://www.datacamp.com/tutorial/sql-group-by-multiple-columns)