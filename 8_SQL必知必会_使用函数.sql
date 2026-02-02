-- 使用sql_learn 数据库
USE sql_learn;

/*
  只有少数几个函数被所有主要的DBMS等同地支持，虽然所有类型的函数一般都可以在每个DBMS中使用，但各个函数的名称和语法可能极其不同

  大多数SQL支持以下函数
  1、用于处理文本字符串（如删除或填充值，转换值为大写或小写）的文本函数。
  2、用于在数值数据上进行算术操作（如返回绝对值，进行代数运算）的数值函数。
  3、用于处理日期和时间值并从这些值中提取特定成分（如返回两个日期之差，检查日期有效性）的日期和时间函数。
  4、用于生成美观好懂的输出内容的格式化函数（如用语言形式表达出日期，用货币符号和千分位表示金额）。
  5、返回DBMS正使用的特殊信息（如返回用户登录信息）的系统函数。
*/

-- 文本处理函数
-- 将返回的字段转换为大写
SELECT vend_name, UPPER(vend_name) AS 'vend_name_upper'
FROM vendors
ORDER BY vend_name;

/*
1、LEFT（）返回字符串左边的字符
2、LENGTH（）返回字符串的长度
3、LOWER（）将字符串转换为小写
4、UPPER（）将字符串转换为大写
-- 字符串长度
LENGTH(string)        -- 返回字符数
*/

-- left 返回左侧n个字符
SELECT LEFT('hello word', 2);
-- right 返回右侧n个字符
SELECT RIGHT('hello word', 3);

-- 提取字符串 substring('字符串'，开始位置，截取长度)
-- 位置从1开始
SELECT SUBSTRING('hello word' FROM 2);
SELECT SUBSTRING('hello word' FROM 2 FOR 6);

-- 位置查找
-- POSITION 返回字符第一次出现的位置，不区分大小写，若为查找到返回0
SELECT POSITION('L' IN 'hello word');
SELECT POSITION('M' IN 'hello word');

-- 字符链接
-- concat函数，concat（字符串1，字符串2）
SELECT CONCAT('hello', ' ljj');

-- 日期和时间处理函数
-- 从DATETIME/TIMESTAMP提取
/*
YEAR('2024-01-15 10:30:45')        -- 2024
MONTH('2024-01-15')               -- 1
DAY('2024-01-15')                 -- 15
HOUR('10:30:45')                  -- 10
MINUTE('10:30:45')                -- 30
SECOND('10:30:45')                -- 45
WEEKDAY('2024-01-15')           -- 2（周日=1，周一=2）
*/
SELECT order_num
FROM orders
WHERE YEAR(order_date) = 2020;

-- 数值处理函数
-- 返回一个数的绝对数值
SELECT ABS(-1000);