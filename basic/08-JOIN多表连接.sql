-- JOIN 按照功能大致分为如下三类：

-- INNER JOIN（内连接,或等值连接）：获取两个表中字段匹配关系的记录。
-- LEFT JOIN（左连接）：获取左表所有记录，即使右表没有对应匹配的记录。
-- RIGHT JOIN（右连接）： 与 LEFT JOIN 相反，用于获取右表所有记录，即使左表没有对应匹配的记录。

USE testdb;

-- 创建 tcount_tbl 表，指定引擎为 InnoDB，字符集为 utf8mb
DROP TABLE IF EXISTS tcount_tbl;
CREATE TABLE IF NOT EXISTS tcount_tbl (
    `runoob_author` varchar(255) NOT NULL DEFAULT '',
    `runoob_count` int(11) NOT NULL DEFAULT '0'
) engine = InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;

-- 插入数据到 tcount_tbl
INSERT INTO tcount_tbl (runoob_author, runoob_count) 
VALUES
('菜鸟教程', 10),
('RUNOOB.COM', 20),
('Google', 22);

-- 查询 tcount_tbl 数据
SELECT * FROM tcount_tbl;

-- 创建 runoob_tbl 表，指定引擎为 InnoDB，字符集为 utf8mb
DROP TABLE IF EXISTS runoob_tbl;
CREATE TABLE IF NOT EXISTS runoob_tbl (
    `runoob_id` int(11) NOT NULL AUTO_INCREMENT,
    `runoob_title` varchar(100) NOT NULL,
    `runoob_author` varchar(40) NOT NULL,
    `submission_date` DATE DEFAULT NULL,
    PRIMARY KEY (`runoob_id`)
) engine = InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;

-- 插入数据到 runoob_tbl
INSERT INTO runoob_tbl (runoob_id, runoob_title, runoob_author, submission_date) 
VALUES
(1, '学习 PHP', '菜鸟教程', '2017-04-12'),
(2, '学习 MySQL', '菜鸟教程', '2017-04-12'),
(3, '学习 Java', 'RUNOOB.COM', '2015-05-01'),
(4, '学习 Python', 'RUNOOB.COM', '2016-03-06'),
(5, '学习 C', 'FK', '2017-04-05');

-- 查询 runoob_tbl 数据
SELECT * FROM runoob_tbl;


-- INNER JOIN
-- SELECT column1, column2, ...
-- FROM table1
-- INNER JOIN table2 ON table1.column_name = table2.column_name;
-- 

-- 1. 简单 INNER JOIN
SELECT tcount_tbl.runoob_author, tcount_tbl.runoob_count, 
       runoob_tbl.runoob_id, runoob_tbl.runoob_title, 
       runoob_tbl.submission_date
FROM tcount_tbl
INNER JOIN runoob_tbl ON tcount_tbl.runoob_author = runoob_tbl.runoob_author;

-- 2. 使用别名
SELECT ct.runoob_author, ct.runoob_count, 
       tbl.runoob_id, tbl.runoob_title, 
       tbl.submission_date
FROM tcount_tbl AS ct
INNER JOIN runoob_tbl AS tbl ON ct.runoob_author = tbl.runoob_author;

-- 3. 等价语句
SELECT ct.runoob_author, ct.runoob_count, 
       tbl.runoob_id, tbl.runoob_title, 
       tbl.submission_date
FROM tcount_tbl AS ct, runoob_tbl AS tbl WHERE ct.runoob_author = tbl.runoob_author;

-- 4. WHERE 过滤：年份为偶数
SELECT ct.runoob_author, ct.runoob_count, 
       tbl.runoob_id, tbl.runoob_title, 
       tbl.submission_date
FROM tcount_tbl AS ct
INNER JOIN runoob_tbl AS tbl ON ct.runoob_author = tbl.runoob_author
WHERE MOD(YEAR(tbl.submission_date), 2) = 1;

-- LEFT JOIN 是一种常用的连接类型，尤其在需要返回左表中所有行的情况下。
-- 当右表中没有匹配的行时，相关列将显示为 NULL。
-- 在使用 LEFT JOIN 时，请确保理解连接条件并根据需求过滤结果。
-- MySQL left join 与 join 有所不同，LEFT JOIN 会读取左边数据表的全部数据，即使右边表无对应数据。

SELECT a.runoob_id, a.runoob_author, b.runoob_count
FROM runoob_tbl AS a
LEFT JOIN tcount_tbl AS b ON a.runoob_author = b.runoob_author;


-- RIGHT JOIN
SELECT a.runoob_id, b.runoob_author, b.runoob_count
FROM runoob_tbl AS a
RIGHT JOIN tcount_tbl AS b ON a.runoob_author = b.runoob_author;