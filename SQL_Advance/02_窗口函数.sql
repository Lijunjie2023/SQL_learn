-- 使用sql_learn 数据库
USE sql_learn;
# 窗口函数基础语法
# 窗口函数 OVER (
#     [PARTITION BY 列1, 列2, ...]   -- 分区（分组），可选
#     [ORDER BY 列1 [ASC|DESC], ...] -- 排序，可选
#     [窗口框架子句]                  -- 定义窗口范围，可选
# )

# 对于每个订单，将其中的商品按单价从高到低排序，并显示排名（价格最高的为第1名）。
# 专用窗口函数rank, dense_rank, row_number区别
# rank：并列时占用相同排名，但排名数字会跳跃。
# DENSE_RANK()：并列时占用相同排名，排名数字连续。
# ROW_NUMBER()：为每一行分配一个唯一的连续整数，从1开始。
# 这种模式返回的是并列排名
SELECT order_num, prod_id,
       RANK() OVER (
           ORDER BY item_price DESC
           ) AS price_rank,
       DENSE_RANK() OVER (
           ORDER BY item_price DESC
           ) AS price_dense_rank,
       ROW_NUMBER() OVER (
           ORDER BY item_price DESC
           ) AS price_row_number
FROM orderitems AS OI;

# 对于每个订单，按照商品添加到订单的顺序（假设没有时间戳，用 prod_id 排序代替），计算累计订购数量。

# 不考虑订单，只看每个 prod_id 在不同订单中的售价排名（相同价格使用 DENSE_RANK 获得相同排名，不跳过数字）。
SELECT prod_id, item_price,
       DENSE_RANK() OVER (
           PARTITION BY prod_id
           ORDER BY item_price DESC
           ) AS pirce_dense_rank
FROM orderitems AS OI;
# 计算每个订单的总金额，并计算各商品金额占比
SELECT order_num, prod_id, quantity * item_price AS line_total,
       SUM(item_price * quantity) OVER (
           PARTITION BY order_num
           ORDER BY order_num
           ) AS order_totalprice,
       ROUND(
           100 * quantity * item_price /
           SUM(item_price * quantity) OVER (
           PARTITION BY order_num
           ),2) AS price_rate
FROM orderitems AS OI;

SELECT order_num,
       prod_id,
       quantity * item_price AS line_total,
       SUM(item_price * quantity) OVER (PARTITION BY order_num) AS order_totalprice,
       ROUND(
               100 * (quantity * item_price) /
               SUM(item_price * quantity) OVER (PARTITION BY order_num),
               2
       ) AS order_rate
FROM orderitems AS OI;