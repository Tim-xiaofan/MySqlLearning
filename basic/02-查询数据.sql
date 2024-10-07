USE testdb;

-- 准备数据

CREATE TABLE IF NOT EXISTS users (
    id int auto_increment PRIMARY KEY, -- 自增，主键
    username varchar(50) NOT NULL, -- 非空
    email varchar(100),
    birthdate DATE DEFAULT(CURRENT_DATE),
    is_active boolean DEFAULT TRUE -- 默认值
);
DESC users;

-- 插入更多测试数据
INSERT INTO users (username, email, birthdate, is_active) 
VALUES
('alice', 'alice@example.com', '1990-01-01', TRUE),
('bob', 'bob@example.com', '1985-05-15', FALSE),
('charlie', 'charlie@example.com', NULL, TRUE), -- 没有提供birthdate，默认今天
('dave', NULL, '2000-07-21', TRUE), -- 没有提供email，允许为空
('eve', 'eve@example.com', '1995-10-10', FALSE),
('frank', 'frank@example.com', '1988-03-02', TRUE),
('grace', 'grace@example.com', '1992-11-11', TRUE),
('hannah', 'hannah@example.com', '1997-06-25', FALSE),
('ivan', 'ivan@example.com', '1980-08-12', TRUE),
('judy', 'judy@example.com', '2002-04-30', TRUE),
('karen', 'karen@example.com', '1991-09-15', FALSE),
('leo', NULL, '1986-12-09', TRUE),
('mike', 'mike@example.com', NULL, TRUE), -- 默认今天的日期
('nina', 'nina@example.com', '1995-05-05', FALSE),
('oscar', NULL, '1998-12-30', TRUE),
('paul', 'paul@example.com', '1994-02-28', TRUE),
('quincy', 'quincy@example.com', '1983-07-07', FALSE),
('rachel', 'rachel@example.com', '1987-01-21', TRUE),
('steve', 'steve@example.com', '1999-08-08', TRUE),
('tom', NULL, '2001-02-02', FALSE),
('ursula', 'ursula@example.com', '1990-10-10', TRUE),
('victor', 'victor@example.com', '1996-03-20', TRUE),
('wendy', 'wendy@example.com', '1989-06-18', FALSE),
('xavier', 'xavier@example.com', '1993-09-09', TRUE),
('yvonne', NULL, '1981-11-11', TRUE),
('zack', 'zack@example.com', '2003-07-04', TRUE);

-- 查询以确认数据插入
SELECT * FROM users;

-- -- 语法
-- 以下为在 MySQL 数据库中查询数据通用的 SELECT 语法：

-- SELECT column1, column2, ...
-- FROM table_name
-- [WHERE condition]
-- [ORDER BY column_name [ASC | DESC]]
-- [LIMIT number];

-- 参数说明：
--      column1, column2, ... 是你想要选择的列的名称，如果使用 * 表示选择所有列。
--      table_name 是你要从中查询数据的表的名称。
--      WHERE condition 是一个可选的子句，用于指定过滤条件，只返回符合条件的行。
--      ORDER BY column_name [ASC | DESC] 是一个可选的子句，用于指定结果集的排序顺序，默认是升序（ASC）。
--      LIMIT number 是一个可选的子句，用于限制返回的行数。

-- 选择特定列的所有行
SELECT username, email FROM users;

-- 添加 WHERE 子句，选择满足条件的行
SELECT * FROM users WHERE is_active = TRUE;

-- 添加 ORDER BY 子句，按照某列的升序（ASCEND）排序
SELECT id, username, birthdate
FROM users
WHERE birthdate IS NOT NULL
ORDER BY birthdate
LIMIT 10; -- 限制虽多返回 10 行
-- 降序
SELECT id, username, birthdate
FROM users
ORDER BY birthdate DESC
LIMIT 100;

-- 使用 AND 运算符和通配符：名字j字母开头且活着的人
SELECT * FROM users 
WHERE username LIKE 'j%' AND is_active = TRUE;

-- 使用 OR 运算符：活着的或1990-1-1之前出生的
SELECT * FROM users
WHERE is_active OR birthdate < '1990-1-1';

-- 使用 IN 子句：出生日期在集合 ('1990-1-1', '1985-05-15', '1933-10-10')中的
SELECT id, username, birthdate FROM users
WHERE birthdate IN ('1990-1-1', '1985-05-15', '1933-10-10');

-- 使用 IS NOT NULL 条件
SELECT id, username, birthdate FROM users
WHERE birthdate IS NOT NULL;

-- 使用 IS NULL 条件
SELECT id, username, birthdate FROM users
WHERE birthdate IS NULL;

-- 使用 BETWEEN 子句：查询2000年到2010出生的人
SELECT id, username, birthdate FROM users
WHERE birthdate BETWEEN '2000-1-1' AND '2010-12-13';

-- MONTH 函数，提取日期中的月份：统计夏季出生的人
SELECT id, username, birthdate FROM users
WHERE MONTH(birthdate) BETWEEN 6 AND 8;

-- 限制范围查询
SELECT id, username FROM users
LIMIT 20, 4; -- 21 到 24 行

DROP TABLE IF EXISTS users;