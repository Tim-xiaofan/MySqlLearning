# MySQL 导出数据

## 准备数据
```sql
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
```

# 一、 使用 SELECT...INTO OUTFILE 语句导出
MySQL 中你可以使用 SELECT...INTO OUTFILE 语句来简单的导出数据到文本文件上。
> **注意**：需要相应的权限，在 MySQL 服务器命令上执行


## 1.1 导出
查看可以导出导出文件的位置
- `secure_file_priv` 为 NULL 时，表示限制mysqld不允许导入或导出。
- `secure_file_priv` 为 /tmp 时，表示限制mysqld只能在/tmp目录中执行导入导出，其他目录不能执行。
- `secure_file_priv` 没有值时，表示不限制mysqld在任意目录的导入导出。
```sql
SHOW GLOBAL VARIABLES LIKE '%secure_file_priv%';
```

```bash
mysql> SHOW GLOBAL VARIABLES LIKE '%secure_file_priv%';;
+------------------+-----------------------+
| Variable_name    | Value                 |
+------------------+-----------------------+
| secure_file_priv | /var/lib/mysql-files/ |
+------------------+-----------------------+
1 row in set (0.01 sec)
```

```sql
-- 一、 使用 SELECT ... INTO OUTFILE 语句导出数据（在 MySQL 服务器上，命令行执行）
SELECT * 
INTO OUTFILE '/var/lib/mysql-files//users.csv'
FIELDS TERMINATED BY ',' -- 指定行内元素分隔符（默认是使用空白字符）
LINES TERMINATED BY '\n' -- 执行换行符
FROM `users`;
```

## 1.2 查看结果

```bash
$ sudo cat /var/lib/mysql-files//users.csv  # 查看导出的文件
1,alice,alice@example.com,1990-01-01,-1,1
2,bob,bob@example.com,1985-05-15,-1,0
3,charlie,charlie@example.com,\N,-1,1
4,dave,\N,2000-07-21,-1,1
5,eve,eve@example.com,1995-10-10,-1,0
6,frank,frank@example.com,1988-03-02,-1,1
7,grace,grace@example.com,1992-11-11,-1,1
8,hannah,hannah@example.com,1997-06-25,-1,0
9,ivan,ivan@example.com,1980-08-12,-1,1
10,judy,judy@example.com,2002-04-30,-1,1
11,karen,karen@example.com,1991-09-15,-1,0
12,leo,\N,1986-12-09,-1,1
13,mike,mike@example.com,\N,-1,1
14,nina,nina@example.com,1995-05-05,-1,0
15,oscar,\N,1998-12-30,-1,1
16,paul,paul@example.com,1994-02-28,-1,1
17,quincy,quincy@example.com,1983-07-07,-1,0
18,rachel,rachel@example.com,1987-01-21,-1,1
19,steve,steve@example.com,1999-08-08,-1,1
20,tom,\N,2001-02-02,-1,0
21,ursula,ursula@example.com,1990-10-10,-1,1
22,victor,victor@example.com,1996-03-20,-1,1
23,wendy,wendy@example.com,1989-06-18,-1,0
24,xavier,xavier@example.com,1993-09-09,-1,1
25,yvonne,\N,1981-11-11,-1,1
26,zack,zack@example.com,2003-07-04,-1,1
```

# 二、使用 mysqldump 工具导出
## 1.1 导出特定数据库
```bash
$ sudo mysqldump -u root -p testdb > testdb_backup.sql
```

## 2.2 导出特定表
```bash
$ sudo mysqldump -u root -p testdb users > userstbl_backup.sql
$ cat userstbl_backup.sql 
```
## 2.3 只导出数据库结构
```bash
$ sudo mysqldump -u root -p --no-data testdb > testdb_nodata_backup.sql
```

## 2.4 导出所有数据库
```bash
$ sudo mysqldump -u root -p --all-databases > databases.sql
```