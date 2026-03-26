-- 设置数据库
USE sql_parctice;

#  创建表
CREATE TABLE sales
(
    product_id INT,
    sale_date  DATE,
    amount     DECIMAL(10, 2)
);

# 插入数据
-- 产品A：有连续多天的销售记录
INSERT INTO sales
VALUES (1, '2024-01-01', 100.00),
       (1, '2024-01-02', 150.00),
       (1, '2024-01-03', 80.00),
       (1, '2024-01-05', 200.00), -- 中间有日期空缺
       (1, '2024-01-06', 120.00);

-- 产品B：只有部分日期的销售
INSERT INTO sales
VALUES (2, '2024-01-01', 300.00),
       (2, '2024-01-03', 250.00),
       (2, '2024-01-04', 180.00);

-- 产品C：单条记录
INSERT INTO sales
VALUES (3, '2024-01-02', 500.00);

# 题目：有一张销售表sales，包含字段：product_id（产品ID）、sale_date（销售日期）、amount（销售额）。
# 请计算每个产品截至当天的累计销售额，输出产品ID、销售日期、当日销售额、累计销售额。

# 思路：窗口函数计算累计
SELECT product_id,
       sale_date,
       amount AS daily_amount,
       SUM(amount) OVER (
           PARTITION BY product_id
           ORDER BY sale_date
           ) AS cumulative_amount
FROM sales;

