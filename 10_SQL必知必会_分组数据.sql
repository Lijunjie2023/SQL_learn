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

-- 它列出具有两个以上产品且其价格大于等于4的供应商
SELECT vend_id,COUNT(*) AS num_products
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