-- 在 MySQL 中，序列是一种自增生成数字序列的对象，是一组整数 1、2、3、...，由于一张数据表只能有一个字段自增主键。

DROP DATABASE IF EXISTS `testdb`;
CREATE DATABASE `testdb`;
USE `testdb`;

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
    `id` INT AUTO_INCREMENT PRIMARY KEY, -- 自增，主键
    `username` varchar(50) NOT NULL, -- 非空
    `email` varchar(100),
    `birthdate` DATE DEFAULT(CURRENT_DATE),
    `age` INT DEFAULT(-1),
    `is_active` boolean DEFAULT TRUE -- 默认值
);
DESC `users`;

-- 1. 不指定，插入时自动分配
INSERT INTO `users` (`username`, `email`, `birthdate`, `is_active`) 
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

SELECT * from `users`;

# 2. 获取刚刚插入行的自增值
SELECT LAST_INSERT_ID();

# 3. 获取表的自增值
SHOW TABLE STATUS LIKE 'users';

-- 请注意，使用 AUTO_INCREMENT 属性的列只能是整数类型（通常是 INT 或 BIGINT）。
-- 此外，如果你删除表中的某一行，其自增值不会被重新使用，而是会继续递增。
-- 如果你希望手动设置自增值，可以使用 SET 语句，但这不是一种常规的做法，因为可能引起唯一性冲突。