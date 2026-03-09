# ERROR 1140

## My understanding
This error happens when trying to generate subsets of a relation without defining the subset attribute(s).

When a `GROUP BY` clause is used in a query, the aggregate operator must be applied separately to each group of tuples as partitioned by the grouping attribute.

The rule is that you cannot mix granular columns with aggregates without a group clause.

## Why it matters
This is common error that might happen when trying to mix GROUP columns (`MIN()`,`MAX()`,`COUNT()`,...) with no GROUP BY clause.

## Example
``` sql
SELECT customer_id, MAX(ammount) FROM payment;
```

## Resources
- [Elmasri, R. and Navathe, S. (7th Edition) (2016) *Fundamentals of Database Systems.* Pearson.](https://repository.gctu.edu.gh/files/original/40d4b26d17431add03c83ca3a8ea0125.pdf)