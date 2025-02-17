use testingsystem;

create view question2 as
select a.*, count(b.GroupID)
from account a
inner join groupaccount b
on a.AccountID = b.AccountID
group by b.AccountID
having count(b.GroupID) = (select count(GroupID)
							from groupaccount
                            group by AccountID
                            order by count(GroupID) desc
                            limit 1);
                            
select *
from question
where char_length(Content) > 15;

select b.*
from account a
inner join department b
on a.DepartmentID = b.DepartmentID
group by b.DepartmentID
having count(a.AccountID) = (select count(AccountID)
							from account
                            group by DepartmentID
                            order by count(AccountID) desc
                            limit 1);

