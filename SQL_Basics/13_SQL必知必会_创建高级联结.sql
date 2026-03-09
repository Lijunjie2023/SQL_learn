-- 使用sql_learn数据库
USE sql_learn;

# SQL除了可以对列名和计算字段使用别名，还允许给表名起别名。
# 这样做有两个主要理由：
# 缩短SQL语句；
# 允许在一条SELECT语句中多次使用相同的表。

SELECT cust_name, cust_contact
FROM customers, orders, orderitems
WHERE customers.cust_id = orders.cust_id
  AND orderitems.order_num = orders.order_num
  AND prod_id = 'RGAN01';

# 使用表别名
# 查询产品名称为"RGA01"的顾客名称、顾客联系人
SELECT cust_name, cust_contact
FROM customers AS C, orders AS O, orderitems AS OI
WHERE C.cust_id = O.cust_id
  AND OI.order_num = O.order_num
  AND prod_id = 'RGAN01';

# 使用不同类型的联结
# 1. 自联结（self—join）
# 2. 自然联结（natural join）
# 3. 外联结（outer join）

# 1、自联结，一般来说，自联结的效率会更高
# 查询customers表中顾客联系方式JIM 的顾客名称
SELECT c1.cust_id, c1.cust_name, c1.cust_contact
FROM Customers AS c1, Customers AS c2
WHERE c1.cust_name = c2.cust_name
  AND c2.cust_contact = 'Jim Jones';

# 先生成笛卡尔积
# 再筛选Where两个条件
SELECT c1.cust_id, c1.cust_name, c1.cust_contact, c2.cust_name, c2.cust_contact
FROM Customers AS c1, Customers AS c2
WHERE c2.cust_contact = 'Jim Jones';


# 自然联结
# 它会自动将两个表中所有同名且数据类型兼容的列作为连接条件，进行等值连接，并在结果中只保留一份这些同名列。
# 事实上，我们迄今为止建立的每个内联结都是自然联结，很可能永远都不会用到不是自然联结的内联结。
SELECT c.*, o.order_num, o.order_date, OI.prod_id, OI.quantity, OI.item_price
FROM customers AS C, orders AS O, orderitems AS OI
WHERE c.cust_id = o.cust_id
  AND OI.order_num = o.order_num
  AND prod_id = 'RGAN01';


# 外联结
