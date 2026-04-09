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