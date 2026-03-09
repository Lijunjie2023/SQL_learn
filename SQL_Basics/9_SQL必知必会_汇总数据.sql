-- 使用sql_learn数据库
USE sql_learn;

-- 聚集函数
-- 查询所有商品的平均价格，查询单列的平均值
SELECT AVG(prod_price) AS 'avg_price'
FROM products;

-- AVG()也可以用来确定特定列或行的平均值。下面的例子返回特定供应商所提供产品的平均价格
-- AVG()函数忽略列值为NULL的行。
SELECT AVG(prod_price) AS avg_price
FROM products
WHERE vend_id = 'Dll01';

-- count 函数
-- COUNT()函数进行计数。可利用 COUNT()确定表中行的数目或符合特定条件的行的数目。
SELECT COUNT(prod_price) AS nums
FROM products;

-- 如果指定列名，则COUNT()函数会忽略指定列的值为NULL的行，但如果COUNT()函数中用的是星号（*），则不忽略。
-- 返回Customers表中顾客的总数：这里返回5，不忽略null的情况
SELECT COUNT(*) AS customs
FROM customers;

-- 这里返回3，因为过滤了null
SELECT COUNT(cust_email) AS cust_num
FROM customers;

-- max函数 返回指定列的最大值
SELECT MAX(prod_price) AS max_price
FROM products;

-- min函数 返回指定列的最小值
SELECT MIN(prod_price) AS min_price
FROM products;

-- sum函数，SUM()用来返回指定列值的和（总计）。
SELECT SUM(quantity) AS all_quantity
FROM orderitems
WHERE prod_id = 'BR01';

-- sum也可以用来合计计算值
SELECT SUM(quantity * item_price) AS total_price
FROM orderitems
WHERE prod_id = 'BNBG01';

-- 聚集不同值
-- 以上5个聚集函数都可以如下使用，只计算不同值
-- 计算单个商品价格的平均值
SELECT AVG(DISTINCT item_price) AS avg_price
FROM orderitems;

-- 组合聚集函数，目前为止的所有聚集函数例子都只涉及单个函数。但实际上，SELECT语句可根据需要包含多个聚集函数。
-- 用聚集函数时最好指定别名，这样可读性更高
SELECT COUNT(*) AS product_num,
       AVG(prod_price) AS avg_price,
       MIN(prod_price) AS min_price,
       MAX(prod_price) AS max_price
FROM products;