USE testdb;

DROP TABLE IF EXISTS accounts;
CREATE TABLE accounts (
    id INT AUTO_INCREMENT PRIMARY KEY,
    balance FLOAT NOT NULL
)engine=InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;

INSERT INTO accounts (id, balance) VALUES (1, 1000), (2, 2000), (3, 3000);
SELECT * FROM accounts;

-- DROP PROCEDURE `testdb`.`transfer_funds`;

DELIMITER // -- 设置结束符

-- 注意：如果这里无法创建可以使用 Workbench 创建
CREATE DEFINER=`zyj`@`%` PROCEDURE `transfer_funds`(
    IN from_account_id INT,   -- 转出账户 ID
    IN to_account_id INT,     -- 转入账户 ID
    IN transfer_amount DECIMAL(10, 2)  -- 转账金额
)
label:BEGIN
    DECLARE current_balance DECIMAL(10, 2);  -- 声明一个变量来存储余额
    DECLARE from_account_exists INT;           -- 声明变量存储转出账户存在性
    DECLARE to_account_exists INT;             -- 声明变量存储转入账户存在性

	-- 开始事务
    START TRANSACTION;

    -- 检查转出账户是否存在
    SELECT COUNT(*) INTO from_account_exists
    FROM accounts WHERE id = from_account_id;

    -- 检查转入账户是否存在
    SELECT COUNT(*) INTO to_account_exists
    FROM accounts WHERE id = to_account_id;

    -- 如果转出账户不存在，则回滚并退出
    IF from_account_exists = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '转出账户不存在';
        ROLLBACK;
        LEAVE label;  
    END IF;

    -- 如果转入账户不存在，则回滚并退出
    IF to_account_exists = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '转入账户不存在';
        ROLLBACK;
        LEAVE label;    -- 退出存储过程
    END IF;

    -- 转账
    UPDATE accounts SET balance = balance - transfer_amount WHERE id = from_account_id;
    UPDATE accounts SET balance = balance + transfer_amount WHERE id = to_account_id;

    -- 获取转出账户的当前余额
    SELECT balance INTO current_balance FROM accounts WHERE id = from_account_id;

    -- 检查余额是否为非负
    IF current_balance >= 0 THEN
        -- 如果余额非负，则进行转账并提交事务
        COMMIT;
    ELSE
        -- 如果余额不足，则回滚事务
        ROLLBACK;
    END IF;
END //

DELIMITER ;

call transfer_funds(2, 1, 500);
call transfer_funds(3, 1, 3500);

SELECT * FROM accounts;