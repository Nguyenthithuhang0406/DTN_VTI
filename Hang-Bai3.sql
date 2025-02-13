use testingsystem;

-- Cau 2
select * from department;

-- Cau 3
select DepartmentID 
from department
where DepartmentName = 'Sale';

-- note: length se dem so byte, char_length dem so ky tu
-- Cau 4
-- lay 1 gia tri
select *
from account
order by char_length(FullName) desc
limit 1;

-- Cau 4
-- lay nhieu gia tri
select * 
from account
where char_length(FullName) = (
						select max(char_length(FullName))
                        from account );

-- Cau 5
select *
from account
where DepartmentID = 3
order by char_length(FullName) desc
limit 1;

-- Cau 6
select GroupName
from `group`
where CreateDate < '2019-12-20 00:00:00';

-- Cau 7
select QuestionID
from answer
group by QuestionID
having count(AnswerID) >= 4;

-- Cau 8
select Code
from exam
where Duration >= 60 and CreateDate < '2019-12-20 00:00:00';

-- Cau 9
select *
from `group`
order by CreateDate desc
limit 5;

-- Cau 10
select count(AccountID)
from account 
where DepartmentID = 2
group by DepartmentID;

-- Cau 11
select FullName
from account
where FullName like 'D%o';
