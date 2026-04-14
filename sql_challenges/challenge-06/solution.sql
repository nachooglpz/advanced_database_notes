-- Create the schema relations
CREATE TABLE product (
    product_id NUMBER PRIMARY KEY,
    product_name VARCHAR2(30),
    package_id NUMBER(10) NULL,
    current_inventory_count NUMBER(5),
    store_cost NUMBER(10, 2),
    sale_price NUMBER(10, 2),
    last_update_date DATE,
    updated_by_user VARCHAR2(30),
    pet_flag VARCHAR2(1),
    CONSTRAINT product_package
        FOREIGN KEY (package_id) REFERENCES product (product_id) ON DELETE SET NULL
);

CREATE TABLE customer (
    cust_id NUMBER PRIMARY KEY,
    firstname VARCHAR2(20),
    lastname VARCHAR2(25),
    address VARCHAR2(32),
    city VARCHAR2(20),
    state VARCHAR2(2),
    zip VARCHAR2(9)
);

CREATE TABLE customer_sale (
    sales_id NUMBER PRIMARY KEY,
    cust_id NUMBER (10),
    total_item_amount NUMBER(10, 2),
    tax_amount NUMBER(10, 2),
    total_sale_amount NUMBER(10,2),
    sales_date DATE,
    shipping_handling_fee NUMBER(5, 2),
    CONSTRAINT cust_id_fk
        FOREIGN KEY (cust_id) REFERENCES customer (cust_id)
);

CREATE TABLE sales_item (
    sales_id NUMBER,
    product_id NUMBER,
    sale_amount NUMBER(10, 2),
    CONSTRAINT sales_item_pk
        PRIMARY KEY (sales_id, product_id),
    CONSTRAINT sales_id_fk
        FOREIGN KEY (sales_id) REFERENCES customer_sale (sales_id),
    CONSTRAINT prod_id_fk
        FOREIGN KEY (product_id) REFERENCES product (product_id)
);

CREATE TABLE pet_care_log (
    product_id NUMBER,
    log_datetime DATE,
    created_by_user VARCHAR2(30),
    log_text VARCHAR2(500),
    last_update_datetime DATE,
    CONSTRAINT pet_care_pk
        PRIMARY KEY (product_id, log_datetime),
    CONSTRAINT prod_id_pcl_fk
        FOREIGN KEY (product_id) REFERENCES product (product_id)
);

-- Trigger that fires before inserting each row in the PET_CARE_LOG table.
-- The trigger will assign the current date and time to the UPDATE_DATE column.
-- It will also assign the current user to the UPDATED_BY_USER column.
-- The trigger will handle all errors in one general exception handler and send an error message using the RAISE_APPLICATION_ERROR procedure.
CREATE TRIGGER insert_pet_care_log
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

-- Trigger that fires before updating each row of the PET_CARE_LOG Table
-- The trigger will look at the current user and compare it with the value in the UPDATED_BY_USER column.
    -- If the 2 are the same, the update proceeds.
    -- If they are different, the update raises an exception and fails.
-- The trigger handles any other database errors the same way it did in the insert trigger.
CREATE TRIGGER update_pet_care_log
BEFORE UPDATE ON pet_care_log
FOR EACH ROW
BEGIN
    IF :OLD.created_by_user = USER
    THEN
        :NEW.last_update_datetime := SYSDATE;
    ELSE
        RAISE_APPLICATION_ERROR(-20002, 'User must match CREATED_BY_USER.');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(
            -20001, 'Error in update_pet_care_log trigger: ' || SQLERRM
        );
END;

-- Trigger that fires before any row is deleted from the PET_CARE_LOG table.
-- The trigger looks at the user who is deleting the row.
    -- If the user is 'JOEMANAGER', the delete continues successfully.
    -- Otherwise, the delete fails and sends an error message.
-- The trigger handles any oter database errors the same way it did in the insert trigger.
CREATE TRIGGER delete_pet_care_log
BEFORE DELETE ON pet_care_log
FOR EACH ROW
BEGIN
    IF USER != 'JOEMANAGER'
    THEN
        RAISE_APPLICATION_ERROR(-20003, 'DELETE User must be JOEMANAGER.');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(
            -20001, 'Error in delete_pet_care_log trigger: ' || SQLERRM
        );
END;