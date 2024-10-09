
-- 如果我们需要完全的复制 MySQL 的数据表，包括表的结构，索引，默认值等。
-- 如果仅仅使用 CREATE TABLE ... SELECT 命令，是无法实现的


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
    `is_active` BOOLEAN DEFAULT TRUE  -- 默认值
);

ALTER TABLE `users`
ADD CONSTRAINT `email_idx` UNIQUE (`email`);

DESC `users`;
SHOW INDEX FROM `users`;

-- 插入更多测试数据
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

-- 一、只复制表结构到新表
-- 1. 使用 CREATE TABLE ... SELECT 语句复制的表不完整
DROP TABLE IF EXISTS `users_copy`;

CREATE TABLE `users_copy`
SELECT * FROM `users`
WHERE FALSE; 

DESC `users_copy`; -- 丢失了主键
SHOW INDEX FROM `users_copy`; -- 丢失了索引

SELECT * FROM `users_copy`;

-- 2. 正确方式1：使用 SHOW CREATE TABLE 获取建表语句(手动复制)
SHOW CREATE TABLE `users`\G;

-- CREATE TABLE `users` (
--   `id` int NOT NULL AUTO_INCREMENT,
--   `username` varchar(50) NOT NULL,
--   `email` varchar(100) DEFAULT NULL,
--   `birthdate` date DEFAULT (curdate()),
--   `age` int DEFAULT (-(1)),
--   `is_active` tinyint(1) DEFAULT '1',
--   PRIMARY KEY (`id`),
--   UNIQUE KEY `email_idx` (`email`)
-- ) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci

CREATE TABLE `users_copy` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `birthdate` date DEFAULT (curdate()),
  `age` int DEFAULT (-(1)),
  `is_active` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `email_idx` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- 正确方式2：CREATE TABLE targetTable LIKE sourceTable （自动）
CREATE TABLE `users_copy` LIKE `users`;

-- 二、如果你想复制表的内容，你就可以使用 INSERT INTO ... SELECT 语句来实现。
INSERT INTO `users_copy` 
SELECT * FROM `users`;

SHOW TABLES;