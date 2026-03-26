-- 设置数据库
USE sql_parctice;

-- 表结构创建
CREATE TABLE user_login
(
    user_id    INT,
    login_date DATE
);

-- 插入示例数据
INSERT INTO user_login (user_id, login_date)
VALUES
-- 用户1：连续登录4天（1号到4号），满足条件，首次连续开始日期为2023-01-01
(1, '2023-01-01'),
(1, '2023-01-02'),
(1, '2023-01-03'),
(1, '2023-01-04'),
(1, '2023-01-10'), -- 单独一天，不影响

-- 用户2：连续登录3天（5号到7号），满足条件，首次连续开始日期为2023-01-05
(2, '2023-01-05'),
(2, '2023-01-06'),
(2, '2023-01-07'),
(2, '2023-01-09'), -- 单独一天

-- 用户3：两组连续3天（10-12和15-17），首次连续开始日期为2023-01-10
(3, '2023-01-10'),
(3, '2023-01-11'),
(3, '2023-01-12'),
(3, '2023-01-15'),
(3, '2023-01-16'),
(3, '2023-01-17'),

-- 用户4：间断登录，无连续3天
(4, '2023-01-02'),
(4, '2023-01-04'),
(4, '2023-01-07'),

-- 用户5：连续登录3天（20-22），满足条件，首次连续开始日期为2023-01-20
(5, '2023-01-20'),
(5, '2023-01-21'),
(5, '2023-01-22'),

-- 用户6：仅登录一天，不满足
(6, '2023-01-25'),

-- 用户7：跨月连续3天（2月1-3日），满足条件，首次连续开始日期为2023-02-01
(7, '2023-02-01'),
(7, '2023-02-02'),
(7, '2023-02-03'),

-- 用户8：连续5天（2月5-9日），满足条件，首次连续开始日期为2023-02-05
(8, '2023-02-05'),
(8, '2023-02-06'),
(8, '2023-02-07'),
(8, '2023-02-08'),
(8, '2023-02-09'),

-- 用户9：连续2天（2月10-11日），不满足
(9, '2023-02-10'),
(9, '2023-02-11'),

-- 用户10：间断登录，15-16连续2天，18单独，不满足
(10, '2023-02-15'),
(10, '2023-02-16'),
(10, '2023-02-18');

# 题目：有一张用户登录表user_login，包含字段：user_id（用户ID）、login_date（登录日期）。请找出连续登录至少3天的用户，并输出用户ID和首次连续登录的开始日期。

# 思路：连续性问题通常使用row_number()或dense_rank()与日期差值的方法。
# 先对每个用户去重。
# 然后按日期排序，给出行号。
# 计算login_date - rn，如果连续，差值相同。
# 按用户和差值分组，统计连续天数，得到每个连续段的起始日期（最小值）和天数。
# 筛选天数≥3的连续段。
# 最后按用户分组，取最小起始日期作为首次连续开始日期。

SELECT DISTINCT user_id, login_date
FROM user_login
ORDER BY login_date;

-- 断断续续写出来，问题一大堆，感觉有点乱
WITH distinct_logins AS (SELECT DISTINCT user_id,
                                         login_date
                         FROM user_login
                         ORDER BY login_date),
     ranked AS (SELECT user_id,
                       login_date,
                       ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY login_date) AS rn
                FROM distinct_logins),
     groups_day AS (SELECT user_id,
                           login_date,
                           (login_date - rn) AS continu
                    FROM ranked),
     continu_days AS (SELECT user_id,
                             continu,
                             MIN(login_date) AS start_login,
                             MAX(login_date) AS end_login,
                             COUNT(*)        AS days_count
                      FROM groups_day
                      GROUP BY user_id, continu)
SELECT user_id,
       start_login,
       end_login,
       days_count
FROM continu_days
WHERE days_count >= 3;


# 新思路：更清晰
# 为每个用户按登录日期排序，得到序号rn。
# 计算日期减去rn的天数，得到组标识（因为连续日期减去相同的rn会得到相同的日期）。注意：这里日期减整数，数据库函数需用date_sub或类似。
# 按用户和组标识分组，统计每组记录数（连续天数），筛选出天数>=3的组。
# 对于每个用户，可能有多个这样的组，需要找出最小的开始日期。开始日期就是该组的最小登录日期。
# 最后输出用户ID和开始日期。

WITH login_with_rn AS (SELECT user_id,
                              login_date,
                              ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY login_date) AS rn
                       FROM user_login),
     groups_days AS (SELECT user_id,
                            login_date,
                            DATE_SUB(login_date, INTERVAL rn DAY) AS group_date
                     FROM login_with_rn),
     continuous_days AS (SELECT user_id,
                                MIN(login_date)   AS start_login,
                                COUNT(group_date) AS days_count
                         FROM groups_days
                         GROUP BY user_id, group_date
                         HAVING days_count >= 3),
     first_continuous AS (SELECT user_id,
                                 start_login,
                                 days_count,
                                 ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY start_login) AS rn2
                          FROM continuous_days)
SELECT user_id, start_login, days_count
FROM first_continuous
WHERE rn2 = 1
ORDER BY user_id;
