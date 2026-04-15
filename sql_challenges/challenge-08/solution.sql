--  — Indexes: Setup
-- Creates the patient_visits table and populates 100,000 rows
-- Run this once before the other scripts
-- Oracle 23ai / freesql.com
-- ============================================================

-- Drop if exists (safe to re-run)
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE patient_visits';
EXCEPTION
    WHEN OTHERS THEN NULL;
END;
/

-- Create the table
CREATE TABLE patient_visits (
    visit_id     NUMBER         GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    patient_id   NUMBER         NOT NULL,
    site_id      NUMBER         NOT NULL,
    visit_date   DATE           NOT NULL,
    status       VARCHAR2(20)   NOT NULL,   -- 'scheduled', 'completed', 'cancelled'
    diagnosis    VARCHAR2(100),
    amount_usd   NUMBER(10,2)
);

-- Insert 100,000 rows using a single INSERT with CONNECT BY
-- patient_id: 1–10,000 (high cardinality — good for indexing)
-- site_id: 1–5 (low cardinality — bad for indexing)
-- status: 3 values (very low cardinality)
INSERT INTO patient_visits (patient_id, site_id, visit_date, status, diagnosis, amount_usd)
SELECT
    TRUNC(DBMS_RANDOM.VALUE(1, 10001))           AS patient_id,
    TRUNC(DBMS_RANDOM.VALUE(1, 6))               AS site_id,
    SYSDATE - TRUNC(DBMS_RANDOM.VALUE(0, 730))  AS visit_date,
    CASE TRUNC(DBMS_RANDOM.VALUE(1, 4))
        WHEN 1 THEN 'scheduled'
        WHEN 2 THEN 'completed'
        ELSE        'cancelled'
    END                                          AS status,
    CASE TRUNC(DBMS_RANDOM.VALUE(1, 6))
        WHEN 1 THEN 'Hypertension'
        WHEN 2 THEN 'Diabetes'
        WHEN 3 THEN 'Routine checkup'
        WHEN 4 THEN 'Fracture'
        ELSE        'Respiratory infection'
    END                                          AS diagnosis,
    ROUND(DBMS_RANDOM.VALUE(50, 500), 2)         AS amount_usd
FROM dual
CONNECT BY LEVEL <= 50000;

COMMIT;

-- Collect stats so Oracle's optimizer has accurate information
BEGIN
    DBMS_STATS.GATHER_TABLE_STATS(
        ownname => USER,
        tabname => 'PATIENT_VISITS',
        cascade => TRUE
    );
END;
/

-- Verify the data
SELECT COUNT(*) AS total_rows FROM patient_visits;
SELECT status, COUNT(*) AS cnt FROM patient_visits GROUP BY status ORDER BY status;
SELECT MIN(patient_id), MAX(patient_id), COUNT(DISTINCT patient_id) AS unique_patients
FROM patient_visits;

 

 

 

-- ============================================================
-- Lesson 03 — Indexes: Class Exercises
-- Work through these before looking at the hints
-- ============================================================

-- ============================================================
-- Exercise 1 — Find the slow query
--
-- Run this query. Look at the execution plan.
-- Is Oracle using an index? Should it?
    --  I believe that Oracle isn't using an index to run this query.
    --  This is because the equality search is run with the attribute site_id,
    --  and we haven't stated to the database to create an index for this attribute,
    --  so the only index we have (at least for now) is for the primary key
-- ============================================================

SELECT * FROM patient_visits WHERE site_id = 3;

-- Questions:
-- a) What scan type do you see? Why?
    --  It makes a TABLE ACCESS FULL, which I believe that is just a linear search on the whole table.
    --  It does this because we haven't stated an index for it to be able to make any optimization on comparisons.
-- b) site_id has values 1–5. Is this high or low cardinality?
    --  This is low cardinality, as the number of distinct values is only of 5.
-- c) Would adding an index on site_id help? Why or why not?
    --  Probably not, as the number of comparisons wouldn't get much better by using an index.

-- ============================================================
-- Exercise 2 — Create an index and see if it helps
--
-- Create an index on visit_date.
-- Then run the range query below and check the plan.
-- ============================================================

-- Step 1: Create it
-- (write the CREATE INDEX statement here)
CREATE INDEX patient_visits_visit_date_index ON patient_visits (visit_date);


-- Step 2: Gather stats
BEGIN
    DBMS_STATS.GATHER_TABLE_STATS(USER, 'PATIENT_VISITS', cascade => TRUE);
END;
/

-- Step 3: Run the range query and check the plan
SELECT * FROM patient_visits
WHERE visit_date BETWEEN SYSDATE - 30 AND SYSDATE;

-- Questions:
-- a) Does Oracle use the index for this range?
    --  It actually doesn't.
    --  Checking the plan, it makes a TABLE ACCESS FULL, meaning the engine decided to make a linear search.
-- b) Change the range to the last 7 days. Does the plan change?
    --  It appears that the plan didn't change as well.
-- c) Change to the last 700 days. What happens?
    --  The engine still made a TABLE ACCESS FULL.
-- d) Why does the range size affect whether Oracle uses the index?
    --  I believe that it should amount to the engine deciding which type of range will be more prone to make a smaller amount of comparisons in the index tree.
    --  But testing for any range, it still made a TABLE ACCESS FULL, even if the range difference was of 1.
    --  The only way that I could make the engine choose to use the index was to make the range BETWEEN SYSDATE AND SYSDATE,
    --  or just make an equality search WHERE visit_date = SYSDATE;

-- ============================================================
-- Exercise 3 — Composite index
--
-- You often query by both patient_id AND visit_date together:
--   WHERE patient_id = 1234 AND visit_date > SYSDATE - 90
--
-- Two options:
--   Option A: Two separate indexes (one per column)
--   Option B: One composite index (patient_id, visit_date)
--
-- Create the composite index and test the query.
-- ============================================================

CREATE INDEX idx_pv_patient_date ON patient_visits(patient_id, visit_date);

BEGIN
    DBMS_STATS.GATHER_TABLE_STATS(USER, 'PATIENT_VISITS', cascade => TRUE);
END;
/

SELECT * FROM patient_visits
WHERE patient_id = 1234
  AND visit_date > SYSDATE - 90;

-- Questions:
-- a) Does the plan use the composite index?
    --  Yes, the plan shows INDEX RANGE SCAN.
-- b) Now try querying ONLY on visit_date (no patient_id).
--    Does the composite index get used? Why not?
    --  The composite index doesn't get used.
    --  It is not used because the lexicographic order starts with patient_id, but we are just looking by visit_date.
    --  This makes doing a search just on visit_date the same as if we were using the primary key as the index.
    --  And becomes noticeable that it is simpler to compare the rows using linear search.
-- c) What's the rule about column order in composite indexes?
    --  What I said, the lexicographic order states that we will first be indexing by the first attribute stated in the index creation statement.
    --  If we check the following select query where we select by patient_id, it uses the index because it actually is useful in this case,
    --  as we have ordered the tree firstly by patient_id.

SELECT * FROM patient_visits WHERE patient_id = 1234;

-- Trailing column only (index cannot be used from the middle):
SELECT * FROM patient_visits WHERE visit_date > SYSDATE - 90;

-- ============================================================
-- Exercise 4 — Function that breaks an index
--
-- There IS an index on patient_id (from lesson 03).
-- Predict what happens when you wrap the column in a function.
-- ============================================================

-- This query CAN use the index:
SELECT * FROM patient_visits WHERE patient_id = 5432;
-- This one cannot — why?
SELECT * FROM patient_visits WHERE TO_CHAR(patient_id) = '5432';

-- Questions:
-- a) What scan type did the second query use?
    --  It used a TABLE ACCESS FULL scan.
-- b) Why does wrapping a column in a function break index use?
    --  Because we are comparing strings instead of integers (which is the data stored in the index tree).
-- c) How would you rewrite the second query to allow index use?
    --  I would implement it by making comparison a number:
    SELECT * FROM patient_visits WHERE patient_id = TO_NUMBER('5432');

-- ============================================================
-- Exercise 5 — Discussion: real-world scenarios
--
-- For each scenario below, decide:
--   a) Would you add an index?
--   b) On which column(s)?
--   c) Any concerns?
-- ============================================================

-- Scenario A:
-- A reporting table gets loaded once per night (batch ETL).
-- During the day, analysts run SELECT queries by date range.
-- The table has 50 million rows.
-- → Index on date? Yes/No, why?
    -- I would probably choose to use it, because the write-intensive part of the operations (where the tree is modified) happens at night.
    -- And it would make the searching easier by allowing logarithmic search to look for the dates.
    -- The column on which I would be making the index is on the date column.
    -- And the concern that I would probably have is just that the list of references for a node would grow a ton.


-- Scenario B:
-- An OLTP orders table gets 10,000 inserts per minute.
-- Support staff look up orders by customer_id or order_status.
-- order_status has 4 values: pending, processing, shipped, cancelled.
-- → What indexes would you add?
    --  I would probably only use the customer_id index, as order_status has low cardinality and the DBMS would likely make linear search if looking by it.
    --  Probably the only other index that I would set up would be implementing a composite index to have a lexicographic order first by customer_id,
    --  and then by order_status.
    --  But I would only implement that if the team made a lot of reads looking for all orders with a certain order_status by user_id.

-- Scenario C:
-- A patient table has an email column (unique per patient).
-- There are 5 million patients.
-- The app frequently does: WHERE email = 'user@example.com'
-- → What kind of index would be best here?
    --  I would probably implement a partial index on the email column, as it is not stated that the email is something that every patient has.

-- ============================================================
-- Cleanup — remove indexes created in these exercises
-- ============================================================
DROP INDEX idx_pv_patient_date;
-- If you created an index on visit_date in Exercise 2, drop it here:
-- DROP INDEX idx_pv_visit_date;
DROP INDEX patient_visits_visit_date_index;