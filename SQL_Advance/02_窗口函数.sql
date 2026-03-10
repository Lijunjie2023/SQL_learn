-- 使用sql_learn 数据库
USE sql_learn;
# 窗口函数基础语法
# 窗口函数 OVER (
#     [PARTITION BY 列1, 列2, ...]   -- 分区（分组），可选
#     [ORDER BY 列1 [ASC|DESC], ...] -- 排序，可选
#     [窗口框架子句]                  -- 定义窗口范围，可选
# )

# 对于每个订单，将其中的商品按单价从高到低排序，并显示排名（价格最高的为第1名）。
SELECT prod_id,
       RANK() OVER (
    ORDER BY
           )
FROM orderitems AS OI;
# 对于每个订单，按照商品添加到订单的顺序（假设没有时间戳，用 prod_id 排序代替），计算累计订购数量。

# 不考虑订单，只看每个 prod_id 在不同订单中的售价排名（相同价格使用 DENSE_RANK 获得相同排名，不跳过数字）。

# 计算每个订单的总金额，并计算各商品金额占比