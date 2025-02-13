use TEST;

insert into Department (DepartmentName) 
values
('Sale'),
('Marketing'),
('SEO'),
(N'Tài chính'),
(N'Kế toán');

select * from Department;

insert into Position (PositionName)
values
('Dev'),
('Test'),
('Scrum Master'),
('PM');

 select * from Position;
 
 insert into Account (Email, Username, FullName, DepartmentID, PositionID)
 values
 ('hangnguyenthithu32@gmail.com', 'Hangcute', N'Nguyễn Thị Thu Hằng', 1, 4),
 ('bingocuoituoi@gmail.com', 'Phuongiu', N'Lương Thị Phượng', 3, 1),
 ('thutrang24@gmail.com', 'Trang2k4', N'Đặng Thu Trang', 4, 2),
 ('nguyenmyninh@gmail.com', 'Ninh23', N'Nguyễn Thị Mỹ Ninh', 4, 3),
 ('nguyenthihang@gmail.com', 'Hang2k4', N'Nguyễn Thị Thu Hằng', 2, 4);
 
 select * from Account;
 
 insert into `Group` (GroupName, CreatorID)
 values 
 (N'Nhóm 1', 2),
 (N'Inocenbuny', 4),
 (N'Nhóm 3', 3),
 (N'Nhóm 4', 1),
 (N'Nhóm 5', 5);
 
 select * from `Group`;
 
 insert into GroupAccount (AccountID, JoinDate)
 values
 (2, '2024-12-01'),
 (4, '2025-01-04'),
 (5, '2025-02-04'),
 (3, '2024-07-04'),
 (1, '2024-05-03');
 
 select * from GroupAccount;
 
 insert into TypeQuestion (TypeName)
 values
 ('Essay'),
 ('Multiple-Choice');
 
 select * from TypeQuestion;
 
 insert into CategoryQuestion (CategoryName)
 values
 ('Java'),
 ('ReactJS'),
 ('NodeJS'),
 ('TypeScript'),
 ('Java Core');
 
 select * from CategoryQuestion;
 
 insert into Question (Content, CategoryID, TypeID, CreatorID)
 values
 (N'JSX là gì?', 2, 1, 4),
 (N'Các cách so sánh chuỗi ?', 5, 2, 3),
 (N'Phân biệt let, var, const ?', 2, 1, 5),
 (N'Tác dụng của CORS ?', 3, 1, 1),
 (N'Khác biệt giữa kiểu any và unknow ?', 4, 2, 2);
 
 select * from Question;
 
 insert into Answer (Content, QuestionID, isCorrect)
 values
 (N'JSX (JavaScript XML) là một cú pháp mở rộng của JavaScript, được sử dụng trong React để mô tả giao diện UI một cách trực quan, tương tự như HTML.', 1, true),
 (N'Dùng equals()', 2, true),
 (N'Dùng ===', 2, false),
 (N'Dùng compareTo()', 2, true),
 (N'Bảo vệ dữ liệu', 4, true);
 
 select * from Answer;
 
 insert into Exam (Code, Title, CategoryID, Duration, CreatorID)
 values
 ('D021', N'Kiểm tra lần 1', 2, 15, 3),
 ('M026', N'Kiểm tra tx2', 3, 60, 5),
 ('H837', N'Kết thúc học phần', 5, 90, 2),
 ('D738', N'Kiểm tra lại lần 1', 3, 15, 4),
 ('H736', N'Thi giữa kì', 1, 60, 1);
 
 select * from Exam;
 
 insert into ExamQuestion (QuestionID)
 values
 (4),
 (2),
 (5),
 (1),
 (3);
 
 select * from ExamQuestion;
 
 