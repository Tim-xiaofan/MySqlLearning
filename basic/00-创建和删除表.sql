-- Active: 1728024695726@@127.0.0.1@13306@testdb
SELECT VERSION();
-- 查看数据库版本
SHOW DATABASES;

USE testdb;

-- 建表
-- CREATE TABLE table_name (
--     column1 datatype,
--     column2 datatype,
--     ...
-- );

CREATE TABLE IF NOT EXISTS users (
    id int auto_increment PRIMARY KEY, -- 自增，主键
    username varchar(50) NOT NULL,
    email varchar(100),
    birthdate DATE,
    is_active boolean DEFAULT TRUE -- 默认值
);

SHOW TABLES;

DESC users;
/* 指定数据引擎（默认值为 InnoDB），字符集和排序规则 */
CREATE TABLE IF NOT EXISTS runoob_tbl (
    runoob_id int UNSIGNED auto_increment,
    runoob_title varchar(100) NOT NULL,
    runoob_author varchar(40) NOT NULL,
    submission_date DATE default(CURRENT_DATE),
    PRIMARY KEY (runoob_id)
) engine = InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;

-- 查看支持的引擎
SHOW ENGINES

SHOW TABLES;

DESC runoob_tbl;

DROP TABLE IF EXISTS runoob_tbl;

-- 表不存在会报错
DROP TABLE users;