CREATE USER 'Hangcute'@'127.0.0.1' IDENTIFIED BY 'Hang0406@';

select * from mysql.user;

FLUSH PRIVILEGES;

-- update

-- phan quyen 

-- Phân quyền trên bảng cụ thể
GRANT UPDATE ON TestingSystem.Account
TO 'Hangcute'@'127.0.0.1';


-- Phân quyền trên database cụ thể
GRANT UPDATE ON TestingSystem.*
TO 'Hangcute'@'127.0.0.1';


-- Phân quyền trên toàn database
GRANT UPDATE ON *.*
TO 'Hangcute'@'127.0.0.1';

SHOW PROCESSLIST;
