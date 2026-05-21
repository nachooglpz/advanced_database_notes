-- Lesson 05: Schema Backup & Restore
-- File 08: Class Exercises (self-contained)

-- ============================================
-- EXERCISE 1: Explore your schema
-- ============================================
-- List all the objects in your schema using user_objects
-- Group by object_type and count them
-- Which object types do you have?

-- Sample solution:
SELECT object_type, COUNT(*) AS cnt
FROM user_objects
GROUP BY object_type
ORDER BY object_type;

-- Using the schema for challenge 6
-- [
--   {
--     "object_type": "INDEX",
--     "cnt": 5
--   },
--   {
--     "object_type": "TABLE",
--     "cnt": 5
--   },
--   {
--     "object_type": "TRIGGER",
--     "cnt": 1
--   }
-- ]

-- Also get details:
SELECT object_name, object_type, created, last_ddl_time
FROM user_objects
ORDER BY object_type, object_name;

-- [
--   {
--     "object_name": "PET_CARE_PK",
--     "object_type": "INDEX",
--     "created": "2026-04-28T14:20:35Z",
--     "last_ddl_time": "2026-04-28T14:20:35Z"
--   },
--   {
--     "object_name": "SALES_ITEM_PK",
--     "object_type": "INDEX",
--     "created": "2026-04-28T14:20:35Z",
--     "last_ddl_time": "2026-04-28T14:20:35Z"
--   },
--   {
--     "object_name": "SYS_C003859457",
--     "object_type": "INDEX",
--     "created": "2026-04-28T14:20:35Z",
--     "last_ddl_time": "2026-04-28T14:20:35Z"
--   },
--   {
--     "object_name": "SYS_C003859499",
--     "object_type": "INDEX",
--     "created": "2026-04-28T14:20:35Z",
--     "last_ddl_time": "2026-04-28T14:20:35Z"
--   },
--   {
--     "object_name": "SYS_C003859500",
--     "object_type": "INDEX",
--     "created": "2026-04-28T14:20:35Z",
--     "last_ddl_time": "2026-04-28T14:20:35Z"
--   },
--   {
--     "object_name": "CUSTOMER",
--     "object_type": "TABLE",
--     "created": "2026-04-28T14:20:35Z",
--     "last_ddl_time": "2026-04-28T14:20:35Z"
--   },
--   {
--     "object_name": "CUSTOMER_SALE",
--     "object_type": "TABLE",
--     "created": "2026-04-28T14:20:35Z",
--     "last_ddl_time": "2026-04-28T14:20:35Z"
--   },
--   {
--     "object_name": "PET_CARE_LOG",
--     "object_type": "TABLE",
--     "created": "2026-04-28T14:20:35Z",
--     "last_ddl_time": "2026-04-28T14:20:35Z"
--   },
--   {
--     "object_name": "PRODUCT",
--     "object_type": "TABLE",
--     "created": "2026-04-28T14:20:35Z",
--     "last_ddl_time": "2026-04-28T14:20:35Z"
--   },
--   {
--     "object_name": "SALES_ITEM",
--     "object_type": "TABLE",
--     "created": "2026-04-28T14:20:35Z",
--     "last_ddl_time": "2026-04-28T14:20:35Z"
--   },
--   {
--     "object_name": "INSERT_PET_CARE_LOG",
--     "object_type": "TRIGGER",
--     "created": "2026-04-28T14:20:35Z",
--     "last_ddl_time": "2026-04-28T14:20:35Z"
--   }
-- ]

-- ============================================
-- EXERCISE 2: Basic GET_DDL
-- ============================================
-- First, set transform params for clean output:
BEGIN
  DBMS_METADATA.SET_TRANSFORM_PARAM(DBMS_METADATA.SESSION_TRANSFORM, 'PRETTY', true);
  DBMS_METADATA.SET_TRANSFORM_PARAM(DBMS_METADATA.SESSION_TRANSFORM, 'SQLTERMINATOR', true);
  DBMS_METADATA.SET_TRANSFORM_PARAM(DBMS_METADATA.SESSION_TRANSFORM, 'SEGMENT_ATTRIBUTES', false);
  DBMS_METADATA.SET_TRANSFORM_PARAM(DBMS_METADATA.SESSION_TRANSFORM, 'STORAGE', false);
  DBMS_METADATA.SET_TRANSFORM_PARAM(DBMS_METADATA.SESSION_TRANSFORM, 'TABLESPACE', false);
END;
/

SET LONG 100000
SET PAGESIZE 0

-- Get DDL for one of your tables (replace MY_TABLE with actual name)
SELECT DBMS_METADATA.GET_DDL('TABLE', 'MY_TABLE') FROM DUAL;

  CREATE TABLE ""A01644423_SCHEMA_JW8O8"".""CUSTOMER"" 
   (    ""CUST_ID"" NUMBER, 
        ""FIRSTNAME"" VARCHAR2(20), 
        ""LASTNAME"" VARCHAR2(25), 
        ""ADDRESS"" VARCHAR2(32), 
        ""CITY"" VARCHAR2(20), 
        ""STATE"" VARCHAR2(2), 
        ""ZIP"" VARCHAR2(9), 
         PRIMARY KEY (""CUST_ID"")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 
  TABLESPACE ""USERS""  ENABLE
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE ""USERS"" 

-- Or get all tables at once:
SELECT DBMS_METADATA.GET_DDL('TABLE', table_name)
FROM user_tables
ORDER BY table_name;

CREATE TABLE ""A01644423_SCHEMA_JW8O8"".""CUSTOMER""
   (    ""CUST_ID"" NUMBER,
        ""FIRSTNAME"" VARCHAR2(20),
        ""LASTNAME"" VARCHAR2(25),
        ""ADDRESS"" VARCHAR2(32),
        ""CITY"" VARCHAR2(20),
        ""STATE"" VARCHAR2(2),
        ""ZIP"" VARCHAR2(9),
         PRIMARY KEY (""CUST_ID"")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255
  TABLESPACE ""USERS""  ENABLE
   ) SEGMENT CREATION DEFERRED
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255
 NOCOMPRESS LOGGING
  TABLESPACE ""USERS"" 

   CREATE TABLE ""A01644423_SCHEMA_JW8O8"".""CUSTOMER_SALE""
   (    ""SALES_ID"" NUMBER,
        ""CUST_ID"" NUMBER(10,0),
        ""TOTAL_ITEM_AMOUNT"" NUMBER(10,2),
        ""TAX_AMOUNT"" NUMBER(10,2),
        ""TOTAL_SALE_AMOUNT"" NUMBER(10,2),
        ""SALES_DATE"" DATE,
        ""SHIPPING_HANDLING_FEE"" NUMBER(5,2),
         PRIMARY KEY (""SALES_ID"")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255
  TABLESPACE ""USERS""  ENABLE,
         CONSTRAINT ""CUST_ID_FK"" FOREIGN KEY (""CUST_ID"")
          REFERENCES ""A01644423_SCHEMA_JW8O8"".""CUSTOMER"" (""CUST_ID"") ENABLE
   ) SEGMENT CREATION DEFERRED
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255
 NOCOMPRESS LOGGING
  TABLESPACE ""USERS"" 

  CREATE TABLE ""A01644423_SCHEMA_JW8O8"".""PET_CARE_LOG""
   (    ""PRODUCT_ID"" NUMBER,
        ""LOG_DATETIME"" DATE,
        ""CREATED_BY_USER"" VARCHAR2(30),
        ""LOG_TEXT"" VARCHAR2(500),
        ""LAST_UPDATE_DATETIME"" DATE,
         CONSTRAINT ""PET_CARE_PK"" PRIMARY KEY (""PRODUCT_ID"", ""LOG_DATETIME"")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255
  TABLESPACE ""USERS""  ENABLE,
         CONSTRAINT ""PROD_ID_PCL_FK"" FOREIGN KEY (""PRODUCT_ID"")
          REFERENCES ""A01644423_SCHEMA_JW8O8"".""PRODUCT"" (""PRODUCT_ID"") ENABLE
   ) SEGMENT CREATION DEFERRED
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255
 NOCOMPRESS LOGGING
  TABLESPACE ""USERS"" 

  CREATE TABLE ""A01644423_SCHEMA_JW8O8"".""PRODUCT""
   (    ""PRODUCT_ID"" NUMBER,
        ""PRODUCT_NAME"" VARCHAR2(30),
        ""PACKAGE_ID"" NUMBER(10,0),
        ""CURRENT_INVENTORY_COUNT"" NUMBER(5,0),
        ""STORE_COST"" NUMBER(10,2),
        ""SALE_PRICE"" NUMBER(10,2),
        ""LAST_UPDATE_DATE"" DATE,
        ""UPDATED_BY_USER"" VARCHAR2(30),
        ""PET_FLAG"" VARCHAR2(1),
         PRIMARY KEY (""PRODUCT_ID"")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255
  TABLESPACE ""USERS""  ENABLE,
         CONSTRAINT ""PRODUCT_PACKAGE"" FOREIGN KEY (""PACKAGE_ID"")
          REFERENCES ""A01644423_SCHEMA_JW8O8"".""PRODUCT"" (""PRODUCT_ID"") ON DELETE SET NULL ENABLE
   ) SEGMENT CREATION DEFERRED
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255
 NOCOMPRESS LOGGING
  TABLESPACE ""USERS"" 

  CREATE TABLE ""A01644423_SCHEMA_JW8O8"".""SALES_ITEM""
   (    ""SALES_ID"" NUMBER,
        ""PRODUCT_ID"" NUMBER,
        ""SALE_AMOUNT"" NUMBER(10,2),
         CONSTRAINT ""SALES_ITEM_PK"" PRIMARY KEY (""SALES_ID"", ""PRODUCT_ID"")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255
  TABLESPACE ""USERS""  ENABLE,
         CONSTRAINT ""SALES_ID_FK"" FOREIGN KEY (""SALES_ID"")
          REFERENCES ""A01644423_SCHEMA_JW8O8"".""CUSTOMER_SALE"" (""SALES_ID"") ENABLE,
         CONSTRAINT ""PROD_ID_FK"" FOREIGN KEY (""PRODUCT_ID"")
          REFERENCES ""A01644423_SCHEMA_JW8O8"".""PRODUCT"" (""PRODUCT_ID"") ENABLE
   ) SEGMENT CREATION DEFERRED
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255
 NOCOMPRESS LOGGING
  TABLESPACE ""USERS"" 

-- Since I just have a single table, these two commands were the same.

-- Identify the key parts in the output:
--   - Column definitions (NAME, TYPE, NULL/NOT NULL)
--   - Constraints (PRIMARY KEY, FK, CHECK)
--   - Storage parameters (if included)

-- ============================================
-- EXERCISE 3: Clean DDL for portability
-- ============================================
-- Remove schema names from DDL so it works in any schema

BEGIN
  DBMS_METADATA.SET_TRANSFORM_PARAM(DBMS_METADATA.SESSION_TRANSFORM, 'EMIT_SCHEMA', false);
  DBMS_METADATA.SET_TRANSFORM_PARAM(DBMS_METADATA.SESSION_TRANSFORM, 'PRETTY', true);
  DBMS_METADATA.SET_TRANSFORM_PARAM(DBMS_METADATA.SESSION_TRANSFORM, 'SQLTERMINATOR', true);
  DBMS_METADATA.SET_TRANSFORM_PARAM(DBMS_METADATA.SESSION_TRANSFORM, 'SEGMENT_ATTRIBUTES', false);
  DBMS_METADATA.SET_TRANSFORM_PARAM(DBMS_METADATA.SESSION_TRANSFORM, 'STORAGE', false);
  DBMS_METADATA.SET_TRANSFORM_PARAM(DBMS_METADATA.SESSION_TRANSFORM, 'TABLESPACE', false);
END;
/

-- Compare the output with and without EMIT_SCHEMA:
-- With EMIT_SCHEMA (default):   CREATE TABLE "SALES"."ORDERS" ...
-- Without EMIT_SCHEMA:          CREATE TABLE "ORDERS" ...

-- Try it yourself:
SELECT DBMS_METADATA.GET_DDL('TABLE', table_name)
FROM user_tables
WHERE ROWNUM = 1;

  CREATE TABLE ""A01644423_SCHEMA_JW8O8"".""CUSTOMER"" 
   (    ""CUST_ID"" NUMBER, 
        ""FIRSTNAME"" VARCHAR2(20), 
        ""LASTNAME"" VARCHAR2(25), 
        ""ADDRESS"" VARCHAR2(32), 
        ""CITY"" VARCHAR2(20), 
        ""STATE"" VARCHAR2(2), 
        ""ZIP"" VARCHAR2(9), 
         PRIMARY KEY (""CUST_ID"")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 
  TABLESPACE ""USERS""  ENABLE
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE ""USERS""

-- ============================================
-- EXERCISE 4: Plan a migration
-- ============================================
-- You're moving to a new schema with a different name.
-- What changes would you need to make to your exported DDL?

-- Scenario: Migrating from SCHEMA_OLD to SCHEMA_NEW

-- 1. First, identify schema names embedded in your DDL:
SELECT DBMS_METADATA.GET_DDL('TABLE', table_name)
FROM user_tables
WHERE table_name = 'ANY_TABLE_WITH_FK';

  CREATE TABLE ""A01644423_SCHEMA_JW8O8"".""CUSTOMER_SALE"" 
   (    ""SALES_ID"" NUMBER, 
        ""CUST_ID"" NUMBER(10,0), 
        ""TOTAL_ITEM_AMOUNT"" NUMBER(10,2), 
        ""TAX_AMOUNT"" NUMBER(10,2), 
        ""TOTAL_SALE_AMOUNT"" NUMBER(10,2), 
        ""SALES_DATE"" DATE, 
        ""SHIPPING_HANDLING_FEE"" NUMBER(5,2), 
         PRIMARY KEY (""SALES_ID"")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 
  TABLESPACE ""USERS""  ENABLE, 
         CONSTRAINT ""CUST_ID_FK"" FOREIGN KEY (""CUST_ID"")
          REFERENCES ""A01644423_SCHEMA_JW8O8"".""CUSTOMER"" (""CUST_ID"") ENABLE
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE ""USERS"" 

-- 2. Check for schema-qualified references:
SELECT constraint_name, table_name, r_constraint_name
FROM user_constraints
WHERE constraint_type = 'R';

-- [
--   {
--     "constraint_name": "CUST_ID_FK",
--     "table_name": "CUSTOMER_SALE",
--     "r_constraint_name": "SYS_C003859499"
--   },
--   {
--     "constraint_name": "PRODUCT_PACKAGE",
--     "table_name": "PRODUCT",
--     "r_constraint_name": "SYS_C003859457"
--   },
--   {
--     "constraint_name": "PROD_ID_FK",
--     "table_name": "SALES_ITEM",
--     "r_constraint_name": "SYS_C003859457"
--   },
--   {
--     "constraint_name": "PROD_ID_PCL_FK",
--     "table_name": "PET_CARE_LOG",
--     "r_constraint_name": "SYS_C003859457"
--   },
--   {
--     "constraint_name": "SALES_ID_FK",
--     "table_name": "SALES_ITEM",
--     "r_constraint_name": "SYS_C003859500"
--   }
-- ]

-- 3. If you find FK constraints pointing to other schemas, you need to:
--    - Update the REFERENCES clause to point to new schema name
--    - Or make sure target table exists in same schema



-- 4. Write a migration checklist:
--    □ Export all DDL with EMIT_SCHEMA = false
--    □ Review FK constraints for schema references
--    □ Update constraint references if needed
--    □ Reload in order: tables → constraints → indexes → views → code

-- ============================================
-- EXERCISE 5: Dependency order
-- ============================================
-- Look at user_dependencies to understand object relationships

-- See all dependencies in your schema:
SELECT referenced_name, referencing_name, referencing_type
FROM user_dependencies
ORDER BY referenced_name;

-- [
--   {
--     "referenced_name": "PET_CARE_LOG",
--     "referencing_name": "INSERT_PET_CARE_LOG",
--     "referencing_type": "TRIGGER"
--   }
-- ]

-- Find objects that depend on TABLES (to know what needs tables first):
SELECT referencing_name, referencing_type
FROM user_dependencies
WHERE referenced_name IN (
  SELECT table_name FROM user_tables
)
ORDER BY referencing_type, referencing_name;

-- [
--   {
--     "referencing_name": "INSERT_PET_CARE_LOG",
--     "referencing_type": "TRIGGER"
--   }
-- ]

-- Find direct dependencies for a specific object (replace PROC_NAME):
SELECT referenced_name, referenced_type
FROM user_dependencies
WHERE referencing_name = 'PROC_NAME';
-- The database's output was that there are no items to display.

-- Build a dependency tree for PL/SQL objects:
SELECT referencing_name, referencing_type,
       LISTAGG(referenced_name, ', ') WITHIN GROUP (ORDER BY referenced_name) AS dependencies
FROM user_dependencies
WHERE referencing_type IN ('PACKAGE', 'PROCEDURE', 'FUNCTION')
GROUP BY referencing_name, referencing_type
ORDER BY referencing_type, referencing_name;

-- [
--   {
--     "referencing_name": "INSERT_PET_CARE_LOG",
--     "referencing_type": "TRIGGER",
--     "dependencies": "PET_CARE_LOG"
--   }
-- ]

-- ============================================
-- EXERCISE 6: Design your own backup strategy
-- ============================================
-- Given:
--   - No expdp access (no directory privileges)
--   - Need to move your schema to another database
--   - Only have SQL access
--
-- Design the steps you would take:

-- STEP 1: Document your current schema structure
SELECT object_type, COUNT(*) FROM user_objects GROUP BY object_type;

-- [
--   {
--     "object_type": "TABLE",
--     "count(*)": 5
--   },
--   {
--     "object_type": "TRIGGER",
--     "count(*)": 1
--   },
--   {
--     "object_type": "INDEX",
--     "count(*)": 5
--   }
-- ]

SELECT table_name, num_rows FROM user_tables ORDER BY num_rows DESC;

-- [
--   {
--     "table_name": "CUSTOMER",
--     "num_rows": null
--   },
--   {
--     "table_name": "CUSTOMER_SALE",
--     "num_rows": null
--   },
--   {
--     "table_name": "SALES_ITEM",
--     "num_rows": null
--   },
--   {
--     "table_name": "PRODUCT",
--     "num_rows": null
--   },
--   {
--     "table_name": "PET_CARE_LOG",
--     "num_rows": null
--   }
-- ]

-- STEP 2: Extract all DDL (run all these)
BEGIN
  DBMS_METADATA.SET_TRANSFORM_PARAM(DBMS_METADATA.SESSION_TRANSFORM, 'PRETTY', true);
  DBMS_METADATA.SET_TRANSFORM_PARAM(DBMS_METADATA.SESSION_TRANSFORM, 'SQLTERMINATOR', true);
  DBMS_METADATA.SET_TRANSFORM_PARAM(DBMS_METADATA.SESSION_TRANSFORM, 'SEGMENT_ATTRIBUTES', false);
  DBMS_METADATA.SET_TRANSFORM_PARAM(DBMS_METADATA.SESSION_TRANSFORM, 'STORAGE', false);
  DBMS_METADATA.SET_TRANSFORM_PARAM(DBMS_METADATA.SESSION_TRANSFORM, 'TABLESPACE', false);
END;
/

-- Extract tables (spool to file or copy output):
SELECT DBMS_METADATA.GET_DDL('TABLE', table_name) FROM user_tables;

-- [
--   {
--     "dbms_metadata.get_ddl('table',table_name)": "\n  CREATE TABLE \"A01644423_SCHEMA_JW8O8\".\"CUSTOMER\" \n   (\t\"CUST_ID\" NUMBER, \n\t\"FIRSTNAME\" VARCHAR2(20), \n\t\"LASTNAME\" VARCHAR2(25), \n\t\"ADDRESS\" VARCHAR2(32), \n\t\"CITY\" VARCHAR2(20), \n\t\"STATE\" VARCHAR2(2), \n\t\"ZIP\" VARCHAR2(9), \n\t PRIMARY KEY (\"CUST_ID\")\n  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 \n  TABLESPACE \"USERS\"  ENABLE\n   ) SEGMENT CREATION DEFERRED \n  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 \n NOCOMPRESS LOGGING\n  TABLESPACE \"USERS\" "
--   },
--   {
--     "dbms_metadata.get_ddl('table',table_name)": "\n  CREATE TABLE \"A01644423_SCHEMA_JW8O8\".\"CUSTOMER_SALE\" \n   (\t\"SALES_ID\" NUMBER, \n\t\"CUST_ID\" NUMBER(10,0), \n\t\"TOTAL_ITEM_AMOUNT\" NUMBER(10,2), \n\t\"TAX_AMOUNT\" NUMBER(10,2), \n\t\"TOTAL_SALE_AMOUNT\" NUMBER(10,2), \n\t\"SALES_DATE\" DATE, \n\t\"SHIPPING_HANDLING_FEE\" NUMBER(5,2), \n\t PRIMARY KEY (\"SALES_ID\")\n  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 \n  TABLESPACE \"USERS\"  ENABLE, \n\t CONSTRAINT \"CUST_ID_FK\" FOREIGN KEY (\"CUST_ID\")\n\t  REFERENCES \"A01644423_SCHEMA_JW8O8\".\"CUSTOMER\" (\"CUST_ID\") ENABLE\n   ) SEGMENT CREATION DEFERRED \n  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 \n NOCOMPRESS LOGGING\n  TABLESPACE \"USERS\" "
--   },
--   {
--     "dbms_metadata.get_ddl('table',table_name)": "\n  CREATE TABLE \"A01644423_SCHEMA_JW8O8\".\"PET_CARE_LOG\" \n   (\t\"PRODUCT_ID\" NUMBER, \n\t\"LOG_DATETIME\" DATE, \n\t\"CREATED_BY_USER\" VARCHAR2(30), \n\t\"LOG_TEXT\" VARCHAR2(500), \n\t\"LAST_UPDATE_DATETIME\" DATE, \n\t CONSTRAINT \"PET_CARE_PK\" PRIMARY KEY (\"PRODUCT_ID\", \"LOG_DATETIME\")\n  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 \n  TABLESPACE \"USERS\"  ENABLE, \n\t CONSTRAINT \"PROD_ID_PCL_FK\" FOREIGN KEY (\"PRODUCT_ID\")\n\t  REFERENCES \"A01644423_SCHEMA_JW8O8\".\"PRODUCT\" (\"PRODUCT_ID\") ENABLE\n   ) SEGMENT CREATION DEFERRED \n  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 \n NOCOMPRESS LOGGING\n  TABLESPACE \"USERS\" "
--   },
--   {
--     "dbms_metadata.get_ddl('table',table_name)": "\n  CREATE TABLE \"A01644423_SCHEMA_JW8O8\".\"PRODUCT\" \n   (\t\"PRODUCT_ID\" NUMBER, \n\t\"PRODUCT_NAME\" VARCHAR2(30), \n\t\"PACKAGE_ID\" NUMBER(10,0), \n\t\"CURRENT_INVENTORY_COUNT\" NUMBER(5,0), \n\t\"STORE_COST\" NUMBER(10,2), \n\t\"SALE_PRICE\" NUMBER(10,2), \n\t\"LAST_UPDATE_DATE\" DATE, \n\t\"UPDATED_BY_USER\" VARCHAR2(30), \n\t\"PET_FLAG\" VARCHAR2(1), \n\t PRIMARY KEY (\"PRODUCT_ID\")\n  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 \n  TABLESPACE \"USERS\"  ENABLE, \n\t CONSTRAINT \"PRODUCT_PACKAGE\" FOREIGN KEY (\"PACKAGE_ID\")\n\t  REFERENCES \"A01644423_SCHEMA_JW8O8\".\"PRODUCT\" (\"PRODUCT_ID\") ON DELETE SET NULL ENABLE\n   ) SEGMENT CREATION DEFERRED \n  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 \n NOCOMPRESS LOGGING\n  TABLESPACE \"USERS\" "
--   },
--   {
--     "dbms_metadata.get_ddl('table',table_name)": "\n  CREATE TABLE \"A01644423_SCHEMA_JW8O8\".\"SALES_ITEM\" \n   (\t\"SALES_ID\" NUMBER, \n\t\"PRODUCT_ID\" NUMBER, \n\t\"SALE_AMOUNT\" NUMBER(10,2), \n\t CONSTRAINT \"SALES_ITEM_PK\" PRIMARY KEY (\"SALES_ID\", \"PRODUCT_ID\")\n  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 \n  TABLESPACE \"USERS\"  ENABLE, \n\t CONSTRAINT \"SALES_ID_FK\" FOREIGN KEY (\"SALES_ID\")\n\t  REFERENCES \"A01644423_SCHEMA_JW8O8\".\"CUSTOMER_SALE\" (\"SALES_ID\") ENABLE, \n\t CONSTRAINT \"PROD_ID_FK\" FOREIGN KEY (\"PRODUCT_ID\")\n\t  REFERENCES \"A01644423_SCHEMA_JW8O8\".\"PRODUCT\" (\"PRODUCT_ID\") ENABLE\n   ) SEGMENT CREATION DEFERRED \n  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 \n NOCOMPRESS LOGGING\n  TABLESPACE \"USERS\" "
--   }
-- ]

-- Extract indexes:
SELECT DBMS_METADATA.GET_DDL('INDEX', index_name) FROM user_indexes;

-- [
--   {
--     "dbms_metadata.get_ddl('index',index_name)": "\n  CREATE UNIQUE INDEX \"A01644423_SCHEMA_JW8O8\".\"PET_CARE_PK\" ON \"A01644423_SCHEMA_JW8O8\".\"PET_CARE_LOG\" (\"PRODUCT_ID\", \"LOG_DATETIME\") \n  PCTFREE 10 INITRANS 2 MAXTRANS 255 \n  TABLESPACE \"USERS\" "
--   },
--   {
--     "dbms_metadata.get_ddl('index',index_name)": "\n  CREATE UNIQUE INDEX \"A01644423_SCHEMA_JW8O8\".\"SALES_ITEM_PK\" ON \"A01644423_SCHEMA_JW8O8\".\"SALES_ITEM\" (\"SALES_ID\", \"PRODUCT_ID\") \n  PCTFREE 10 INITRANS 2 MAXTRANS 255 \n  TABLESPACE \"USERS\" "
--   },
--   {
--     "dbms_metadata.get_ddl('index',index_name)": "\n  CREATE UNIQUE INDEX \"A01644423_SCHEMA_JW8O8\".\"SYS_C003859457\" ON \"A01644423_SCHEMA_JW8O8\".\"PRODUCT\" (\"PRODUCT_ID\") \n  PCTFREE 10 INITRANS 2 MAXTRANS 255 \n  TABLESPACE \"USERS\" "
--   },
--   {
--     "dbms_metadata.get_ddl('index',index_name)": "\n  CREATE UNIQUE INDEX \"A01644423_SCHEMA_JW8O8\".\"SYS_C003859499\" ON \"A01644423_SCHEMA_JW8O8\".\"CUSTOMER\" (\"CUST_ID\") \n  PCTFREE 10 INITRANS 2 MAXTRANS 255 \n  TABLESPACE \"USERS\" "
--   },
--   {
--     "dbms_metadata.get_ddl('index',index_name)": "\n  CREATE UNIQUE INDEX \"A01644423_SCHEMA_JW8O8\".\"SYS_C003859500\" ON \"A01644423_SCHEMA_JW8O8\".\"CUSTOMER_SALE\" (\"SALES_ID\") \n  PCTFREE 10 INITRANS 2 MAXTRANS 255 \n  TABLESPACE \"USERS\" "
--   }
-- ]

-- Extract views:
SELECT DBMS_METADATA.GET_DDL('VIEW', view_name) FROM user_views;
-- No items to display.

-- Extract sequences:
SELECT DBMS_METADATA.GET_DDL('SEQUENCE', sequence_name) FROM user_sequences;
-- No items to display

-- Extract constraints:
SELECT DBMS_METADATA.GET_DDL('CONSTRAINT', constraint_name) FROM user_constraints;

-- [
--   {
--     "constraint_ddl": "\n  ALTER TABLE \"A01644423_SCHEMA_JW8O8\".\"PRODUCT\" ADD CONSTRAINT \"PRODUCT_PACKAGE\" FOREIGN KEY (\"PACKAGE_ID\")\n\t  REFERENCES \"A01644423_SCHEMA_JW8O8\".\"PRODUCT\" (\"PRODUCT_ID\") ON DELETE SET NULL ENABLE"
--   },
--   {
--     "constraint_ddl": "\n  ALTER TABLE \"A01644423_SCHEMA_JW8O8\".\"CUSTOMER_SALE\" ADD CONSTRAINT \"CUST_ID_FK\" FOREIGN KEY (\"CUST_ID\")\n\t  REFERENCES \"A01644423_SCHEMA_JW8O8\".\"CUSTOMER\" (\"CUST_ID\") ENABLE"
--   },
--   {
--     "constraint_ddl": "\n  ALTER TABLE \"A01644423_SCHEMA_JW8O8\".\"SALES_ITEM\" ADD CONSTRAINT \"SALES_ITEM_PK\" PRIMARY KEY (\"SALES_ID\", \"PRODUCT_ID\")\n  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 \n  TABLESPACE \"USERS\"  ENABLE"
--   },
--   {
--     "constraint_ddl": "\n  ALTER TABLE \"A01644423_SCHEMA_JW8O8\".\"SALES_ITEM\" ADD CONSTRAINT \"SALES_ID_FK\" FOREIGN KEY (\"SALES_ID\")\n\t  REFERENCES \"A01644423_SCHEMA_JW8O8\".\"CUSTOMER_SALE\" (\"SALES_ID\") ENABLE"
--   },
--   {
--     "constraint_ddl": "\n  ALTER TABLE \"A01644423_SCHEMA_JW8O8\".\"SALES_ITEM\" ADD CONSTRAINT \"PROD_ID_FK\" FOREIGN KEY (\"PRODUCT_ID\")\n\t  REFERENCES \"A01644423_SCHEMA_JW8O8\".\"PRODUCT\" (\"PRODUCT_ID\") ENABLE"
--   },
--   {
--     "constraint_ddl": "\n  ALTER TABLE \"A01644423_SCHEMA_JW8O8\".\"PET_CARE_LOG\" ADD CONSTRAINT \"PET_CARE_PK\" PRIMARY KEY (\"PRODUCT_ID\", \"LOG_DATETIME\")\n  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 \n  TABLESPACE \"USERS\"  ENABLE"
--   },
--   {
--     "constraint_ddl": "\n  ALTER TABLE \"A01644423_SCHEMA_JW8O8\".\"PET_CARE_LOG\" ADD CONSTRAINT \"PROD_ID_PCL_FK\" FOREIGN KEY (\"PRODUCT_ID\")\n\t  REFERENCES \"A01644423_SCHEMA_JW8O8\".\"PRODUCT\" (\"PRODUCT_ID\") ENABLE"
--   }
-- ]

-- Extract code:
SELECT DBMS_METADATA.GET_DDL('PROCEDURE', object_name) FROM user_objects WHERE object_type = 'PROCEDURE';
-- No items to display
SELECT DBMS_METADATA.GET_DDL('FUNCTION', object_name) FROM user_objects WHERE object_type = 'FUNCTION';
-- No items to display
SELECT DBMS_METADATA.GET_DDL('PACKAGE', object_name) FROM user_objects WHERE object_type = 'PACKAGE';
-- No items to display

-- STEP 3: Reload in new schema (use proper order)
-- 1. Create tables (no constraints yet)
CREATE TABLE CUSTOMER (
    CUST_ID NUMBER, 
    FIRSTNAME VARCHAR2(20), 
    LASTNAME VARCHAR2(25), 
    ADDRESS VARCHAR2(32), 
    CITY VARCHAR2(20), 
    STATE VARCHAR2(2), 
    ZIP VARCHAR2(9)
);

CREATE TABLE CUSTOMER_SALE (
    SALES_ID NUMBER, 
    CUST_ID NUMBER(10,0), 
    TOTAL_ITEM_AMOUNT NUMBER(10,2), 
    TAX_AMOUNT NUMBER(10,2), 
    TOTAL_SALE_AMOUNT NUMBER(10,2), 
    SALES_DATE DATE, 
    SHIPPING_HANDLING_FEE NUMBER(5,2)
);

CREATE TABLE PET_CARE_LOG (
    PRODUCT_ID NUMBER, 
    LOG_DATETIME DATE, 
    CREATED_BY_USER VARCHAR2(30), 
    LOG_TEXT VARCHAR2(500), 
    LAST_UPDATE_DATETIME DATE
);

CREATE TABLE PRODUCT (
    PRODUCT_ID NUMBER, 
    PRODUCT_NAME VARCHAR2(30), 
    PACKAGE_ID NUMBER(10,0), 
    CURRENT_INVENTORY_COUNT NUMBER(5,0), 
    STORE_COST NUMBER(10,2), 
    SALE_PRICE NUMBER(10,2), 
    LAST_UPDATE_DATE DATE, 
    UPDATED_BY_USER VARCHAR2(30), 
    PET_FLAG VARCHAR2(1)
);

CREATE TABLE SALES_ITEM (
    SALES_ID NUMBER, 
    PRODUCT_ID NUMBER, 
    SALE_AMOUNT NUMBER(10,2)
);

-- 2. Create sequences
-- (No sequences exist in this schema)

-- 3. Create indexes
-- Creating a Primary Key constraint automatically generates the underlying unique index. We will let Step 4 handle these to prevent duplicates.

-- 4. Add constraints (enable FKs)
ALTER TABLE CUSTOMER ADD PRIMARY KEY (CUST_ID);
ALTER TABLE PRODUCT ADD PRIMARY KEY (PRODUCT_ID);
ALTER TABLE CUSTOMER_SALE ADD PRIMARY KEY (SALES_ID);
ALTER TABLE SALES_ITEM ADD CONSTRAINT SALES_ITEM_PK PRIMARY KEY (SALES_ID, PRODUCT_ID);
ALTER TABLE PET_CARE_LOG ADD CONSTRAINT PET_CARE_PK PRIMARY KEY (PRODUCT_ID, LOG_DATETIME);

-- Add Foreign Keys Second (now that the parent PKs exist)
ALTER TABLE PRODUCT ADD CONSTRAINT PRODUCT_PACKAGE 
    FOREIGN KEY (PACKAGE_ID) REFERENCES PRODUCT (PRODUCT_ID) ON DELETE SET NULL;

ALTER TABLE CUSTOMER_SALE ADD CONSTRAINT CUST_ID_FK 
    FOREIGN KEY (CUST_ID) REFERENCES CUSTOMER (CUST_ID);

ALTER TABLE SALES_ITEM ADD CONSTRAINT SALES_ID_FK 
    FOREIGN KEY (SALES_ID) REFERENCES CUSTOMER_SALE (SALES_ID);

ALTER TABLE SALES_ITEM ADD CONSTRAINT PROD_ID_FK 
    FOREIGN KEY (PRODUCT_ID) REFERENCES PRODUCT (PRODUCT_ID);

ALTER TABLE PET_CARE_LOG ADD CONSTRAINT PROD_ID_PCL_FK 
    FOREIGN KEY (PRODUCT_ID) REFERENCES PRODUCT (PRODUCT_ID);

-- 5. Create views
-- (No views exist in this schema)

-- 6. Create procedures/functions/packages
-- (No PL/SQL packages/procedures exist in this schema)

-- 7. Create triggers
CREATE OR REPLACE TRIGGER insert_pet_care_log
BEFORE INSERT ON pet_care_log
FOR EACH ROW
BEGIN
    :NEW.log_datetime := SYSDATE;
    :NEW.last_update_datetime := SYSDATE;
    :NEW.created_by_user := USER;
EXCEPTION
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20001, 'Error in insert_pet_care_log trigger: ' || SQLERRM);
END;
/

CREATE OR REPLACE TRIGGER update_pet_care_log
BEFORE UPDATE ON pet_care_log
FOR EACH ROW
BEGIN
    IF :OLD.created_by_user = USER THEN
        :NEW.last_update_datetime := SYSDATE;
    ELSE
        RAISE_APPLICATION_ERROR(-20002, 'User must match CREATED_BY_USER.');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20001, 'Error in update_pet_care_log trigger: ' || SQLERRM);
END;
/

CREATE OR REPLACE TRIGGER delete_pet_care_log
BEFORE DELETE ON pet_care_log
FOR EACH ROW
BEGIN
    IF USER != 'JOEMANAGER' THEN
        RAISE_APPLICATION_ERROR(-20003, 'DELETE User must be JOEMANAGER.');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20001, 'Error in delete_pet_care_log trigger: ' || SQLERRM);
END;

-- STEP 4: Verify everything transferred
SELECT object_type, COUNT(*) FROM user_objects GROUP BY object_type;

-- [
--   {
--     "object_type": "TABLE",
--     "count(*)": 5
--   },
--   {
--     "object_type": "TRIGGER",
--     "count(*)": 3
--   },
--   {
--     "object_type": "INDEX",
--     "count(*)": 5
--   }
-- ]

SELECT table_name, num_rows FROM user_tables ORDER BY table_name;

-- [
--   {
--     "table_name": "CUSTOMER",
--     "num_rows": null
--   },
--   {
--     "table_name": "CUSTOMER_SALE",
--     "num_rows": null
--   },
--   {
--     "table_name": "PET_CARE_LOG",
--     "num_rows": null
--   },
--   {
--     "table_name": "PRODUCT",
--     "num_rows": null
--   },
--   {
--     "table_name": "SALES_ITEM",
--     "num_rows": null
--   }
-- ]


SELECT index_name, table_name FROM user_indexes ORDER BY index_name;

-- [
--   {
--     "index_name": "PET_CARE_PK",
--     "table_name": "PET_CARE_LOG"
--   },
--   {
--     "index_name": "SALES_ITEM_PK",
--     "table_name": "SALES_ITEM"
--   },
--   {
--     "index_name": "SYS_C004447290",
--     "table_name": "CUSTOMER"
--   },
--   {
--     "index_name": "SYS_C004447291",
--     "table_name": "PRODUCT"
--   },
--   {
--     "index_name": "SYS_C004447292",
--     "table_name": "CUSTOMER_SALE"
--   }
-- ]



-- ============================================
-- DISCUSSION QUESTIONS
-- ============================================

-- Q1: What are the limitations of DBMS_METADATA vs expdp?
-- A:  DBMS_METADATA only exports DDL (no data), requires manual spool/cursor,
--     and can't handle very large schemas easily.
--     expdp is faster, can export data, handles large schemas, but needs directory access.
--     Choose DBMS_METADATA when you have no DBA access or need educational visibility.
--     Choose expdp when you have proper access and need speed/completeness.

-- Q2: If you have circular dependencies (A depends on B, B depends on A),
--     how would you handle the reload?
-- A:  Oracle handles most circular dependencies automatically if you create
--     objects first and enable constraints later.
--     For PL/SQL circular dependencies, create the package/spec first,
--     then the package/body second.
--     DBMS_METADATA returns objects in a valid order - trust the dependency analysis.

-- Q3: Your company is migrating from one Oracle database to another.
--     They give you read-only access to the old database and want you
--     to recreate the schema on the new database.
--     What's your plan?
-- A:  1. Document source schema structure (user_objects, user_tables, etc.)
--     2. Set EMIT_SCHEMA=false and extract clean DDL
--     3. Check for dependencies and schema-qualified references
--     4. Review and clean up the DDL (remove storage, fix schema names)
--     5. Create new schema user on target
--     6. Run DDL in proper order (tables → constraints → indexes → views → code)
--     7. Verify with object counts and sample queries
--     8. If possible, export sample data via INSERT statements or CSV

-- ============================================
-- FURTHER INVESTIGATION
-- ============================================
-- The techniques in this lesson work on freesql.com with basic SQL access.
-- When you have full Oracle access (DBA, directory privileges, etc.),
-- consider these more advanced approaches:

-- 1. expdp / impdp (Data Pump)
--    The standard Oracle export/import tool.
--    Requires: CREATE ANY DIRECTORY privilege + directory object.
--    Can export schemas, tablespaces, full databases.
--    Handles data + DDL (unlike DBMS_METADATA which is DDL only).
--    Example:
--    expdp system/password@db SCHEMAS=MY_SCHEMA DIRECTORY=MY_DIR DUMPFILE=backup.dmp

-- 2. SQLcl "script" command
--    SQL Developer Command Line can export entire schema to JSON or ZIP.
--    Has a "rollling migration" feature for schema comparisons.

-- 3. Oracle SQL Developer (GUI)
--    Has "Database Export" wizard for schema backup.
--    Point-and-click, no CLI needed.

-- 4. Partitioned tables & transportable tablespaces
--    For very large schemas, Oracle's transportable tablespace
--    feature can move entire tablespaces between databases.

-- 5. Cloud-native tools (if using Oracle Cloud)
--    Oracle Cloud Infrastructure Database Migration service
--    handles full schema migration with automatic conversion.

-- Research these on your own when you have access to a full Oracle environment.
-- The DBMS_METADATA approach you learned here works everywhere — good baseline skill.