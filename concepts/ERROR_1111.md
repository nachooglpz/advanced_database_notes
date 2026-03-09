# Error 1111

## My understanding
This error occurs when using an aggregate operator after a `WHERE` clause to filter from a tuple or a subsubgroup.

The solution to this is to use the `HAVING` clause.

## Why it matters
It might make sense to one to include a `WHERE` clause followed by an aggregate operator.

## Example
```sql
-- The following would output an Error 1111
SELECT customer_id, rentals FROM rental WHERE count(*) >= 40;

-- The solution to this problem is the following
SELECT customer_id, rentals FROM rental HAVING count(*) >= 40;
```

## Resources
[Error Code 1111. Invalid use of group function](https://stackoverflow.com/questions/22141968/error-code-1111-invalid-use-of-group-function)