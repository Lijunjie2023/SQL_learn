-- 使用sql_learn 数据库
USE sql_learn;
-- 查询商品名名称、商品价格，限定商品价格为3.49
SELECT prod_name,prod_price FROM products WHERE prod_price=3.49;

-- 检查单个值
-- 列出所有商品价格小于10的商品
SELECT  prod_name,prod_price FROM products WHERE prod_price < 10;

-- 不匹配检查
-- 列出所有不是供应商DLL01制造的产品
SELECT prod_name,vend_id FROM products WHERE vend_id <> "DLL01";

-- 范围值检查
-- 要检查某个范围内的值，可以使用between 关键字
SELECT prod_name,prod_price FROM products WHERE prod_price BETWEEN 5 AND 10;

-- 空值检查
SELECT prod_name,prod_price FROM products WHERE prod_price IS NULL ;
SELECT cust_name,cust_email FROM customers WHERE cust_email IS NULL ;

-- 挑战题
# 1. 编写SQL语句，从Products表中检索产品ID（prod_id）和产品名称（prod_name），
# 只返回价格为9.49美元的产品。
SELECT prod_id,prod_name FROM products WHERE prod_price = 9.49;

# 2. 编写SQL语句，从Products表中检索产品ID（prod_id）和产品名称（prod_name），
# 只返回价格为9美元或更高的产品。
SELECT prod_id,prod_name FROM products WHERE prod_price >= 9;

# 3. 结合第3课和第4课编写SQL语句，从OrderItems表中检索出所有不同订单号（order_num），
# 其中包含100个或更多的产品。
-- 应该要按订单号聚合
SELECT DISTINCT order_num FROM orderitems WHERE quantity >= 100;

# 4. 编写SQL语句，返回Products表中所有价格在3美元到6美元之间的产品的名称（prod_name）和价格（prod_price），
# 然后按价格对结果进行排序。