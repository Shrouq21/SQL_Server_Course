--Null handling
select *from student 

select st_fname
from student
where st_fname is not null


select isnull(st_fname,'empty')
from student

select isnull(st_fname,st_lname)
from student
