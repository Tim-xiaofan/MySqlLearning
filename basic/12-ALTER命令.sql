-- ALTER 命令允许你添加、修改或删除数据库对象，并且可以用于更改表的列定义、添加约束、创建和删除索引等操作。
DROP DATABASE IF EXISTS `testdb`;
CREATE DATABASE `testdb`;
USE `testdb`;

DROP TABLE IF EXISTS `employees`;
CREATE TABLE `employees` (
    employee_id INT UNIQUE NOT NULL,
    name VARCHAR(255) NOT NULL,
    salary FLOAT DEFAULT 0
)engine = InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
DESC `employees`;

DROP TABLE IF EXISTS `card`;
CREATE TABLE  `card` (
    name VARCHAR(255),
    employee_id INT UNIQUE NOT NULL
) engine = InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
DESC `card`;

-- 1.添加列：默认作为最后一列
ALTER TABLE `employees`
ADD COLUMN `birthdate` DATE DEFAULT(CURRENT_DATE);
-- 1.1 指定插入位置：在 name 列之后
ALTER TABLE `employees`
ADD COLUMN `birthdate` DATE DEFAULT(CURRENT_DATE) AFTER `name`;

-- 2. 修改数据类型
ALTER TABLE `employees`
MODIFY COLUMN `salary` DECIMAL(10, 2); -- 十进制两位小数

-- 3. 修改列名
ALTER TABLE `employees`
CHANGE COLUMN `birthdate` `birth` DATE  DEFAULT(CURRENT_DATE);

-- 4. 删除列
ALTER TABLE `employees`
DROP COLUMN `birth`;

-- 5. 添加主键 PRIMARY KEY
ALTER TABLE `employees`
ADD PRIMARY KEY(`employee_id`);

-- 6. 添加外键 FOREIGN KEY
ALTER TABLE `card`
ADD CONSTRAINT `fk_employee`
FOREIGN KEY(`employee_id`)
REFERENCES employees(`employee_id`);

-- 7. 修改表名
ALTER TABLE `employees`
RENAME TO `staff`;
DESC `staff`;

DROP TABLE `staff`;

-- 6. 修改类 NULL 值和默认值
ALTER TABLE `card`
MODIFY `name` VARCHAR(255) NOT NULL DEFAULT '';