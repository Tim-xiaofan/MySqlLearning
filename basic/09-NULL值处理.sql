DROP TABLE IF EXISTS runoob_test_tbl;
CREATE TABLE runoob_test_tbl (
    runoob_author varchar(40) NOT NULL,
    runoob_count INT
) engine = InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci ;

INSERT INTO runoob_test_tbl (runoob_author, runoob_count)
VALUES ('RUNOOB', 20), ('菜鸟教程', NULL), ('Google', NULL), ('FK', 2);

SELECT * FROM runoob_test_tbl;


-- 1. IS NULL / IS NOT NULL 检查是否为 NULL
SELECT * FROM runoob_test_tbl
WHERE runoob_count IS NULL;

SELECT * FROM runoob_test_tbl
WHERE runoob_count IS NOT NULL;

-- 2. 使用 COALESCE 函数处理 NULL：
-- COALESCE 函数可以用于替换为 NULL 的值，它接受多个参数，返回参数列表中的第一个非 NULL 值：
SELECT runoob_author, COALESCE(runoob_count, 0) -- 如果是 NULL，用 0 替代
FROM runoob_test_tbl;

-- 3. 使用 IFNULL 函数处理 NULL：
-- IFNULL 函数是 COALESCE 的 MySQL 特定版本，它接受两个参数，如果第一个参数为 NULL，则返回第二个参数。
SELECT runoob_author, IFNULL(runoob_count, 0) -- 如果是 NULL，用 0 替代
FROM runoob_test_tbl;

-- 4. NULL 排序：
-- 如果希望将 NULL 值放在最前面，可以使用 ORDER BY column_name ASC NULLS FIRST，反之使用 ORDER BY column_name DESC NULLS LAST。
SELECT * FROM runoob_test_tbl
ORDER BY runoob_count ASC;

SELECT * FROM runoob_test_tbl
ORDER BY runoob_count DESC;

SELECT * FROM runoob_test_tbl
ORDER BY runoob_count ASC NULLS FIRST;

SELECT * FROM runoob_test_tbl
ORDER BY runoob_count DESC NULLS LAST;

-- 5. 使用 <=> 操作符进行 NULL 比较：
-- <=> 操作符是 MySQL 中用于比较两个表达式是否相等的特殊操作符，
-- 对于 NULL 值的比较也会返回 TRUE。它可以用于处理 NULL 值的等值比较。
SELECT * FROM runoob_test_tbl
WHERE runoob_count <=> NULL;

-- 6. 注意聚合函数对 NULL 的处理
SELECT AVG(runoob_count)
FROM runoob_test_tbl; -- 11.0，NULL 行不处理，也不计数总数

SELECT AVG(COALESCE(runoob_count, 0))
FROM runoob_test_tbl; -- 5.5