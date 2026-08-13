-- Self Join (employees with supervisors)

select x.ename as EmpName,y.ename as supername
from employee x,employee y
where y.eid=x.superid 



select x.ename as empname ,y.* --all supervisor data
from employee x,employee y
where y.eid=x.superid

select distinct y.ename --all supervisors
from employee x, employee y
where y.eid=x.superid;

-- Using Inner and Left Join for self join

select x.ename as EmpName,y.ename as supername
from employee x 
inner join
employee y
on y.eid=x.superid 


select x.ename as EmpName,y.ename as supername
from employee x left join employee y
on y.eid=x.superid 
