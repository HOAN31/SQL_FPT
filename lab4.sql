
-- 2. Xóa bảng (đúng thứ tự)
DROP TABLE IF EXISTS order_details;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS customers;
DROP TABLE suppliers;


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

--LAB4
--bài 1
--ALTER
-- Thêm cột email và cột note (ghi chú) cùng một lúc
ALTER TABLE customers 
ADD COLUMN email VARCHAR(100),
ADD COLUMN note TEXT;--UPDATE
update products set price = 20000000 where product_name = 'Laptop Dell XPS';
--DELETE ngư
delete from customers where full_name = 'Nguyễn Văn An';
-- bài 2
create table suppliers(
supplier_id serial primary key,
supplier_name varchar(255) not null,
contact_phone varchar(15) unique
);
-- bài 3
alter table suppliers add email varchar(100);

ALTER TABLE products ADD FOREIGN KEY (supplier_id)  REFERENCES suppliers(supplier_id);

--bai4
INSERT INTO suppliers (supplier_name, contact_phone, email) 
VALUES 
('Công ty Sữa Việt Nam', '0987654321', 'contact@vinamilk.vn'),
('Công ty Thực phẩm Á Châu', '0912345678', 'contact@acecook.vn');

UPDATE suppliers 
SET contact_phone = '0911112222'
WHERE supplier_name = 'Công ty Thực phẩm Á Châu';

DELETE FROM products
WHERE product_id = 8;

ALTER TABLE suppliers 
DROP COLUMN contact_phone;


select * from customers;
select * from products;
select * from order_details;
select * from orders;
select * from suppliers;


