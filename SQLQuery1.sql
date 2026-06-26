CREATE DATABASE BikeStores_DB;
GO

USE BikeStores_DB;
GO

CREATE SCHEMA sales;
GO

CREATE SCHEMA production;
GO

-- ======================
-- Production Schema
-- ======================

CREATE TABLE production.categories (
    category_id INT IDENTITY(1,1) PRIMARY KEY,
    category_name NVARCHAR(100)
);

CREATE TABLE production.brands (
    brand_id INT IDENTITY(1,1) PRIMARY KEY,
    brand_name NVARCHAR(100)
);

CREATE TABLE production.products (
    product_id INT IDENTITY(1,1) PRIMARY KEY,
    product_name NVARCHAR(100),
    brand_id INT,
    category_id INT,
    model_year INT,
    list_price DECIMAL(10,2),
    FOREIGN KEY (brand_id) REFERENCES production.brands(brand_id),
    FOREIGN KEY (category_id) REFERENCES production.categories(category_id)
);

-- ======================
-- Sales Schema
-- ======================

CREATE TABLE sales.stores (
    store_id INT IDENTITY(1,1) PRIMARY KEY,
    store_name NVARCHAR(100),
    phone NVARCHAR(20),
    email NVARCHAR(100),
    street NVARCHAR(100),
    city NVARCHAR(50),
    state NVARCHAR(50),
    zip_code NVARCHAR(10)
);

CREATE TABLE sales.customers (
    customer_id INT IDENTITY(1,1) PRIMARY KEY,
    first_name NVARCHAR(50),
    last_name NVARCHAR(50),
    phone NVARCHAR(20),
    email NVARCHAR(100),
    street NVARCHAR(100),
    city NVARCHAR(50),
    state NVARCHAR(50),
    zip_code NVARCHAR(10)
);

CREATE TABLE sales.staffs (
    staff_id INT IDENTITY(1,1) PRIMARY KEY,
    first_name NVARCHAR(50),
    last_name NVARCHAR(50),
    email NVARCHAR(100),
    phone NVARCHAR(20),
    active BIT,
    store_id INT,
    manager_id INT NULL,
    FOREIGN KEY (store_id) REFERENCES sales.stores(store_id),
    FOREIGN KEY (manager_id) REFERENCES sales.staffs(staff_id)
);

CREATE TABLE sales.orders (
    order_id INT IDENTITY(1,1) PRIMARY KEY,
    customer_id INT,
    order_status NVARCHAR(20),
    order_date DATE,
    required_date DATE,
    shipped_date DATE,
    store_id INT,
    staff_id INT,
    FOREIGN KEY (customer_id) REFERENCES sales.customers(customer_id),
    FOREIGN KEY (store_id) REFERENCES sales.stores(store_id),
    FOREIGN KEY (staff_id) REFERENCES sales.staffs(staff_id)
);

CREATE TABLE sales.order_items (
    order_id INT,
    item_id INT IDENTITY(1,1),
    product_id INT,
    quantity INT,
    list_price DECIMAL(10,2),
    discount DECIMAL(5,2),
    PRIMARY KEY (order_id, item_id),
    FOREIGN KEY (order_id) REFERENCES sales.orders(order_id),
    FOREIGN KEY (product_id) REFERENCES production.products(product_id)
);

CREATE TABLE production.stocks (
    store_id INT,
    product_id INT,
    quantity INT,
    PRIMARY KEY (store_id, product_id),
    FOREIGN KEY (store_id) REFERENCES sales.stores(store_id),
    FOREIGN KEY (product_id) REFERENCES production.products(product_id)
);
