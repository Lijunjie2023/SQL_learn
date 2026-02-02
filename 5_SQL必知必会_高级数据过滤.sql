-- 使用sql_learn 数据库
USE sql_learn;

-- AND操作符
# 要通过不止一个列进行过滤，可以使用AND操作符给WHERE子句附加条件。
-- 查询商品价格大于5，且供应商不等于DLL01的商品信息
SELECT prod_name, prod_price, vend_id
FROM products
WHERE prod_price > 5
  AND vend_id <> 'DLL01';

-- OR操作符
-- 查询供应商为DLl01 或供应商等于 FNG01的商品信息
SELECT prod_name, vend_id
FROM products
WHERE vend_id = 'DLL01'
   OR vend_id = 'FNG01';

-- 求值顺序
-- AND操作符的优先级高于OR操作符
-- 这里查询的是供应商为DLL01 或 供应商为BRS01 且价格大于5的商品
SELECT prod_name, prod_price, vend_id
FROM products
WHERE vend_id = 'DLL01'
   OR vend_id = 'BRS01' AND prod_price > 5;

-- 这里查询的是供应商为DLL01或BRS01 ，且价格大于5的商品
SELECT prod_name, prod_price, vend_id
FROM products
WHERE (vend_id = 'DLL01'
    OR vend_id = 'BRS01')
  AND prod_price > 5;

-- IN操作符
-- 查询供应商为DLL01或BRS01的商品信息
SELECT prod_name, vend_id
FROM products
WHERE vend_id IN ('DLL01', 'BRS01')
ORDER BY prod_name;

-- NOT 操作符
-- NOT 跟着where后
SELECT prod_name, vend_id
FROM products
WHERE NOT vend_id = 'Dll01'
ORDER BY prod_name;

-- 挑战题
# 1. 编写SQL语句，从Vendors表中检索供应商名称（vend_name）， 仅 返
# 回加利福尼亚州的供应商（这需要按国家[USA]和州[CA]进行过滤，
# 没准其他国家也存在一个加利福尼亚州）。提示：过滤器需要匹配字符串。
SELECT vend_name
FROM vendors
WHERE vend_country = 'USA'
  AND vend_state = 'CA'
ORDER BY vend_country;

# 2. 编写 SQL语句，查找所有至少订购了总量 100个的 BR01、BR02 或
# BR03 的订单。你需要返回OrderItems 表的订单号（order_num）、
# 产品ID（prod_id）和数量，并按产品 ID和数量进行过滤。提示：
# 根据编写过滤器的方式，可能需要特别注意求值顺序。
SELECT order_num, prod_id, quantity
FROM orderitems
WHERE prod_id IN ('BR01', 'BR02', 'BR03')
and quantity >= 100;


# 3. 编写SQL语句，返回所有价格在3
# 美元到6美元之间的产品的名称（prod_name）和价格（prod_price）。
# 使用AND，然后按价格对结果进行排序。

