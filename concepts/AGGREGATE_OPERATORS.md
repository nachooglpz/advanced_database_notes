# Aggregate Operators

## My understanding
These functions allow to perform operatios over sugroups (or subsubgroups) from a relation.

There are 5 basic aggregate operators:
- `MAX()`: Will return the maximum of a column given the subsubgroup.
- `MIN()`: Wil return the minimum of a colum given the subsubgroup.
- `AVG()`: Will return the average of a column given the subsubgroup.
    - For the calculation, the total number of existing elements is used (`NULL`s are ignored).
    - For example, if there are 5 rows, but one contains a `NULL` value on the column where the attribute is stated to the operator, only 4 rows will be counted on the denominator for the average calculation.
- `SUM()`: Will return the total sum of a colum given the subsubgroup.
    - (Obviously) `NULL`s are ignored on the calculation.
- `COUNT()`: Will return the total elements of a column given the subsubgroup.
    - `COUNT(*)` will count every row.
    - `COUNT(column)` will count values (and ignore `NULL`s).
    - `COUNT(DISTINCT column)` will count unique values from the column only.

## Why it matters
These operators are useful to create summaries about the subgroups (subsubgroups) from a relation.

## Example
```sql
-- MAX() operator
SELECT customer_id, MAX(amount) FROM rental GROUP BY customer_id;

-- MIN() operator
SELECT customer_id, MIN(amount) FROM rental GROUP BY customer_id;

-- AVG() operator
SELECT customer_id, AVG(amount) FROM rental GROUP BY customer_id;

-- SUM() operator
SELECT customer_id, SUM(amount) FROM rental GROUP BY customer_id;

-- COUNT() operator
SELECT customer_id, COUNT(customer_id) FROM rental GROUP BY customer_id;
```