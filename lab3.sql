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

INSERT INTO customers (full_name, phone, address) VALUES
('Nguyễn Văn An', '0901234567', '123 Lê Lợi, TP.HCM'),
('Trần Thị Bình', '0912345678', '456 Nguyễn Huệ, Hà Nội'),
('Lê Văn Cường', '0987654321', '789 Trần Hưng Đạo, Đà Nẵng'),
('Phạm Minh Đức', '0933445566', '101 Hai Bà Trưng, Cần Thơ'),
('Nguyễn Văn Em', '0944556677', '202 Lý Tự Trọng, Hải Phòng');

INSERT INTO products (product_name, price) VALUES
('Laptop Dell XPS', 25000000),
('iPhone 15 Pro', 28000000),
('Chuột Logitech G502', 1200000),
('Bàn phím cơ Akko', 1500000),
('Màn hình LG 27 inch', 5500000);

INSERT INTO orders (customer_id, order_date, total_amount) VALUES
(1, '2023-10-01 10:00:00', 26200000),
(2, '2023-10-02 11:30:00', 28000000),
(3, '2023-10-03 09:15:00', 1200000),
(1, '2023-10-04 14:45:00', 1500000),
(5, '2023-10-05 16:20:00', 5500000);

INSERT INTO order_details (order_id, product_id, quantity, unit_price) VALUES
(1, 1, 1, 25000000),
(1, 3, 1, 1200000),  
(2, 2, 1, 28000000), 
(3, 3, 1, 1200000),  
(4, 4, 1, 1500000),  
(5, 5, 1, 5500000);  
