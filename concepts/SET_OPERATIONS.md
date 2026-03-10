# Set operations

## My understanding
SQL has incorporated some set operations from mathematical *set theory*.

- Set union `UNION`
- Set difference `EXCEPT`
    - This also exists in Oracle Database as `MINUS`.
    - The difference is that Oracle Database's `MINUS` clause can make `null` comparisons.
- Set intersection `INTERSECT`

The set operations apply only to type-compatible relations.
- We must make sure that the two relations on which we apply the operation have the same attributes.
- And that the attributes appear in the same order in both relations.

## Why it matters
Set operations allow us to make comparisons between queries and even relations (tables).

## Example
```sql
-- Set union
SELECT colour FROM my_brick_collection
UNION
SELECT colour FROM your_brick_collection
ORDER BY colour;

-- Set difference
SELECT colour FROM my_brick_collection
EXCEPT -- using MINUS is valid as well
SELECT colour FROM your_brick_collection
ORDER BY colour;

-- Set intersection
SELECT colour FROM my_brick_collection
INTERSECT
SELECT colour FROM your_brick_collection
ORDER BY colour;
```

## Reference
- [Elmasri, R. and Navathe, S. (7th Edition) (2016) *Fundamentals of Database Systems.* Pearson.](https://repository.gctu.edu.gh/files/original/40d4b26d17431add03c83ca3a8ea0125.pdf)