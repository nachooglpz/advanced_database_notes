# FOR EACH ROW Clause

## My understanding
This clause makes that the rule set in a [Trigger](../sessions/session-2026-03-24.md) is triggered separately *for each tuple*, which is known as **row-level trigger**.
- So, if a query affects 10 tuples, the trigger runs 10 times.

If this clause was left out, the trigger would be triggered once for each triggering statement, and would be known as **statement-level trigger**.
- So, if a query affects 10 tuples, the trigger runs 1 time.

Row-level triggers can access `NEW` and `OLD` values, while statement-level triggers cannot (because they cannot see individual tuples).

## Why it matters
Implementing a row or statement-level trigger impacts performance, as statement-level triggers are much more efficient for bulk operations.

But sometimes you need per-tuple accuracy (like for modifying individual tuples' attributes).

## Example
```sql
-- Row-level trigger
-- We have a relation employees and want to log every salary change
CREATE TRIGGER log_salary_change
AFTER UPDATE ON employees
FOR EACH ROW
BEGIN
  INSERT INTO salary_log(emp_id, old_salary, new_salary)
  VALUES (OLD.id, OLD.salary, NEW.salary);
END;

-- Statement-level trigger
-- Log that an update happened (not per tuple, just once)
CREATE TRIGGER log_update_event
AFTER UPDATE ON employees
BEGIN
  INSERT INTO audit_log(action, action_time)
  VALUES ('Employees updated', CURRENT_TIMESTAMP);
END;
```

## Resources
- [Elmasri, R. and Navathe, S. (7th Edition) (2016) *Fundamentals of Database Systems.* Pearson.](https://repository.gctu.edu.gh/files/original/40d4b26d17431add03c83ca3a8ea0125.pdf)