
-- Set Operators
-- UNION ALL: combines results (keeps duplicates)
-- UNION: combines results and removes duplicates
-- INTERSECT: returns common rows
-- EXCEPT: returns rows that exist in the first query only


-- Rules for UNION:
-- 1) Same number of columns
-- 2) Compatible data types
-- 3) Column names come from the first SELECT

 --union all union intersect except

 --batch 
 --set of independent queries

 --union all

 select st_fname
 from student
 union all  --sum of st_fname +ins_name
 select ins_name
 from instructor   --will be printed with the name of the first column

 select st_fname as names
 from student
 union all 
 select ins_name 
 from instructor

 -- Number of columns in the first select you specified should equal the second select of columns

select st_fname,st_id
from student
union all
select ins_name ,ins_id
from instructor


-- You can't usn different datatypes in each select

select st_id
from student
union all
select ins_name      -- Error 
from instructor

select convert(varchar(10),st_id)
from student
union all
select ins_name
from instructor

-- Union
select st_fname
from student
union -- Distinct -> order+unique
select ins_name
from Instructor 



select st_fname
from student
intersect 
select ins_name
from Instructor 

select st_fname ,st_id
from student
intersect 
select ins_name,ins_id
from Instructor

select*from student
select *from instructor
select st_fname    -- substract (exist in student but doesn't exist in instuctor)
from student
except 
select ins_name
from Instructor 


-- Column aliases cannot be used in WHERE
-- Because WHERE executes before SELECT


select st_fname+' ' +st_lname as fullname
from student
order by fullname


select st_fname+' '+st_lname as fullname  -- Error 
from student
where fullname='AhmedHassan'  -- Error 
-- There is no coloumn with fullname in this table


-- 2 solutions
select*from student
select st_fname+' ' +st_lname as fullname
from student
where st_fname+st_lname='AhmedHassan'


-- Any subquery in the FROM clause MUST have an alias
-- FROM expects a table name, not an anonymous result.

select *
from (select st_fname+ ' ' +st_lname as fullname from student ) as newtable --you should put alias when you get column
where fullname='Ahmed Hassan'


-- Subqueries in WHERE are value producers, not tables

select *from student 
where sname in (select st_fname from Dept d inner join student s on d.Did=s.did )