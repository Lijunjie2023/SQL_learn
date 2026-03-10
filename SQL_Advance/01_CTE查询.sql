-- 使用sql_learn 数据库
USE sql_learn;

# 查询每个供应商旗下的产品数量
# 1、使用普通的查询
SELECT V.vend_id, COUNT(*) AS porduct_num
FROM vendors AS V, products AS P
WHERE V.vend_id = P.vend_id
GROUP BY P.vend_id;

# 2、使用CTE查询
WITH product_CTE AS (SELECT vend_id, COUNT(*) AS product_num
                     FROM products
                     GROUP BY vend_id)
SELECT v.vend_id, vend_name, P_CTE.product_num
FROM vendors AS v, product_CTE AS P_CTE
WHERE v.vend_id = P_CTE.vend_id;

# 2、使用CTE查询 - 使用Inner join 显示表联结
WITH product_CTE AS (SELECT vend_id, COUNT(*) AS product_num
                     FROM products
                     GROUP BY vend_id)
SELECT v.vend_id, vend_name, P_CTE.product_num
FROM vendors v
         INNER JOIN product_CTE P_CTE
WHERE v.vend_id = P_CTE.vend_id;