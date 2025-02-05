create database TEST;
use TEST;

-- xoa bang
drop database if exists TEST;

create table Department (
DepartmentID int unsigned auto_increment primary key,
DepartmentName nvarchar(100) not null unique
);

create table Position (
PositionID int unsigned auto_increment primary key,
PositionName enum('Dev', 'Test', 'Scrum Master', 'PM') not null unique
);

create table Account (
AccountID int unsigned auto_increment primary key,
Email varchar(100) not null ,
Username varchar(100) not null unique,
FullName nvarchar(100),
DepartmentID int unsigned,
PositionID int unsigned,
CreateDate datetime default now(),
foreign key (DepartmentID) references Department (DepartmentID),
foreign key (PositionID) references Position (PositionID)
);

create table `Group` (
GroupID int unsigned auto_increment primary key,
GroupName nvarchar(100) not null unique,
CreatorID int unsigned,
CreateDate datetime default now(),
foreign key (CreatorID) references Account (AccountID)
);

create table GroupAccount (
GroupID int unsigned auto_increment,
AccountID int unsigned,
JoinDate date,
primary key (GroupID, AccountID),
foreign key (GroupID) references `Group` (GroupID),
foreign key (AccountID) references Account (AccountID)
);

create table TypeQuestion (
TypeID int unsigned auto_increment primary key,
TypeName enum('Essay', 'Multiple-Choice') not null unique
);

create table CategoryQuestion (
CategoryID int unsigned auto_increment primary key,
CategoryName nvarchar(50) not null unique
);

create table Question (
QuestionID int unsigned auto_increment primary key,
Content nvarchar(500) not null,
CategoryID int unsigned,
TypeID int unsigned,
CreatorID int unsigned,
CreateDate datetime default now(),
foreign key (CategoryID) references CategoryQuestion (CategoryID),
foreign key (TypeID) references TypeQuestion (TypeID),
foreign key (CreatorID) references Account (AccountID)
);

create table Answer (
AnswerID int unsigned auto_increment primary key,
Content nvarchar(500) not null,
QuestionID int unsigned,
isCorrect boolean,
foreign key (QuestionID) references Question (QuestionID)
);

create table Exam (
ExamID int unsigned auto_increment primary key,
Code varchar(20),
Title nvarchar(100) not null,
CategoryID int unsigned,
Duration int unsigned not null,
CreatorID int unsigned,
CreateDate datetime default now(),
foreign key (CategoryID) references CategoryQuestion (CategoryID),
foreign key (CreatorID) references Account (AccountID)
);

 -- thay doi kieu du lieu mot truong trong bang
-- ALTER TABLE Exam 
-- MODIFY COLUMN Duration int;

create table ExamQuestion (
ExamID int unsigned auto_increment,
QuestionID int unsigned,
primary key (ExamID, QuestionID),
foreign key (ExamID) references Exam (ExamID),
foreign key (QuestionID) references Question (QuestionID)
);

-- ràng buộc
-- tên trường  kiểu dữ liệu  ràng buộc

-- ràng buộc: primary key, foreign key, not null, default, unique (duy nhất), check

