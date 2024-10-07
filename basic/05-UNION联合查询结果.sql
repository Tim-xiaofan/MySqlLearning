-- 描述
-- MySQL UNION 操作符用于连接两个以上的 SELECT 语句的结果组合到一个结果集合，并去除重复的行。
-- UNION 操作符必须由两个或多个 SELECT 语句组成，每个 SELECT 语句的列数和对应位置的数据类型必须相同。

-- 语法
-- MySQL UNION 操作符语法格式：
-- SELECT column1, column2, ...
-- FROM table1
-- WHERE condition1
-- UNION
-- SELECT column1, column2, ...
-- FROM table2
-- WHERE condition2
-- [ORDER BY column1, column2, ...];

-- 参数说明：
-- column1, column2, ... 是你要选择的列的名称，如果使用 * 表示选择所有列。
-- table1, table2, ... 是你要从中查询数据的表的名称。
-- condition1, condition2, ... 是每个 SELECT 语句的过滤条件，是可选的。
-- ORDER BY 子句是一个可选的子句，用于指定合并后的结果集的排序顺序。

-- 创建Websites表
CREATE TABLE IF NOT EXISTS Websites (
    id INT PRIMARY KEY,         -- 网站ID，主键
    name VARCHAR(100) NOT NULL,          -- 网站名称
    url VARCHAR(255) NOT NULL,           -- 网站URL
    alexa INT,                  -- 网站在Alexa排名
    country VARCHAR(50)       -- 所在国家/地区
) engine = InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;

-- 插入示例数据
INSERT INTO Websites (id, name, url, alexa, country) 
VALUES
(1, 'Google', 'https://www.google.cm/', 1, 'USA'),
(2, '淘宝', 'https://www.taobao.com/', 13, 'CN'),
(3, '菜鸟教程', 'http://www.runoob.com/', 4689, 'CN'),
(4, '微博', 'http://weibo.com/', 20, 'CN'),
(5, 'Facebook', 'https://www.facebook.com/', 3, 'USA'),
(7, 'stackoverflow', 'http://stackoverflow.com/', 0, 'IND');


-- 创建apps表
CREATE TABLE IF NOT EXISTS apps (
    id INT PRIMARY KEY,          -- 应用ID，主键
    app_name VARCHAR(100) NOT NULL,       -- 应用名称
    url VARCHAR(255) NOT NULL,            -- 应用URL
    country VARCHAR(50)          -- 所在国家/地区
) engine = InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci ;

-- 插入示例数据
INSERT INTO apps (id, app_name, url, country) 
VALUES
(1, 'QQ APP', 'http://im.qq.com/', 'CN'),
(2, '微博 APP', 'http://weibo.com/', 'CN'),
(3, '淘宝 APP', 'https://www.taobao.com/', 'CN');

-- 查询表中所有数据
SELECT * FROM apps;

-- 查询表中所有数据
SELECT * FROM Websites;



-- UNION 语句: 从 "Websites" 和 "apps" 表中选取所有不同的country（只有不同的值）
SELECT country FROM Websites
UNION
SELECT country FROM apps
ORDER BY country;

-- UNION ALL 语句：可以重复
SELECT country FROM Websites
UNION ALL
SELECT country FROM apps
ORDER BY country;

-- 带有 WHERE 的 SQL UNION ALL：选取所有的中国(CN)的数据（也有重复的值）
SELECT country, name FROM Websites
WHERE country = 'CN'
UNION ALL
SELECT country, app_name FROM apps
WHERE country = 'CN'
ORDER BY country;

-- 删除数据表
DROP TABLE IF EXISTS Websites;
DROP TABLE IF EXISTS apps;