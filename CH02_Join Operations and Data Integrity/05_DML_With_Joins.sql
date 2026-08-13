-- DML with Joins
-- Updata grades

update stud_course
set grade+=10

update stud_course
set grade+=10
where st_id=1

update stud_course
set grade+=10
from student s, stud_course sc
where s.st_id=sc.st_id and st_address='cairo'


-- Delete with Join
delete  sc
from stud_course sc , course c
where c.crs_id=sc.crs_id and crs_name='sql server'


