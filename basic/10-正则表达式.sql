-- REGEXP 是用于进行正则表达式匹配的运算符。

-- REGEXP 用于检查一个字符串是否匹配指定的正则表达式模式，以下是 REGEXP 运算符的基本语法：

-- SELECT column1, column2, ...
-- FROM table_name
-- WHERE column_name REGEXP 'pattern';

USE testdb;

DROP TABLE IF EXISTS person_tbl;
CREATE TABLE person_tbl (
    id int auto_increment PRIMARY KEY, -- 自增，主键
    name varchar(50) NOT NULL UNIQUE,
    email varchar(100) DEFAULT '',
    birthdate DATE,
    is_active boolean DEFAULT TRUE -- 默认值
) engine = InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
INSERT INTO
    person_tbl (name)
VALUES ('Steve'),
    ('Mike'),
    ('Stanley'),
    ('Stephen'),
    ('Stella'),
    ('Stuart');

INSERT INTO
    person_tbl (name)
VALUES ('Erok'),
    ('Barok'),
    ('Tarekok'),
    ('Zok');

INSERT INTO
    person_tbl (name)
VALUES ('Lamar'),
    ('Damaris'),
    ('Jomar'),
    ('Kamar'),
    ('Mark');

INSERT INTO
    person_tbl (name)
VALUES ('Ira'), -- 以元音 'I' 开头
    ('Oscar'), -- 以元音 'O' 开头
    ('Ulrik'); -- 以元音 'U' 开头

SELECT * FROM person_tbl;

-- 1. 查找 name 字段中以 'st' 为开头的所有数据
SELECT * FROM person_tbl
WHERE name REGEXP '^st';

-- 2. 查找 name 字段中以 'ok' 为结尾的所有数据
SELECT * FROM person_tbl
WHERE name REGEXP 'ok$';

-- 3. 查找 name 字段中包含 'mar' 的所有数据
SELECT * FROM person_tbl
WHERE name REGEXP 'mar';

-- 4. 查找 name 字段中以原因字母开头或'ok'结尾的所有数据
SELECT * FROM person_tbl
WHERE name REGEXP '^[aeiou]|ok$';

-- 5. 使用 BINARY 关键字区分大小写
SELECT * FROM person_tbl
WHERE CAST(name AS BINARY) REGEXP BINARY 'mar';