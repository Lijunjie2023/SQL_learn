-- 使用sql_learn数据库
USE sql_learn;

-- 分组数据
-- 通过供应商ID进行分组并列出对应的产品数量
SELECT vend_id, COUNT(*) AS 'num_products'
FROM products
GROUP BY vend_id;

-- 过滤分组
-- 可以设置包括哪些分组、排除哪些分组
-- 使用 HAVING 关键字进行分组，用法类似WHERE，where过滤行，having过滤分组
SELECT vend_id, COUNT(*) AS 'num_products'
FROM products
GROUP BY vend_id
HAVING COUNT(*) > 2;

-- 过滤分组
-- 它列出具有两个以上产品且其价格大于等于4的供应商
SELECT vend_id, COUNT(*) AS num_products
FROM products
WHERE prod_price >= 4
GROUP BY vend_id
HAVING COUNT(*) >= 2;

/*
各字句优先级排序
SELECT 字段列表        -- 5. 选择显示的字段
FROM 表名             -- 1. 确定数据源
WHERE 条件            -- 2. 对原始行筛选（先执行）
GROUP BY 分组字段     -- 3. 分组（后执行）
HAVING 分组条件       -- 4. 对分组结果筛选
ORDER BY 排序字段     -- 6. 排序
*/

-- 它检索包含三个或更多物品的订单号和订购物品的数目
-- 要按订购物品的数目排序输出，需要添加ORDER BY子句
SELECT order_num, COUNT(*) AS 'items'
FROM orderitems
GROUP BY order_num
HAVING COUNT(*) >= 3
ORDER BY items, order_num;

-- 课后练习
/*
1. OrderItems 表包含每个订单的每个产品。编写 SQL语句，返回每个
订单号（order_num）各有多少行数（order_lines）， 并 按 order_lines
对结果进行排序。
*/
SELECT order_num, COUNT(*) AS order_lines
FROM orderitems
GROUP BY order_num
ORDER BY order_lines;

/*
3. 确定最佳顾客非常重要，请编写SQL语句，返回至少含100项的所有
订单的订单号（OrderItems表中的order_num）。
*/
SELECT order_num, SUM(quantity) AS total_num
FROM orderitems
GROUP BY order_num
HAVING SUM(quantity) >= 100
ORDER BY total_num;

/*
4. 确定最佳顾客的另一种方式是看他们花了多少钱。编写SQL语句，
返回总价至少为 1000 的所有订单的订单号（OrderItems 表中的
order_num）。提示：需要计算总和（item_price乘以quantity）。
按订单号对结果进行排序。
*/
SELECT order_num,SUM(item_price * quantity) AS total_price
FROM orderitems
GROUP BY order_num
HAVING SUM(item_price * quantity) >=1000
ORDER BY total_price;

/*
5. 下面的SQL语句有问题吗？（尝试在不运行的情况下指出。）
SELECT order_num, COUNT(*) AS items
FROM OrderItems
GROUP BY items
HAVING COUNT(*) >= 3
ORDER BY items, order_num;
*/

SELECT order_num, COUNT(*) AS items
FROM OrderItems
GROUP BY order_num
HAVING COUNT(*) >= 3
ORDER BY items, order_num;