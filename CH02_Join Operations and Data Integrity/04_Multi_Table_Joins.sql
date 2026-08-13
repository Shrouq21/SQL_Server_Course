-- Joins across multible tables

select s.st_fname,c.crs_name,sc.grade
from student s, stud_course sc, course c
where s.st_id=sc.st_id and c.crs_id=sc.crs_id


select st_fname,crs_name,grade
from student s 
inner join
stud_course sc
on s.st_id=sc.st_id
inner join 
course c
on c.crs_id=sc.crs_id


select st_fname,crs_name,grade,dept_name
from student s inner join stud_course sc
on s.st_id=sc.st_id

inner join 
          course c
          on c.crs_id=sc.crs_id

inner join
      department d
      on d.dept_id=s.dept_id

