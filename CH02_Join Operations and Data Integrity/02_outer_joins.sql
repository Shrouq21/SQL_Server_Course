--Outer join

--Left Join( all students even if no dept)
select sname,dname
from student s left join dept d
on d.Did=s.did


--Right Join (all departments even if no student)
select sname,dname
from student s right join dept d
on d.Did=s.did

--Full  Join (right + left)
select sname,dname
from student s full join dept d
on d.Did=s.did