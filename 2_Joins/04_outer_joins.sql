--Outer join

--Left Join( all students even if no dept)
select sname,dname
from student s left outer join dept d
on d.did=s.did


--Right Join (all departments even if no student)
select sname,dname
from student s right outer join dept d
on d.did=s.did

--Full outer Join (right + left)
select sname,dname
from student s full outer join dept d
on d.did=s.did