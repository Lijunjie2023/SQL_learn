-- 使用sql_learn 数据库
USE sql_learn;

-- 常使用的通配符是百分号（%）。在搜索串中，%表示任何字符出现任意次数。
-- 查找所有以Fish开头的商品
SELECT prod_name
FROM products
WHERE prod_name LIKE 'Fish%';
-- 查找所有包含bean字符的商品
SELECT prod_name
FROM products
WHERE prod_name LIKE '%bean%';


-- 另一个有用的通配符是下划线（_）。下划线的用途与%一样，但它只匹配单个字符，而不是多个字符。
-- 只匹配一个字符，有两个__代表匹配两个字符
SELECT prod_name
FROM products
WHERE prod_name LIKE '_ inch teddy bear';

-- 挑战题
/*
1. 编写SQL语句，从Products表中检索产品名称（prod_name）和描
述（prod_desc），仅返回描述中包含toy一词的产品。
*/
SELECT prod_name, prod_desc
FROM products
WHERE prod_desc LIKE '%toy%';

/*
2. 反过来再来一次。编写 SQL语句，从 Products 表中检索产品名称
（prod_name）和描述（prod_desc），仅返回描述中未出现toy一词
的产品。这次，按产品名称对结果进行排序。
*/
SELECT prod_name, prod_desc
FROM products
WHERE prod_desc LIKE '%toy%'
ORDER BY prod_name;

/*
3. 编写SQL语句，从Products表中检索产品名称（prod_name）和描
述（prod_desc），仅返回描述中同时出现toy和carrots的产品。
有好几种方法可以执行此操作，但对于这个挑战题，请使用 AND和两
个LIKE比较。
*/
SELECT prod_name, prod_desc
FROM products
WHERE prod_desc LIKE '%toy%'
  AND prod_desc LIKE '%carrots%';

/*
4. 来个比较棘手的。我没有特别向你展示这个语法，而是想看看你根据
目前已学的知识是否可以找到答案。编写SQL语句，从Products表
中检索产品名称（prod_name）和描述（prod_desc），仅返回在描述
中以先后顺序同时出现toy 和carrots 的产品。提示：只需要用带
有三个 % 符号的LIKE即可。
*/
SELECT prod_name,prod_desc FROM products WHERE prod_desc LIKE '%toy%carrots%';

