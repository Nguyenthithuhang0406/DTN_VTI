use testingsystem;
-- cau 1
-- Viết lệnh để lấy ra danh sách nhân viên và thông tin phòng ban của họ
select *
from account as a
inner join department as b
on a.DepartmentID = b.DepartmentID;

-- cau 2
-- Viết lệnh để lấy ra thông tin các account được tạo sau ngày 20/12/2010
select * 
from account 
where CreateDate > '2010-12-20 00:00:00';

-- cau 3
-- Viết lệnh để lấy ra tất cả các developer
select *
from account a
inner join position b
on  a.PositionID = b.PositionID
where b.PositionName = 'Dev';

-- cau 4
-- Viết lệnh để lấy ra danh sách các phòng ban có >3 nhân viên
select b.DepartmentID, b.DepartmentName
from account as a
inner join department as b
on a.DepartmentID = b.DepartmentID
group by DepartmentID
having count(AccountID) > 3;

-- cau 5
-- Viết lệnh để lấy ra danh sách câu hỏi được sử dụng trong đề thi nhiều nhất
-- nen lay theo count se khong bo sot, neu dem theo id se bo sot
select distinct b.*
from examquestion as a
inner join question as b
on a.QuestionID = b.QuestionID
group by a.QuestionID
having count(a.ExamID) = ( select count(ExamID) 
						from examquestion 
                        group by QuestionID 
                        order by count(ExamID) desc
                        limit 1);
                        
-- cau 6
-- Thông kê mỗi category Question được sử dụng trong bao nhiêu Question
select b.*, count(QuestionID) as so_lan
from question a
inner join categoryquestion b
on a.CategoryID = b.CategoryID
group by a.CategoryID;

-- cau 7
-- Thông kê mỗi Question được sử dụng trong bao nhiêu Exam
select b.*, count(ExamID) as so_lan
from examquestion a 
inner join question b
on a.QuestionID = b.QuestionID
group by a.QuestionID;

-- cau 8
-- Lấy ra Question có nhiều câu trả lời nhất
-- dem theo count se khong bo sot, neu dem theo id thi no lay id dau se bi sot
select b.*
from answer a
inner join question b
on a.QuestionID = b.QuestionID
group by b.QuestionID
having count(a.AnswerID) = (select count(AnswerID)
						from answer
                        group by QuestionID
                        order by count(AnswerID) desc
                        limit 1);

-- cau 9
-- Thống kê số lượng account trong mỗi group
select GroupID, count(AccountID) as SL
from groupaccount
group by GroupID;

-- cau 10
-- Tìm chức vụ có ít người nhất
select distinct b.*
from account a
inner join position b
on a.PositionID = b.PositionID
group by b.PositionID
having count(a.AccountID) = (
					select count(AccountID)
                    from account
                    group by PositionID
                    order by count(AccountID) asc
                    limit 1);

-- cau 11
-- Thống kê mỗi phòng ban có bao nhiêu dev, test, scrum master, PM
SELECT 
    a.*,
    COUNT( distinct case WHEN b.PositionName = 'Dev' THEN 1 END) AS Dev_Count,
    COUNT(distinct CASE WHEN b.PositionName = 'Test' THEN 1 END) AS Test_Count,
    COUNT(distinct CASE WHEN b.PositionName = 'Scrum Master' THEN 1 END) AS Scrum_Master_Count
FROM account c
JOIN department a ON a.DepartmentID = c.DepartmentID
JOIN position b ON c.PositionID = b.PositionID
GROUP BY a.DepartmentID;

-- cau 12
-- Lấy thông tin chi tiết của câu hỏi bao gồm: thông tin cơ bản của question, loại câu hỏi, ai là người tạo ra câu hỏi, câu trả lời là gì, ...
select *
from question a
inner join typequestion b
on a.TypeID = b.TypeID
inner join account c
on a.CreatorID = c.AccountID
inner join answer d
on d.QuestionID = a.QuestionID;

-- cau 13
-- Lấy ra số lượng câu hỏi của mỗi loại tự luận hay trắc nghiệm


-- cau 14
-- Lấy ra group không có account nào
select a.*
from `group` a
inner join groupaccount b
on a.GroupID = b.GroupID
where a.GroupID not in (
					select GroupID
                    from groupaccount
                    group by GroupID);
                    
-- cau 15
-- trung cau 14

-- cau 16
-- Lấy ra question không có answer nào
select a.*
from question a
inner join answer b
on a.QuestionID = b.QuestionID
where a.QuestionID not in (
						select QuestionID
                        from answer
                        group by QuestionID);
                        
-- cau 17
-- Lấy các account thuộc nhóm thứ 1
select a.* 
from account a
inner join groupaccount b
on a.AccountID = b.AccountID
where b.GroupID = 1
union
-- Lấy các account thuộc nhóm thứ 2
select a.* 
from account a
inner join groupaccount b
on a.AccountID = b.AccountID
where b.GroupID = 2;

-- cau 18
-- Lấy các group có lớn hơn 5 thành viên
select a.*
from `group` a
inner join groupaccount b
on a.GroupID = b.GroupID
group by b.GroupID
having count(b.AccountID) > 5
union
-- Lấy các group có lớn hơn 7 thành viên
select a.*
from `group` a
inner join groupaccount b
on a.GroupID = b.GroupID
group by b.GroupID
having count(b.AccountID) > 7;
