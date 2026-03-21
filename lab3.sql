-- 1. Xóa và tạo database
DROP DATABASE IF EXISTS lab3;
CREATE DATABASE lab3;

-- Kết nối database (PostgreSQL)
--\c lab3;

-- 2. Xóa bảng (đúng thứ tự)
DROP TABLE IF EXISTS order_details;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS customers;

-- 3. Bảng customers
CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    phone VARCHAR(20),
    address VARCHAR(200)
);

-- 4. Bảng products
CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    price DECIMAL(15,2)
);

-- 5. Bảng orders
CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers(customer_id) ON DELETE CASCADE,
    order_date TIMESTAMP DEFAULT NOW(),
    total_amount DECIMAL(15,2) DEFAULT 0
);

-- 6. Bảng order_details
CREATE TABLE order_details (
    order_id INT REFERENCES orders(order_id) ON DELETE CASCADE,
    product_id INT REFERENCES products(product_id),
    quantity INT CHECK (quantity > 0),
    unit_price DECIMAL(15,2),
    PRIMARY KEY (order_id, product_id)
);

-- =========================
-- LAB 3
-- =========================

-- Bài 1: Lấy tên và giá sản phẩm
SELECT 
    product_name AS TenSanPham,
    price AS DonGia
FROM products;

-- Bài 2: Tìm khách hàng có "Văn"
SELECT 
    full_name,
    phone
FROM customers
WHERE full_name LIKE '%Văn%';

-- Bài 3: Sắp xếp giá giảm dần
SELECT 
    product_name,
    price
FROM products
ORDER BY price DESC;

-- Bài 4: 3 sản phẩm rẻ nhất
SELECT 
    product_name,
    price
FROM products
ORDER BY price ASC
LIMIT 3;

--pg_dump -U postgres -d lab3 -f lab3.sql