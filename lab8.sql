
-- Chuẩn bị cột dữ liệu cho Bài 2
ALTER TABLE products ADD category VARCHAR(50);

-- BÀI 1
-- GROUP BY
SELECT product_name, AVG(price) AS avg_price
FROM products
GROUP BY product_name; 

/* TRẢ LỜI
- Vấn đề của GROUP BY: Nó gộp các hàng lại. Vì mỗi product_name là duy nhất, 
  nó chỉ tính trung bình cho chính sản phẩm đó thay vì toàn cửa hàng.
- Window Function giải quyết thế nào: Nó tính toán trên "cửa sổ" dữ liệu 
  mà không làm mất đi chi tiết của từng dòng sản phẩm.
*/

--Window Function 
SELECT 
    product_name, 
    price, 
    AVG(price) OVER () AS avg_overall_price
FROM products;

-- BÀI 2
-- So sánh giá SP với giá trung bình trong cùng danh mục (category)
SELECT 
    category, 
    product_name, 
    price, 
    AVG(price) OVER (PARTITION BY category) AS avg_category_price
FROM products;

-- BÀI 3
-- Cập nhật giá 2 sản phẩm bằng nhau để thấy rõ sự khác biệt 
UPDATE products SET price = 35000 WHERE product_id IN (1, 2);

-- Thực hành các hàm xếp hạng
SELECT 
    product_name, 
    price,
    ROW_NUMBER() OVER (ORDER BY price DESC) AS row_num,
    RANK() OVER (ORDER BY price DESC) AS rank_num,
    DENSE_RANK() OVER (ORDER BY price DESC) AS dense_rank_num
FROM products;
/*TRẢ LỜI :
- Vấn đề của GROUP BY: Nó gộp các hàng lại. Vì mỗi product_name là duy nhất, 
  nó chỉ tính trung bình cho chính sản phẩm đó thay vì toàn cửa hàng.
- Window Function giải quyết thế nào: Nó tính toán trên "cửa sổ" dữ liệu 
  mà không làm mất đi chi tiết của từng dòng sản phẩm.
*/

-- BÀI 4
-- Sử dụng CTE (Bảng tạm)
WITH daily_revenue AS (
    SELECT 
        o.order_date, 
        SUM(oi.quantity * p.price) AS total_daily_revenue
    FROM orders o
    JOIN order_details oi ON o.order_id = oi.order_id
    JOIN products p ON oi.product_id = p.product_id 
    GROUP BY o.order_date
)
-- Window Function
SELECT 
    order_date, 
    total_daily_revenue,
    SUM(total_daily_revenue) OVER (ORDER BY order_date) AS running_total_revenue
FROM daily_revenue;


