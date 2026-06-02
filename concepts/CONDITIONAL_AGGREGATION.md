# Conditional Aggregation

## My understanding
- This involves aggregating values from a specific column on certain conditions using [aggregate operators](../concepts/AGGREGATE_OPERATORS.md).

- Conditional aggregation enables the users to calculate the sum of selected values contingent upon the specified conditions.

- We can include multiple WHEN clauses for the different conditions

- The syntax is the following:
```sql
SELECT
    AGGREGATE_FUNCTION(CASE WHEN condition THEN oclumn ELSE 0 END) AS alias
FROM
    table_name
WHERE
    optional_conditions;
```

## Why it matters
- This allows users to perform the targeted aggregations of the data based on specific conditions.

- By applying conditions to the aggregation process, users can tailor their calculations to meet diverse business requirements, by enhancing the relevance and accuracy of the ananlytical outputs.

- In real-time scenarios, summing up all the values in a column may not provide actionable insights.
    - That is where conditional aggregation enables users to isolate and aggregate relevant data points.

## Example
[This example is taken from Geeks For Geeks, and can be accessed through the "Conditional Summation in SQL" article in the Resources section.](#resources)

Let us consider the orders table which consists of order_id, product_id, quantity, unit_price columns in it:

| order_id | product_id | quantity | unit_price |
|----------|------------|----------|------------|
| 1        | 101        | 3        | 10.00      |
| 2        | 102        | 7        | 15.00      |
| 3        | 101        | 6        | 10.00      |
| 4        | 103        | 4        | 20.00      |
| 5        | 102        | 8        | 15.00      |

We can write the below code to calculate the total sales amount for each product which is orders with a quantity greater than 5.

```sql
SELECT 
    product_id,
    SUM(CASE WHEN quantity > 5 THEN quantity * unit_price ELSE 0 END) AS total_sales
FROM 
    orders
GROUP BY 
    product_id;
```

## Resources
- [Conditional Summation in SQL](https://www.geeksforgeeks.org/sql/conditional-summation-in-sql/)
