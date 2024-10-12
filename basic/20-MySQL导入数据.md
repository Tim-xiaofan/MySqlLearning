# MySQL 导入数据
本文介绍将文件导入数据库的四种方式：
- mysql 命令
- source 命令
- LOAD DATA 语句
- mysqlimport 命令

# 方式1：mysql 命令导入
使用 mysql 命令导入语法格式为：

```bash
mysql -u your_username -p -h your_host -P your_port -D your_database
```

your_username、your_host、your_port、your_database 分别为你的 MySQL 用户名、主机、端口和数据库。

**实例**: 向数据库 `testdb` 导入 `user` 表
>在 MySQL 服务器终端运行以下命令，'testdb_backup.sql' 文件内容参考附录 A.1：

```bash
sudo mysql -uroot -p -D testdb < testdb_backup.sql
```
**注意**
- 需保证 `testdb` 数据库已存在
- 脚本将删除原来 `users` 表，加载脚本中的数据：若此表已存在存在，现在表中数据将丢失


# 方式2：source 命令
> 你可以在 MySQL 命令行中直接执行，而无需退出 MySQL 并使用其他命令

**实例**：向数据库 `testdb` 导入 `user` 表
```bash
mysql> select * from users;
ERROR 1146 (42S02): Table 'testdb.users' does not exist
mysql> source ./testdb_backup.sql
Query OK, 0 rows affected (0.00 sec)
....

mysql> select * from users;
+----+----------+---------------------+------------+------+-----------+
| id | username | email               | birthdate  | age  | is_active |
+----+----------+---------------------+------------+------+-----------+
|  1 | alice    | alice@example.com   | 1990-01-01 |   -1 |         1 |
|  2 | bob      | bob@example.com     | 1985-05-15 |   -1 |         0 |
|  3 | charlie  | charlie@example.com | NULL       |   -1 |         1 |
|  4 | dave     | NULL                | 2000-07-21 |   -1 |         1 |
|  5 | eve      | eve@example.com     | 1995-10-10 |   -1 |         0 |
|  6 | frank    | frank@example.com   | 1988-03-02 |   -1 |         1 |
|  7 | grace    | grace@example.com   | 1992-11-11 |   -1 |         1 |
|  8 | hannah   | hannah@example.com  | 1997-06-25 |   -1 |         0 |
|  9 | ivan     | ivan@example.com    | 1980-08-12 |   -1 |         1 |
| 10 | judy     | judy@example.com    | 2002-04-30 |   -1 |         1 |
| 11 | karen    | karen@example.com   | 1991-09-15 |   -1 |         0 |
| 12 | leo      | NULL                | 1986-12-09 |   -1 |         1 |
| 13 | mike     | mike@example.com    | NULL       |   -1 |         1 |
| 14 | nina     | nina@example.com    | 1995-05-05 |   -1 |         0 |
| 15 | oscar    | NULL                | 1998-12-30 |   -1 |         1 |
| 16 | paul     | paul@example.com    | 1994-02-28 |   -1 |         1 |
| 17 | quincy   | quincy@example.com  | 1983-07-07 |   -1 |         0 |
| 18 | rachel   | rachel@example.com  | 1987-01-21 |   -1 |         1 |
| 19 | steve    | steve@example.com   | 1999-08-08 |   -1 |         1 |
| 20 | tom      | NULL                | 2001-02-02 |   -1 |         0 |
| 21 | ursula   | ursula@example.com  | 1990-10-10 |   -1 |         1 |
| 22 | victor   | victor@example.com  | 1996-03-20 |   -1 |         1 |
| 23 | wendy    | wendy@example.com   | 1989-06-18 |   -1 |         0 |
| 24 | xavier   | xavier@example.com  | 1993-09-09 |   -1 |         1 |
| 25 | yvonne   | NULL                | 1981-11-11 |   -1 |         1 |
| 26 | zack     | zack@example.com    | 2003-07-04 |   -1 |         1 |
+----+----------+---------------------+------------+------+-----------+
26 rows in set (0.00 sec)
```

# 方式3：使用 LOAD DATA 导入数据
```bash
mysql> LOAD DATA LOCAL INFILE 'dump.txt' INTO TABLE mytbl;

# 如果数据文件中的列与插入表中的列不一致，则需要指定列的顺序
mysql> LOAD DATA LOCAL INFILE 'dump.txt' 
    -> INTO TABLE mytbl (b, c, a);
```
- 如果指定`LOCAL`关键词，则表明从客户主机上按路径读取文件。如果没有指定，则文件在服务器上按路径读取文件。
- 无论是服务端还是客户端都需要开启权限，在 `8.0.39`版本，默认是禁用了此功能(`OFF`状态)。

无权限会有如下错误：
```bash
mysql> load data local infile 'testdb_backup.sql' into table `users`;
ERROR 3948 (42000): Loading local data is disabled; this must be enabled on both the client and server sides
```
##  开启 local_infile 权限 [1]
1. 设置全局变量
```bash
mysql> SET GLOBAL local_infile=1;
Query OK, 0 rows affected (0.00 sec)

mysql> SHOW GLOBAL VARIABLES LIKE 'local_infile';
+---------------+-------+
| Variable_name | Value |
+---------------+-------+
| local_infile  | ON    |
+---------------+-------+
1 row in set (0.00 sec)
```

2. 推出连接
```bash
mysql> quit;
Bye
```

3. 连接服务器时，附带 `local-infile` 参数
```bash
$ sudo mysql -uroot -p -D testdb --local-infile=1
```

**实例**：向数据库 `testdb` 导入 `user` 表
- 要求表已经存在
- /var/lib/mysql-files/users.csv 文件内容参考附录 A.2
```bash
mysql> load data local infile '/var/lib/mysql-files/users.csv' into table `users`  fields terminated by ',' optionally enclosed by '"' lines terminated by '\n';
Query OK, 26 rows affected (0.01 sec)
Records: 26  Deleted: 0  Skipped: 0  Warnings: 0

mysql> select * from users;
+----+----------+---------------------+------------+------+-----------+
| id | username | email               | birthdate  | age  | is_active |
+----+----------+---------------------+------------+------+-----------+
|  1 | alice    | alice@example.com   | 1990-01-01 |   -1 |         1 |
|  2 | bob      | bob@example.com     | 1985-05-15 |   -1 |         0 |
|  3 | charlie  | charlie@example.com | NULL       |   -1 |         1 |
|  4 | dave     | NULL                | 2000-07-21 |   -1 |         1 |
|  5 | eve      | eve@example.com     | 1995-10-10 |   -1 |         0 |
|  6 | frank    | frank@example.com   | 1988-03-02 |   -1 |         1 |
|  7 | grace    | grace@example.com   | 1992-11-11 |   -1 |         1 |
|  8 | hannah   | hannah@example.com  | 1997-06-25 |   -1 |         0 |
|  9 | ivan     | ivan@example.com    | 1980-08-12 |   -1 |         1 |
| 10 | judy     | judy@example.com    | 2002-04-30 |   -1 |         1 |
| 11 | karen    | karen@example.com   | 1991-09-15 |   -1 |         0 |
| 12 | leo      | NULL                | 1986-12-09 |   -1 |         1 |
| 13 | mike     | mike@example.com    | NULL       |   -1 |         1 |
| 14 | nina     | nina@example.com    | 1995-05-05 |   -1 |         0 |
| 15 | oscar    | NULL                | 1998-12-30 |   -1 |         1 |
| 16 | paul     | paul@example.com    | 1994-02-28 |   -1 |         1 |
| 17 | quincy   | quincy@example.com  | 1983-07-07 |   -1 |         0 |
| 18 | rachel   | rachel@example.com  | 1987-01-21 |   -1 |         1 |
| 19 | steve    | steve@example.com   | 1999-08-08 |   -1 |         1 |
| 20 | tom      | NULL                | 2001-02-02 |   -1 |         0 |
| 21 | ursula   | ursula@example.com  | 1990-10-10 |   -1 |         1 |
| 22 | victor   | victor@example.com  | 1996-03-20 |   -1 |         1 |
| 23 | wendy    | wendy@example.com   | 1989-06-18 |   -1 |         0 |
| 24 | xavier   | xavier@example.com  | 1993-09-09 |   -1 |         1 |
| 25 | yvonne   | NULL                | 1981-11-11 |   -1 |         1 |
| 26 | zack     | zack@example.com    | 2003-07-04 |   -1 |         1 |
+----+----------+---------------------+------------+------+-----------+
26 rows in set (0.00 sec)
```

# 方式4：使用 mysqlimport 导入数据
- 确保数据库存在
- 确保表存在

**实例**：
```bash
$ sudo  mysqlimport -u root -p \
> --fields-terminated-by="," \
> --lines-terminated-by="\n" \
> --fields-optionally-enclosed-by='"' \
> testdb \ # 数据库名
> /var/lib/mysql-files/users.csv # 文件
Enter password: 
testdb.users: Records: 26  Deleted: 0  Skipped: 0  Warnings: 0
```

# 附录
## 附录 A 
### A.1 testdb_backup.sql
```sql
-- MySQL dump 10.13  Distrib 8.0.39, for Linux (x86_64)
--
-- Host: localhost    Database: testdb
-- ------------------------------------------------------
-- Server version	8.0.39-0ubuntu0.22.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `birthdate` date DEFAULT (curdate()),
  `age` int DEFAULT (-(1)),
  `is_active` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'alice','alice@example.com','1990-01-01',-1,1),(2,'bob','bob@example.com','1985-05-15',-1,0),(3,'charlie','charlie@example.com',NULL,-1,1),(4,'dave',NULL,'2000-07-21',-1,1),(5,'eve','eve@example.com','1995-10-10',-1,0),(6,'frank','frank@example.com','1988-03-02',-1,1),(7,'grace','grace@example.com','1992-11-11',-1,1),(8,'hannah','hannah@example.com','1997-06-25',-1,0),(9,'ivan','ivan@example.com','1980-08-12',-1,1),(10,'judy','judy@example.com','2002-04-30',-1,1),(11,'karen','karen@example.com','1991-09-15',-1,0),(12,'leo',NULL,'1986-12-09',-1,1),(13,'mike','mike@example.com',NULL,-1,1),(14,'nina','nina@example.com','1995-05-05',-1,0),(15,'oscar',NULL,'1998-12-30',-1,1),(16,'paul','paul@example.com','1994-02-28',-1,1),(17,'quincy','quincy@example.com','1983-07-07',-1,0),(18,'rachel','rachel@example.com','1987-01-21',-1,1),(19,'steve','steve@example.com','1999-08-08',-1,1),(20,'tom',NULL,'2001-02-02',-1,0),(21,'ursula','ursula@example.com','1990-10-10',-1,1),(22,'victor','victor@example.com','1996-03-20',-1,1),(23,'wendy','wendy@example.com','1989-06-18',-1,0),(24,'xavier','xavier@example.com','1993-09-09',-1,1),(25,'yvonne',NULL,'1981-11-11',-1,1),(26,'zack','zack@example.com','2003-07-04',-1,1);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-10-10 22:55:46
```

### A.2 /var/lib/mysql-files/users.csv 
```bash
$ sudo cat /var/lib/mysql-files/users.csv
1,"alice","alice@example.com","1990-01-01",-1,1
2,"bob","bob@example.com","1985-05-15",-1,0
3,"charlie","charlie@example.com",\N,-1,1
4,"dave",\N,"2000-07-21",-1,1
5,"eve","eve@example.com","1995-10-10",-1,0
6,"frank","frank@example.com","1988-03-02",-1,1
7,"grace","grace@example.com","1992-11-11",-1,1
8,"hannah","hannah@example.com","1997-06-25",-1,0
9,"ivan","ivan@example.com","1980-08-12",-1,1
10,"judy","judy@example.com","2002-04-30",-1,1
11,"karen","karen@example.com","1991-09-15",-1,0
12,"leo",\N,"1986-12-09",-1,1
13,"mike","mike@example.com",\N,-1,1
14,"nina","nina@example.com","1995-05-05",-1,0
15,"oscar",\N,"1998-12-30",-1,1
16,"paul","paul@example.com","1994-02-28",-1,1
17,"quincy","quincy@example.com","1983-07-07",-1,0
18,"rachel","rachel@example.com","1987-01-21",-1,1
19,"steve","steve@example.com","1999-08-08",-1,1
20,"tom",\N,"2001-02-02",-1,0
21,"ursula","ursula@example.com","1990-10-10",-1,1
22,"victor","victor@example.com","1996-03-20",-1,1
23,"wendy","wendy@example.com","1989-06-18",-1,0
24,"xavier","xavier@example.com","1993-09-09",-1,1
25,"yvonne",\N,"1981-11-11",-1,1
26,"zack","zack@example.com","2003-07-04",-1,1
```