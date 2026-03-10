-- 使用sql_learn 数据库
USE sql_learn;

# 高级分组：rollup,不同的sql语法不同
SELECT vend_id,COUNT(*) AS pro_count
FROM products
GROUP BY vend_id WITH ROLLUP ;