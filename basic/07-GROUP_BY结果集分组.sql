-- GROUP BY 语句根据一个或多个列对结果集进行分组。

-- 在分组的列上我们可以使用 COUNT, SUM, AVG,等函数。

-- GROUP BY 语句是 SQL 查询中用于汇总和分析数据的重要工具，尤其在处理大量数据时，它能够提供有用的汇总信息。

-- GROUP BY 语法
-- SELECT column1, aggregate_function(column2)
-- FROM table_name
-- WHERE condition
-- GROUP BY column1;
-- column1：指定分组的列。
-- aggregate_function(column2)：对分组后的每个组执行的聚合函数。
-- table_name：要查询的表名。
-- condition：可选，用于筛选结果的条件。

-- 创建 employee_tbl 表
CREATE TABLE IF NOT EXISTS employee_tbl (
    id INT PRIMARY KEY,                -- 员工ID，主键
    name VARCHAR(50),                  -- 员工姓名
    date DATETIME,                     -- 签到日期和时间
    signin INT                         -- 签到次数
) engine = InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;

-- 插入示例数据
INSERT INTO employee_tbl (id, name, date, signin) 
VALUES
(1, '小明', '2016-04-22 15:25:33', 1),
(2, '小王', '2016-04-20 15:25:47', 3),
(3, '小丽', '2016-04-19 15:26:02', 2),
(4, '小王', '2016-04-07 15:26:14', 4),
(5, '小明', '2016-04-11 15:26:40', 4),
(6, '小明', '2016-04-04 15:26:54', 2);

-- 查询表中所有数据
SELECT * FROM employee_tbl;

-- 1. 统计每个名字的记录数
SELECT name, COUNT(*) FROM employee_tbl
GROUP BY name;

-- 使用 WITH ROLLUP
-- WITH ROLLUP 可以实现在分组统计数据基础上再进行相同的统计（SUM,AVG,COUNT…）
SELECT name, SUM(signin) as signin_count FROM  employee_tbl 
GROUP BY name WITH ROLLUP;

DROP TABLE IF EXISTS employee_tbl;