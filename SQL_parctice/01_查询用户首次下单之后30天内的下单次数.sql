-- 设置数据库
USE sql_parctice;

-- 建表：
CREATE TABLE 01_orders
(
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id  INT      NOT NULL,
    pay_time DATETIME NOT NULL,
    amount   DECIMAL(10, 2) COMMENT '订单金额，可选字段'
) COMMENT '订单表';

-- 插入数据
INSERT INTO 01_orders (user_id, pay_time, amount)
VALUES (1, '2023-01-01 10:00:00', 100.00), -- 用户1首次付费
       (1, '2023-01-15 14:30:00', 200.00), -- 用户1首次后14天（30天内）
       (1, '2023-02-05 09:20:00', 150.00), -- 用户1首次后35天（超出30天）
       (2, '2023-02-10 11:00:00', 300.00), -- 用户2首次付费
       (2, '2023-02-25 16:45:00', 250.00), -- 用户2首次后15天（30天内）
       (3, '2023-03-01 08:30:00', 500.00), -- 用户3首次付费（30天内无后续付费）
       (1, '2023-01-20 12:00:00', 120.00);
-- 用户1首次后19天（30天内，增加一条）

# 题目：查询每个用户在首次付费之后30天内的付费次数
# 思路：先找到每个用户的首次下单时间、再进行时间筛选
SELECT user_id, MIN(pay_time) AS fist_paytime
FROM 01_orders
GROUP BY user_id;

# 版本1,使用
WITH fist_paytime_cte AS (SELECT user_id, MIN(pay_time) AS fist_paytime
                          FROM 01_orders
                          GROUP BY user_id)
SELECT orders.user_id, COUNT(fist_paytime_cte.user_id) AS pay_num
FROM 01_orders orders
         LEFT JOIN fist_paytime_cte ON
    orders.user_id = fist_paytime_cte.user_id AND
    orders.pay_time > (fist_paytime_cte.fist_paytime) AND
    orders.pay_time <= (DATE_ADD(fist_paytime_cte.fist_paytime,INTERVAL 30 DAY))
GROUP BY orders.user_id;

WITH first_pay AS (
    SELECT user_id, MIN(pay_time) AS first_time
    FROM 01_orders
    GROUP BY user_id
)
SELECT
    f.user_id,
    COUNT(o.user_id) AS pay_count_within_30_days
FROM first_pay f
LEFT JOIN 01_orders o
    ON f.user_id = o.user_id
    AND o.pay_time > f.first_time                     -- 不包括首次付费
    AND o.pay_time <= DATE_ADD(f.first_time, INTERVAL 30 DAY)
GROUP BY f.user_id;

# 内联结会剔除掉后续没有订单的用户
WITH fist_paytime_cte AS (SELECT user_id, MIN(pay_time) AS fist_paytime
                          FROM 01_orders
                          GROUP BY user_id)
SELECT orders.user_id, COUNT(fist_paytime_cte.user_id) AS pay_num
FROM 01_orders orders
         INNER JOIN fist_paytime_cte ON
    orders.user_id = fist_paytime_cte.user_id AND
    orders.pay_time > (fist_paytime_cte.fist_paytime) AND
    orders.pay_time <= (DATE_ADD(fist_paytime_cte.fist_paytime,INTERVAL 30 DAY))
GROUP BY orders.user_id;
