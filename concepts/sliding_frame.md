# Sliding frame

## My understanding
This allows to move beyond logical partitions to physical row counts.

It can be used as an argument to the [`OVER () Clause`](./OVER.md).

- It can be resource-intensive on large data.

## Why it matters
This allows to implement a flexible (or dynamic) framing without having to group by.

## Example
Basic configurations:
```sql
-- Trailing 3-day (smooth recent trends)
2 PRECEDING AND CURRENT ROW

-- Centered average (looking behind and ahead)
1 PRECEDING AND 1 FOLLOWING

-- Historical accumulation (running total)
UNBOUND PRECEDING AND CURRENT ROW

-- Not counting the current row
BETWEEN 2 PRECEDING AND 1 PRECEDING

-- Ranges
RANGE BETWEEN CURRENT ROW AND ONE FOLLOWING
```

**Real world application:** The Twitter Rolling Average

**Problem:** Calculate the 3-day rolling average of tweets per user.
```sql
SELECT
    user_id,
    tweet_date,
    AVG(tweet_count) OVER (
        PARTITION BY user_id
        ORDER BY tweet_date
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS rolling_avg
FROM tweets;
```