-- 使用sql_learn数据库
USE sql_learn;

-- 创建联结
-- 查找供应商对应的产品
SELECT vendors.vend_name, products.prod_name, products.prod_price
FROM vendors, products
WHERE vendors.vend_id = products.vend_id;

-- 使用where字句进行表联结，否则会产生笛卡尔积
SELECT vendors.vend_name, products.prod_name, products.prod_price
FROM vendors, products;

-- 内联结：它基于两个表之间的相等测试。
-- 标准联结，与简单联结
-- 以下是标准内联结方式
SELECT vendors.vend_name, products.prod_name, products.prod_price
FROM vendors
         INNER JOIN products ON vendors.vend_id = products.vend_id;

-- 联结多个表
-- SQL 不限制一条 SELECT 语句中可以联结的表的数目。创建联结的基本规则也相同。首先列出所有表，然后定义表之间的关系。
-- 输出供应商对应的产品名称、产品价格、产品数量
SELECT vendors.vend_name, products.prod_name, products.prod_price, orderitems.quantity
FROM vendors, products, orderitems
WHERE vendors.vend_id = products.vend_id
  AND products.prod_id = orderitems.prod_id
  AND order_num = 20007;

-- 使用表联结改写以下语句
-- 嵌套子查询
SELECT cust_name, cust_contact
FROM Customers
WHERE cust_id IN (SELECT cust_id
                  FROM Orders
                  WHERE order_num IN (SELECT order_num
                                      FROM OrderItems
                                      WHERE prod_id = 'RGAN01'));

-- 使用表联结
SELECT customers.cust_name, customers.cust_contact
FROM customers, orders, orderitems
WHERE customers.cust_id = orders.cust_id
  AND orders.order_num = orderitems.order_num
  AND orderitems.prod_id = 'RGAN01';

-- 挑战题
/*
1. 编写 SQL语句，返回Customers 表中的顾客名称（cust_name）和
Orders 表中的相关订单号（order_num），并 按 顾客名称再按订单号
对结果进行排序。实际上是尝试两次，一次使用简单的等联结语法，
一次使用INNER JOIN。
*/
-- 使用等联结
SELECT customers.cust_name, orders.order_num
FROM customers, orders
WHERE orders.cust_id = customers.cust_id
ORDER BY cust_name, order_num;

-- 使用INNER JOIN
SELECT customers.cust_name, orders.order_num
FROM customers
         INNER JOIN orders ON orders.cust_id = customers.cust_id
ORDER BY cust_name, order_num;

/*
2. 我们来让上一题变得更有用些。除了返回顾客名称和订单号，添加第
三列 OrderTotal，其中包含每个订单的总价。有两种方法可以执行
此操作：使用OrderItems表的子查询来创建OrderTotal列，或者
将OrderItems 表与现有表联结并使用聚合函数。提示：请注意需要
使用完全限定列名的地方。
*/
-- 使用表联结
SELECT customers.cust_name, orders.order_num, (orderitems.quantity * orderitems.item_price) AS OrderTotal
FROM customers, orders, orderitems
WHERE customers.cust_id = orders.cust_id
  AND orders.order_num = orderitems.order_num
ORDER BY cust_name;

/*

3. 我们重新看一下第11课的挑战题2。编写SQL语句，检索订购产品
BR01 的日期，这一次使用联结和简单的等联结语法。输出应该与第
11 课的输出相同。
4. 很有趣，我们再试一次。重新创建为第11课挑战题3编写的SQL语
句，这次使用ANSI的INNER JOIN 语法。在之前编写的代码中使用
了两个嵌套的子查询。要重新创建它，需要两个INNER JOIN语句，
每个语句的格式类似于本课讲到的INNER JOIN示例，而且不要忘记
WHERE 子句可以通过prod_id进行过滤。
5. 再让事情变得更加有趣些，我们将混合使用联结、聚合函数和分组。
准备好了吗？回到第10课，当时的挑战是要求查找值等于或大于1000
的所有订单号。这些结果很有用，但更有用的是订单数量至少达到
这个数的顾客名称。因此，编写 SQL语句，使用联结从 Customers
表返回顾客名称（cust_name），并从 OrderItems表返回所有订单的
总价。
提示：要联结这些表，还需要包括Orders 表（因为Customers 表
与OrderItems 表不直接相关，Customers 表与Orders 表相关，而
Orders 表与OrderItems 表相关）。不要忘记GROUP BY和HAVING，
并按顾客名称对结果进行排序。你可以使用简单的等联结或ANSI的
INNER JOIN 语法。或者，如果你很勇敢，请尝试使用两种方式编写。
*/
