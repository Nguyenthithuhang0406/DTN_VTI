CREATE DATABASE DTN_2501;
use DTN_2501;

-- cau lenh tao bang
CREATE TABLE table_name(
column_name_1 int,
column_name_2 varchar(50),
column_name_3 date
);

-- BT
CREATE TABLE TRAINEE(
trainee_iD int unsigned AUTO_INCREMENT PRIMARY KEY,
full_name nvarchar(100),
birth_date date,
gender enum('male', 'female', 'unknow'),
et_iq tinyint unsigned check(et_iq >= 0 and et_iq <= 20),
et_gmath tinyint unsigned check(et_gmath >= 0 and et_gmath <= 20),
et_english tinyint unsigned check(et_english >= 0 and et_english <= 50),
training_class int,
evaluation_notes text
);

ALTER TABLE TRAINEE
ADD vti_account varchar(100) unique;

create table GroupTest (
GroupID int unsigned auto_increment primary key,
GroupName nvarchar(100),
CreatorID int unsigned,
CreateDate date
);

select * from GroupTest;
insert into GroupTest(GroupName, CreatorID, CreateDate) values ('Group 1', 1, '2025-02-04');
