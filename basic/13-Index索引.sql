-- MySQL 索引是一种数据结构，用于加快数据库查询的速度和性能。

DROP DATABASE IF EXISTS `testdb`;
CREATE DATABASE `testdb`;
USE `testdb`;

DROP TABLE IF EXISTS `students`;
CREATE TABLE `students` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `name` VARCHAR(50) NOT NULL,
  `age` INT,
  INDEX `idx_age` (`age`) --  创建表时指定索引
)engine=InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;

DESC `students`;

-- 1. 显示索引信息
SHOW INDEX FROM `students`;

-- 2. 使用 DROP INDEX 语句删除索引
DROP INDEX `idx_age` ON `students`;

-- 3. 使用 ALTER TABLE ... DROP INDEX 语句删除索引
ALTER TABLE `students`
DROP INDEX `idx_age`;

-- 4. 使用 CREATE INDEX 语句创建索引
CREATE INDEX `idx_age`
ON `students` (`age`);

-- 5. 使用 ALTER TABLE ... ADD INDEX idx_name (col [ASC|DESC], ...)语句创建索引
ALTER TABLE `students`
ADD INDEX `idx_age` (`age` DESC);

-- 唯一索引
-- 在 MySQL 中，你可以使用 CREATE UNIQUE INDEX 语句来创建唯一索引。
-- 唯一索引确保索引中的值是唯一的，不允许有重复值

DROP TABLE IF EXISTS `employees`;
CREATE TABLE `employees` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(255) NOT NULL,
    `salary` DECIMAL(10, 2) DEFAULT 0,
    `email`  VARCHAR(255),
    CONSTRAINT `idx_email` UNIQUE (`email`) -- 建表的时候直接指定唯一索引
)engine=InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;

DESC `employees`;

SHOW INDEX FROM `employees`;

DROP INDEX `idx_email` ON `employees`;

-- 1. 使用 CREATE UNIQUE INDEX 创建唯一索引：此语句会给对应列加上 UNIQUE 约束
CREATE UNIQUE INDEX `idx_email`
ON `employees` (`email`);

-- 2. 使用 ALTER TABLE ... ADD CONSTRAINT idx_name UNIQUE (col [ASC|DESC], ...) 语句创建索引
ALTER TABLE `employees`
ADD CONSTRAINT `idx_email` UNIQUE (`email`);