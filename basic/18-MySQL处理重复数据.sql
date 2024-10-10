DROP DATABASE IF EXISTS `testdb`;
CREATE DATABASE `testdb`;
USE `testdb`;

-- 一、 防止出现重复数据
-- 方法1. 双主键模式

DROP TABLE IF EXISTS `person_tbl`;
CREATE TABLE `person_tbl`(
    `first_name` VARCHAR(255) NOT NULL,
    `last_name` VARCHAR(255) NOT NULL,
    `sex` BOOLEAN DEFAULT TRUE,
    PRIMARY KEY(`first_name`, `last_name`)
)ENGINE=InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;

INSERT INTO `person_tbl` (`first_name`, `last_name`)
VALUES ('Jay', 'Thomas');

INSERT INTO `person_tbl` (`first_name`, `last_name`)
VALUES ('Jay', 'Thomas'); -- Error: Duplicate entry 'Jay-Thomas' for key 'person_tbl.PRIMARY'

-- 方法2. 设置唯一索引

DROP TABLE IF EXISTS `person_tbl`;
CREATE TABLE `person_tbl`(
    `first_name` VARCHAR(255) NOT NULL,
    `last_name` VARCHAR(255) NOT NULL,
    `sex` BOOLEAN DEFAULT TRUE,
    CONSTRAINT `full_name_idx` UNIQUE (`first_name`, `last_name`)
)ENGINE=InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;

INSERT INTO `person_tbl` (`first_name`, `last_name`)
VALUES ('Jay', 'Thomas');

INSERT INTO `person_tbl` (`first_name`, `last_name`)
VALUES ('Jay', 'Thomas'); -- Error: Duplicate entry 'Jay-Thomas' for key 'person_tbl.full_name_idx'


-- 二、统计重复数据
DROP TABLE IF EXISTS `person_tbl`;
CREATE TABLE `person_tbl`(
    `first_name` VARCHAR(255) NOT NULL,
    `last_name` VARCHAR(255) NOT NULL,
    `sex` BOOLEAN DEFAULT TRUE
)ENGINE=InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;

INSERT INTO `person_tbl` (`first_name`, `last_name`, `sex`)
VALUES 
('Jay', 'Thomas', TRUE),
('Jay', 'Thomas', FALSE),
('Jay', 'Thomas', TRUE),
('Jerry', 'Thomas', TRUE),
('Spike', 'Thomas', FALSE),
('Spike', 'Thomas', TRUE);
SELECT * FROM `person_tbl`;

SELECT COUNT(*) as `reptitions`, `first_name`, `last_name`
FROM `person_tbl` 
GROUP BY `first_name`, `last_name`
HAVING `reptitions` > 1;


-- 三、过滤重复数据
-- 1. 可以在 SELECT 语句中使用 DISTINCT 关键字来过滤重复数据（查询结果不重复）
SELECT DISTINCT `first_name`, `last_name`
FROM `person_tbl`;

SELECT COUNT(*) as `reptitions`, `first_name`, `last_name`
FROM `person_tbl` 
GROUP BY `first_name`, `last_name`
HAVING `reptitions` = 1;