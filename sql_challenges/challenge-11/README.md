### Challenge 11

# SQL Challenge 11

## Problem
Work throught the exercises stated in [sql solutions file](./solution.sql).

---

# Lesson Exercises

---

# Exercise 1 — Model Design (10 min)

## Scenario

Your task system needs a `comments` table.

Each comment belongs to:
- one task
- one user

---

## Task

Create a new Colab cell and write the `Comment` model.

### Required Fields

- `id`
- `task_id`
- `user_id`
- `content`
- `created_at`

---

## Questions

1. What relationships should `Comment` have?
- Comment should have a relationship to Task, and a relationship to User (because every comment belongs to one task, and one author/user).
2. Should `Task` have a `comments` relationship?
- Yes, a task have many comments.
3. What should happen to comments when a task is deleted?
- The comments should be deleted automatically to not leave them orphaned.

---

# Exercise 2 — Migration Creation (10 min)

## Scenario

You added the `Comment` model.

Now generate a migration programmatically.

---

## Task

Run:

```python
command.revision(
    alembic_cfg,
    autogenerate=True,
    message="add comments table"
)
```

---

## Then Inspect the Migration

```python
import glob

migration_files = sorted(
    glob.glob('/content/project/alembic/versions/*.py')
)

for f in migration_files:
    print(f)
```

---

## Open the Generated Migration

```python
latest = migration_files[-1]

with open(latest) as f:
    print(f.read())
```

---

## Questions

1. What does `upgrade()` do?
- It applies the migration changes to the database.
2. What does `downgrade()` do?
- It rolls back/reverses the migration.
3. What happens if you downgrade this migration?
- The comments table will be deleted, along with its relationships.

---

## Bonus

Add a CHECK constraint so `content != ''`

---

# Exercise 3 — CRUD Challenge (10 min)

## Scenario

Write a script that:

1. Creates a team called `"DevOps"`
2. Creates a user `"diana_ops"`
3. Creates 3 tasks with different priorities
4. Prints task count
5. Closes one task
6. Deletes the lowest priority task

---

## Requirements

- Use ORM only
- Use relationships
- Print output clearly

---

# Exercise 4 — Migration Rollback (5 min)

## Scenario

You added a bad column:
`estimated_hours`

The migration has already been applied.

---

## Task

Rollback the migration programmatically.

### Example

```python
command.downgrade(alembic_cfg, "-1")
```

---

## Questions

1. What happens to the column?
- The downgrade would drop the estimated_hours column from the from the table.
2. What happens to the data?
- The data is lost forever.

---

# Exercise 5 — Concept Check (5 min)

Answer briefly:

1. Why use ORM instead of raw SQL?
- ORM lets you work with Python objects instead of writing SQL. It improves readability, reduces boilerplate, and helps prevent SQL injection while keeping code more maintainable.
2. Why use migrations?
- Migrations provide version control for the database schema, allowing to safely track, apply, and share structural changes over time across environments.
3. When would you rollback?
- You rollback when a migration introduces errors, breaks functionality, or has unintended side effects like bad schema changes or data issues.
4. Difference between `add()` and `commit()`?
- add() places an object into the session (staging it), while commit() permanently saves all staged changes to the database.
5. Why are relationships useful?
- Relationships let you navigate linked data naturally without writing manual joins, making queries simpler and more expressive.

---