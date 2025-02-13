-- truong hop hien thi ca nhung phan bang b khong co thong tin
select * from testingsystem.account as a
left join department as b
on a.DepartmentID = b.DepartmentID;

-- truong hop chi hien thi nhung phan ma bang b co thong 
select * from testingsystem.account as a
inner join department as b
on a.DepartmentID = b.DepartmentID;

-- truong hop hien thi ra thong tin chung va thong tin bang b ma bang a khong lien ket toi
select * from testingsystem.account as a
right join department as b
on a.DepartmentID = b.DepartmentID;

-- phan chung: nhung data co gia tri khoa ngoai
-- phan rieng cua a: nhung data ma khong co khoa ngoai (khoa ngoai == null)
-- phan rieng cua b: nhung data ma co khoa ngoai khong co gia tri trong khoa ngoai cua b

-- left excuding join
select * from testingsystem.account as a
left join department as b
on a.DepartmentID = b.DepartmentID
where b.DepartmentID is null;

-- right excluding join
select * from testingsystem.account as a
right join department as b
on a.DepartmentID = b.DepartmentID
where a.DepartmentID is null;

