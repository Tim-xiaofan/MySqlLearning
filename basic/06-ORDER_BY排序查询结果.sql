-- MySQL ORDER BY(排序) 语句可以按照一个或多个列的值进行升序（ASC）或降序（DESC）排序。

-- 语法
-- 以下是 SELECT 语句使用 ORDER BY 子句将查询数据排序后再返回数据：

-- SELECT column1, column2, ...
-- FROM table_name
-- ORDER BY column1 [ASC | DESC], column2 [ASC | DESC], ...;
-- 参数说明：

-- column1, column2, ... 是你要选择的列的名称，如果使用 * 表示选择所有列。
-- table_name 是你要从中查询数据的表的名称。
-- ORDER BY column1 [ASC | DESC], column2 [ASC | DESC], ... 是用于指定排序顺序的子句。ASC 表示升序（默认），DESC 表示降序。
-- 更多说明：

-- 你可以使用任何字段来作为排序的条件，从而返回排序后的查询结果。
-- 你可以设定多个字段来排序。
-- 你可以使用 ASC 或 DESC 关键字来设置查询结果是按升序或降序排列。 默认情况下，它是按升序排列。
-- 你可以添加 WHERE...LIKE 子句来设置条件。

-- 创建 runoob_tbl 表
CREATE TABLE IF NOT EXISTS runoob_tbl (
    runoob_id INT PRIMARY KEY,              -- 表的ID，主键
    runoob_title VARCHAR(100),              -- 标题
    runoob_author VARCHAR(100),             -- 作者
    submission_date DATE                    -- 提交日期
);

-- 插入示例数据
INSERT INTO runoob_tbl (runoob_id, runoob_title, runoob_author, submission_date) 
VALUES
(3, '学习 Java', 'RUNOOB.COM', '2015-05-01'),
(4, '学习 Python', 'RUNOOB.COM', '2016-03-06'),
(1, '学习 PHP', '菜鸟教程', '2017-04-12'),
(2, '学习 MySQL', '菜鸟教程', '2017-04-12');

SELECT * FROM runoob_tbl;

-- 1. 单列排序：按日期升序/降序排列
SELECT * FROM runoob_tbl
ORDER BY submission_date ASC;

SELECT * FROM runoob_tbl
ORDER BY submission_date DESC;

-- 2. 多列排列：按作者升序和提交日期降序排序
SELECT * FROM runoob_tbl
ORDER BY runoob_author ASC, submission_date DESC;

-- 3. 数字列排列：按作者（col-3）升序和提交日期（col-4）降序排序
SELECT * FROM runoob_tbl
ORDER BY 3 ASC, 4 DESC;

-- 4. 使用表达式排序
SELECT runoob_id, runoob_title, runoob_author, YEAR(submission_date) as submission_year FROM runoob_tbl
ORDER BY submission_year DESC;

DROP TABLE IF EXISTS runoob_tbl;