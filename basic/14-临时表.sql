-- 临时表只在当前连接可见，当关闭连接时，MySQL 会自动删除表并释放所有空间
-- 临时表对于需要在某个会话中存储中间结果集或进行复杂查询时非常有用。
-- 对MySQL临时表的支持从MySQL服务器3.2版及以上开始

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

DROP TABLE IF EXISTS `active_users`;

-- 1. 创建临时表
CREATE TEMPORARY TABLE `active_users` AS
SELECT * FROM `users`
WHERE `is_active` = TRUE;

-- 2. SHOW TABLES 无法显示临时表
SHOW TABLES;

-- 3. DESC 可以显示表信息
DESC `active_users`;

-- 4. 从临时表中查询数据
SELECT * FROM `active_users`
WHERE `birthdate` >= '2000-01-01';

-- 5. 插入数据到临时表（不影响原表）
INSERT INTO `active_users` (`username`, `email`, `birthdate`, `is_active`)
VALUES
('jerry', 'tom@example.com', '1947-10-17', TRUE);

SELECT * FROM `users` 
WHERE `username` = 'jerry'; 

SELECT * FROM `active_users` 
WHERE `username` = 'jerry';

-- 6. 从临时表中删除数据 （不影响原表）
DELETE FROM `active_users` 
WHERE `username` = 'tom';

SELECT * FROM `users` 
WHERE `username` = 'tom'; 

SELECT * FROM `active_users` 
WHERE `username` = 'tom';

-- 7. 修改临时表
-- 临时表的修改操作与普通表类似，可以使用 ALTER TABLE 命令
ALTER TABLE `active_users`
MODIFY `username` VARCHAR(255);

-- 8. 为临时表创建索引
ALTER TABLE `active_users`
ADD INDEX `age_idx` (`age` ASC);

-- 9. 显示临时表索引
SHOW INDEX FROM `active_users`;

-- 10. 删除临时表
-- 临时表在会话结束时会自动被销毁，但你也可以使用 DROP TABLE 明确删除它。
DROP TABLE `active_users`;
DROP TABLE `ausers`;

-- 11. 重命名临时表
ALTER TABLE `active_users`
RENAME `ausers`;

DESC `ausers`;