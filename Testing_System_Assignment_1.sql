create database TEST;
use TEST;

create table Department (
DepartmentID int unsigned auto_increment primary key,
DepartmentName nvarchar(100)
);

create table Position (
PositionID int unsigned auto_increment primary key,
PositionName enum('Dev', 'Test', 'Scrum Master', 'PM')
);

create table Account (
AccountID int unsigned auto_increment primary key,
Email varchar(100),
Username varchar(100),
FullName nvarchar(100),
DepartmentID int unsigned,
PositionID int unsigned,
CreateDate date,
foreign key (DepartmentID) references Department (DepartmentID),
foreign key (PositionID) references Position (PositionID)
);

create table `Group` (
GroupID int unsigned auto_increment primary key,
GroupName nvarchar(100),
CreatorID int unsigned,
CreateDate date,
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
TypeName enum('Essay', 'Multiple-Choice')
);

create table CategoryQuestion (
CategoryID int unsigned auto_increment primary key,
CategoryName nvarchar(50)
);

create table Question (
QuestionID int unsigned auto_increment primary key,
Content nvarchar(500),
CategoryID int unsigned,
TypeID int unsigned,
CreatorID int unsigned,
CreateDate date,
foreign key (CategoryID) references CategoryQuestion (CategoryID),
foreign key (TypeID) references TypeQuestion (TypeID),
foreign key (CreatorID) references Account (AccountID)
);

create table Answer (
AnswerID int unsigned auto_increment primary key,
Content nvarchar(500),
QuestionID int unsigned,
isCorrect enum('true', 'false'),
foreign key (QuestionID) references Question (QuestionID)
);

create table Exam (
ExamID int unsigned auto_increment primary key,
Code varchar(20),
Title nvarchar(100),
CategoryID int unsigned,
Duration datetime,
CreatorID int unsigned,
CreateDate date,
foreign key (CategoryID) references CategoryQuestion (CategoryID),
foreign key (CreatorID) references Account (AccountID)
);

create table ExamQuestion (
ExamID int unsigned auto_increment,
QuestionID int unsigned,
primary key (ExamID, QuestionID),
foreign key (ExamID) references Exam (ExamID),
foreign key (QuestionID) references Question (QuestionID)
);

