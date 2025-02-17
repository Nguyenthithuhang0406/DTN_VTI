use testingsystem;

create view AC_DP_1 as
select * from account
where DepartmentID = 1;

create view DP_SALE as
select DepartmentID 
from department
where DepartmentName = 'Sale';

select * from account
where DepartmentID = (select DepartmentID
						from DP_SALE);
                        
