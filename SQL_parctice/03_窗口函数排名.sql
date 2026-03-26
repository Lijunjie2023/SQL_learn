-- 设置数据库
USE sql_parctice;

# 前置准备
# 创建表
# 字段：dept_id（部门ID）、emp_id（员工ID）、salary（工资）
CREATE TABLE employee
(
    dept_id INT,
    emp_id  INT,
    salary  DECIMAL(10, 2)
);

# 插入测试数据
-- 部门1：有5名员工，工资最高为10000，第二名有两个并列9000
INSERT INTO employee
VALUES (1, 101, 10000),
       (1, 102, 9000),
       (1, 103, 9000),
       (1, 104, 8000),
       (1, 105, 7000);

-- 部门2：有3名员工，工资分别为9000、8000、8000
INSERT INTO employee
VALUES (2, 201, 9000),
       (2, 202, 8000),
       (2, 203, 8000);

-- 部门3：只有1名员工
INSERT INTO employee
VALUES (3, 301, 12000);

# 题目：有一张员工表employee，包含字段：dept_id（部门ID）、emp_id（员工ID）、salary（工资）。请找出每个部门工资最高的前2名员工，输出部门ID、员工ID、工资

# 个人思路：
# 1、窗口函数、根据部门分组排序，输出前两名员工数据
# 这里不能直接用limit，limit是对整个结果集的限制
SELECT dept_id,
       emp_id,
       salary,
       ROW_NUMBER() OVER (
           PARTITION BY dept_id ORDER BY salary DESC
           ) AS rank_salary
FROM employee
LIMIT 2;

# 用CTE表达式先计算排名，再用where进行限制
# DENSE_RANK()可以取并列排名，看具体的业务场景
#   - ROW_NUMBER()：为分区内的每一行分配一个唯一的连续整数（1 开始），即使值相同，顺序也唯一。
#   - RANK()：相同值获得相同排名，但会跳过后续排名（如 1,1,3）。
#   - DENSE_RANK()：相同值获得相同排名，但不会跳过排名（如 1,1,2）。
WITH salary_rank AS (SELECT dept_id,
                            emp_id,
                            salary,
                            ROW_NUMBER() OVER (
                                PARTITION BY dept_id ORDER BY salary DESC
                                ) AS rank_salary
                     FROM employee)
SELECT dept_id,
       emp_id,
       salary
FROM salary_rank
WHERE rank_salary <=2;

