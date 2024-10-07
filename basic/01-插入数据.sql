
-- 插入语句基本格式
-- INSERT INTO table_name (column1, column2, column3, ...)
-- VALUES (value1, value2, value3, ...), (...), ...;
-- 参数说明：

-- table_name 是你要插入数据的表的名称。
-- column1, column2, column3, ... 是表中的列名。
-- value1, value2, value3, ... 是要插入的具体数值。

USE testdb;


CREATE TABLE IF NOT EXISTS users (
    id int auto_increment PRIMARY KEY, -- 自增，主键
    username varchar(50) NOT NULL, -- 非空
    email varchar(100),
    birthdate DATE DEFAULT(CURRENT_DATE),
    is_active boolean DEFAULT TRUE -- 默认值
);
DESC users;

-- 插入数据
INSERT INTO users (username) VALUES ('u1');
INSERT INTO users (id, username, email, birthdate, is_active) 
VALUES (NULL, 'u2', 'u2@example', '1927-10-18', false);
-- 插入多条数据
INSERT INTO users (username) VALUES ('u3'), ('u4');
-- 插入每一列时可以不规定列
INSERT INTO users VALUES (5, 'u5', 'u5@example', '1957-8-11', true);
-- 不满足主键的约束（重复）失败
INSERT INTO users VALUES (5, 'u6', 'u6@example', '1976-4-1', true);

-- 造成 id 空洞 （id=7）
INSERT INTO users VALUES (8, 'u6', 'u6@example', '1976-4-1', true);
INSERT INTO users (username) VALUES ('u7');

SELECT * from users;

DROP TABLE IF EXISTS users;