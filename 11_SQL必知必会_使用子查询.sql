-- 使用sql_learn数据库
USE sql_learn;

-- SQL还允许创建子查询（subquery），即嵌套在其他查询中的查询。

-- 使用子查询进行过滤
-- 需要列出订购物品 RGAN01 的所有顾客，应该怎样检索？
-- 找出订单号
SELECT order_num
FROM orderitems
WHERE prod_id = 'RGAN01';
-- 根据订单号找到对应的用户id
SELECT cust_id
FROM orders
WHERE order_num IN (20007, 20008);
-- 根据用户ID找到对应的姓名
SELECT cust_name
FROM customers
WHERE cust_id IN (1000000004, 1000000005);

-- 使用子查询
-- 子查询由内向外运行，直接嵌套所需要的语句，作为子查询，只能查询单列数据
SELECT cust_name
FROM customers
WHERE cust_id IN (SELECT cust_id
                  FROM orders
                  WHERE order_num IN (SELECT order_num
                                      FROM orderitems
                                      WHERE prod_id = 'RGAN01'));

-- 使用计算字段使用子查询
-- 如需要显示Customers表中每个顾客的订单总数。订单与相应的顾客ID存储在Orders表中
SELECT cust_id
FROM customers
ORDER BY cust_id;
-- 计算统计的订单总数
SELECT cust_id, COUNT(*)
FROM orders
WHERE cust_id = 1000000001;

-- 使用计算字段
SELECT cust_id, cust_name, (SELECT COUNT(*) FROM orders WHERE Customers.cust_id = orders.cust_id) AS orders
FROM customers
ORDER BY cust_name;

-- 挑战题
/*
1. 使用子查询，返回购买价格为 10 美元或以上产品的顾客列表。你需
要使用 OrderItems 表查找匹配的订单号（order_num），然后使用
Order 表检索这些匹配订单的顾客ID（cust_id）。
*/
SELECT order_num
FROM orderitems
WHERE item_price >= 10
ORDER BY order_num;

-- 使用子查询嵌套
SELECT cust_id, order_num
FROM orders
WHERE order_num IN (SELECT order_num
                    FROM orderitems
                    WHERE item_price >= 10
                    ORDER BY order_num);

/*
2. 你想知道订购BR01产品的日期。编写SQL语句，使用子查询来确定
哪些订单（在OrderItems中）购买了prod_id为BR01的产品，然
后从Orders 表中返回每个产品对应的顾客ID（cust_id）和订单日
期（order_date）。按订购日期对结果进行排序。
*/
SELECT cust_id, order_date
FROM orders
WHERE order_num IN (SELECT order_num
                    FROM orderitems
                    WHERE prod_id IN ('BR01'))
ORDER BY order_date;

/*
3. 现在我们让它更具挑战性。在上一个挑战题，返回购买 prod_id 为
BR01 的产品的所有顾客的电子邮件（Customers表中的cust_email）。
提示：这涉及SELECT语句，最内层的从OrderItems表返回order_num，
中间的从Customers表返回cust_id。
*/
SELECT cust_email
FROM customers
WHERE cust_id IN (SELECT cust_id
                  FROM orders
                  WHERE order_num IN (SELECT order_num
                                      FROM orderitems
                                      WHERE prod_id IN ('BR01')))
ORDER BY cust_name;


/*
4. 我们需要一个顾客ID列表，其中包含他们已订购的总金额。编写SQL
语句，返回顾客 ID（Orders 表中的 cust_id），并使用子查询返回
total_ordered 以便返回每个顾客的订单总数。将结果按金额从大到
小排序。提示：你之前已经使用SUM()计算订单总数。
*/

/*
5. 再来。编写SQL语句，从Products表中检索所有的产品名称（prod_
name），以及名为 quant_sold 的计算列，其中包含所售产品的总数
（在OrderItems 表上使用子查询和SUM(quantity)检索）。
*/
