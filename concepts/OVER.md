# OVER () Clause

## My understanding
The `OVER ()` Clause is the function that allows you to establish the window.

You can establish a partition (for the window) by giving the `PARTITION` parameter to the clause.
- If there are no arguments to the `OVER ()` function, the partition is the entire window.

The `ORDER BY` as an argument changes the math from a Static Total to a Cumulative Sum. The windows group one at a time.


## Why it matters
This is the fundamental intialization for implementing a window function.

## Example
```sql
-- The window is the entire dataset
SELECT 
    salesperson_id, 
    order_date, 
    amout, 
    SUM(amount) OVER () AS total_amount 
FROM sales;

-- The calculation resets when the partition key changes
-- We see another column called window_sum with the total per person
-- Allowing us to keep individual dates (by not using a GROUP BY)
SELECT 
    salesperson_id, 
    order_date, amount, 
    SUM(amount) OVER (PARTITION BY salesperson_id) AS window_sum 
FROM sales;
```