-- MySQL 元数据是关于数据库和其对象（如表、列、索引等）的信息。

-- 元数据存储在系统表中，这些表位于 MySQL 数据库的 information_schema 数据库中，通过查询这些系统表，你可以获取关于数据库结构、对象和其他相关信息的详细信息。

-- 你可能想知道MySQL以下三种信息：

-- 查询结果信息： SELECT, UPDATE 或 DELETE语句影响的记录数。
-- 数据库和数据表的信息： 包含了数据库及数据表的结构信息。
-- MySQL 服务器信息： 包含了数据库服务器的当前状态，版本号等。


DROP DATABASE IF EXISTS `testdb`;
CREATE DATABASE `testdb`;
USE `testdb`;

DROP TABLE IF EXISTS `employees`;
CREATE TABLE `employees` (
    employee_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    salary FLOAT DEFAULT 0
)engine = InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
DESC `employees`;

DROP TABLE IF EXISTS `card`;
CREATE TABLE  `card` (
    name VARCHAR(255),
    employee_id INT UNIQUE PRIMARY KEY,
    FOREIGN KEY(`employee_id`) REFERENCES `employees` (employee_id)
) engine = InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
DESC `card`;

-- 1. 查看所有数据库
SHOW DATABASES;

-- 2. 选择数据库
USE information_schema;

-- 3. 查看数据库中的所有表
SHOW TABLES;

-- 4. 查看表结构
DESC `CHARACTER_SETS`;

-- 5. 查看表索引
SHOW INDEX FROM `CHARACTER_SETS`;

-- 6. 显示行数
SELECT COUNT(*) FROM `CHARACTER_SETS`;

-- 7. 查看列的信息
SELECT COLUMN_NAME, DATA_TYPE, IS_NULLABLE, COLUMN_KEY
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'information_schema'
AND TABLE_NAME = 'CHARACTER_SETS';

-- 8. 查看外键信息：

SELECT
    TABLE_NAME,
    COLUMN_NAME,
    CONSTRAINT_NAME,
    REFERENCED_TABLE_NAME,
    REFERENCED_COLUMN_NAME
FROM
    INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE
    TABLE_SCHEMA = 'your_database_name'
    AND TABLE_NAME = 'your_table_name'
    AND REFERENCED_TABLE_NAME IS NOT NULL;


-- information_schema 数据库
-- information_schema 是 MySQL 数据库中的一个系统数据库，它包含有关数据库服务器的元数据信息，这些信息以表的形式存储在 information_schema 数据库中

-- SCHEMATA 表
-- 存储有关数据库的信息，如数据库名、字符集、排序规则等。

SELECT * FROM information_schema.SCHEMATA;

-- TABLES 表
-- 包含有关数据库中所有表的信息，如表名、数据库名、引擎、行数等。
SELECT * FROM information_schema.TABLES WHERE `TABLE_SCHEMA`= 'testdb';

-- COLUMNS 表
-- 包含有关表中列的信息，如列名、数据类型、是否允许 NULL 等。
SELECT * FROM information_schema.COLUMNS 
WHERE `TABLE_SCHEMA`= 'testdb' AND `TABLE_NAME` = 'card';

-- KEY_COLUMN_USAGE 表
-- 包含有关表中外键的信息，如外键名、列名、关联表等。

SELECT * FROM information_schema.KEY_COLUMN_USAGE 
WHERE `TABLE_SCHEMA` = 'testdb' AND `TABLE_NAME` = 'card';

-- REFERENTIAL_CONSTRAINTS 表
-- 存储有关外键约束的信息，如约束名、关联表等。

SELECT * FROM information_schema.REFERENTIAL_CONSTRAINTS 
WHERE `CONSTRAINT_SCHEMA` = 'testdb' AND `TABLE_NAME` = 'card';




-- 获取服务器元数据
SELECT VERSION();	-- 服务器版本信息
SELECT DATABASE();	 -- 当前数据库名 (或者返回空)
SELECT USER();	-- 当前用户名
SHOW STATUS;-- 服务器状态
SHOW VARIABLES;	--服务器配置变量