# EXCEPT Operation

## My understanding
The `EXCEPT` operation in SQL allows you to filter out all the results from another query.

## Why it matters
This allows to simplify queries.

## Example
In the DataLemur [Page With No Likes](https://datalemur.com/questions/sql-page-with-no-likes) exercise, the solution can use a `LEFT JOIN` as the following:

```sql
SELECT pages.page_id FROM pages LEFT JOIN page_likes ON pages.page_id = page_likes.page_id WHERE page_likes.page_id IS NULL ORDER BY pages.page_id ASC;
```

But this query can be simplified by selecting all pages and filtering out the pages with likes as the following:

```sql
SELECT page_id FROM pages EXCEPT SELECT page_id FROM page_likes ORDER BY page_id ASC;
```