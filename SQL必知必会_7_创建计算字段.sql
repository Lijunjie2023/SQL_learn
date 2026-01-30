-- 使用sql_learn数据库
USE sql_learn;

-- 创建计算字段
-- 数据展示优化、业务计算、数据转化等场景使用
-- SQL Server 使用+号。DB2、Oracle、Postgre SQL和 SQLite使用||。
SELECT vend_name + '(' + vend_country + ')'
FROM vendors
ORDER BY vend_name;

SELECT vend_name || '(' || vend_country || ')'
FROM vendors
ORDER BY vend_name;

-- mysql 需要使用对应的函数拼接结果
SELECT CONCAT(vend_name, '(', vend_country, ')')
FROM vendors;

-- 使用别名,给计算列命名
SELECT CONCAT(vend_name, '(', vend_country, ')') AS 'vend_title'
FROM vendors;

-- RTRIM()去掉右侧空hLTRIM()（去掉字符串左边的空格）以及 TRIM()（去掉字符串左右两边的空格）
SELECT RTRIM(vend_name)
FROM vendors;

-- 执行算数计算
SELECT prod_id,quantity,item_price
FROM orderitems
ORDER BY prod_id;

-- 检索订单号20008中的所有物品并计算
SELECT prod_id,quantity,item_price,
       quantity*item_price AS expanded_price
FROM orderitems
ORDER BY prod_id;