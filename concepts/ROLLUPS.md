# Rollups

## My understanding
These allow to generate subtotals and totals for the subsubgroups. It produces a resulting subgroups that incorporates rows at various levels of aggregation.

When grouping by A, B, C, you would be getting the following groupings with rollup:
- (A, B, C)
- (A, B)
- (A)
- ()

And the important thing to note is that the order of elements in the grouping matters, as it can be seen on the previous grouping example.

## Why it matters
They involve higher aggregation levels as they produce more information.

## Example
[This example is taken from Geeks For Geeks, and can be accessed through the "Grouping Data with ROLLUP in SQL" article in the Resources section.](#resources)

Given a table `sales` with the following data:
| region | product   | sales_amount |
|--------|-----------|--------------|   
| East   | Product A | 5000         |
| East   | Product A | 5000         |
| East   | Product B | 7500         |
| East   | Product B | 7500         |
| West   | Product A | 6000         |
| West   | Product A | 6000         |
| West   | Product B | 6500         |
| West   | Product B | 6500         |

The following query:
```sql
SELECT region, product, SUM(sales_amount) AS total_sales
FROM sales
GROUP BY region, product WITH ROLLUP;
```

Will produce the following output:
| region | product   | total_sales |
|--------|-----------|-------------|
| East   | Product A | 10000       |
| East   | Product B | 15000       |
| West   | Product A | 12000       |
| West   | Product B | 13000       |
| East   | NULL      | 25000       |
| West   | NULL      | 25000       |
| NULL   | NULL      | 50000       |

## Resources
- [Understanding ROLLUP in SQL](https://stackoverflow.com/questions/3156424/understanding-rollup-in-sql)
- [Grouping Data with ROLLUP in SQL](https://www.geeksforgeeks.org/sql/grouping-data-with-rollup-in-sql/)