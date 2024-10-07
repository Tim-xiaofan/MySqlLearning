-- 语法
-- 以下是 UPDATE 命令修改 MySQL 数据表数据的通用 SQL 语法：
--  UPDATE table_name
--  SET column1 = value1, column2 = value2, ...
--  WHERE condition;

-- 参数说明：
--  table_name 是你要更新数据的表的名称。
--  column1, column2, ... 是你要更新的列的名称。
--  value1, value2, ... 是新的值，用于替换旧的值。
--  WHERE condition 是一个可选的子句，用于指定更新的行。如果省略 WHERE 子句，将更新表中的所有行。

-- 更多说明：
--  你可以同时更新一个或多个字段。
--  你可以在 WHERE 子句中指定任何条件。
--  你可以在一个单独表中同时更新数据。
--  当你需要更新数据表中指定行的数据时 WHERE 子句是非常有用的。

USE testdb;

-- 准备数据

CREATE TABLE IF NOT EXISTS users (
    id int auto_increment PRIMARY KEY, -- 自增，主键
    username varchar(50) NOT NULL, -- 非空
    email varchar(100),
    birthdate DATE DEFAULT(CURRENT_DATE),
    age INT DEFAULT(-1),
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

SELECT * from users;


-- 更新单个列的值
SELECT birthdate FROM users
WHERE username = 'alice';

UPDATE users SET birthdate = '1990-1-21'
WHERE username = 'alice';

-- 更新多个列的值
SELECT id, username, email, birthdate, is_active FROM users
WHERE birthdate IS NULL;

UPDATE users SET email='', is_active=FALSE
WHERE birthdate IS NULL;

-- 使用表达式更新值
SELECT id, username, age, is_active FROM users
WHERE is_active = TRUE AND birthdate IS NOT NULL;

UPDATE users SET age = TIMESTAMPDIFF(YEAR, birthdate, NOW()) 
WHERE is_active = TRUE AND birthdate IS NOT NULL;

DROP TABLE IF EXISTS users;



-- 一些测试
SELECT NOW();
SELECT DATE(NOW());
SELECT TIMESTAMPDIFF(YEAR, '2024-6-1', '2025-3-1');
SELECT TIMESTAMPDIFF(YEAR, '2024-6-1', '2025-6-1');
SELECT TIMESTAMPDIFF(YEAR, '2024-6-1', '2025-5-31');