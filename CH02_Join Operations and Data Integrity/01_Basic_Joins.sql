-- Cross Join (Cartesian Product): every student is paired with every department.

select Sname,Dname  
from student,dept

-- Another way
select Sname,Dname -- 4 students × 4 departments = 16 rows
from student cross join dept

-- Inner Join: match only related rows

-- Equi Join

select sname,dname
from student,dept
where dept.did=student.did 

-- Using aliases
select sname,Dname
from student s,dept d
where d.Did =s.did  


-- Using Inner Join (ON)
select sname,dname
from student s
inner join dept d
on d.Did=s.did


select *            --(all tables in both)
from student s,department d
where d.dept_id=s.dept_id

select st_fname,d.*        --st_fname from student , all tables in department
from student s,department d
where d.dept_id=s.dept_id
order by dept_name

--Adding a condition

select st_fname,dept_name        --st_fname from student , all tables in department
from student s,department d
where d.dept_id=s.dept_id and st_address='alex'
order by dept_name

select st_fname,dept_name
from student s
inner join
department d
on d.dept_id=s.dept_id  and st_age>23
 

 select st_fname,dept_name
from student s inner join department d
on d.dept_id=s.dept_id  
where st_age>23
 

select st_fname,dept_name
from student s inner join department d
on d.dept_id=s.dept_id 
