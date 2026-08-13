
-- Rule:
-- If the SELECT list contains both aggregate functions
-- and non-aggregated columns,
-- the non-aggregated columns must appear in GROUP BY.


select count(SSN) as EmployeeCount
,Address
from employee
group by Address


-- Filtering order:
-- 1) FROM
-- 2) WHERE
-- 3) GROUP BY
-- 4) any aggregates
-- 5) HAVING
-- 6) SELECT
-- 7) ORDER BY
-- WHERE filters rows before grouping


select*from student
select count(st_Id),st_Address
from Student
where st_Age in(24,25,26) --  Filters out rows whose age is not 24, 25, or 26.
group by st_Address



select*from student
select count(st_Id),st_Address
from Student
where st_Age between 24 and 25 and 26 -- Filters out rows outside the specified range.
group by st_Address

select
count(St_Id) as studentCount
, Dept_Id
from student
where St_Age>24
group by Dept_Id


-- HAVING is used with aggregate functions
-- HAVING filters groups after GROUP BY

-- GROUP BY without HAVING is allowed
-- HAVING without GROUP BY treats the table as one group
-- HAVING filters groups after GROUP BY.
-- It is commonly used with aggregate functions.

select
count(St_Id) as StudentCount
, Dept_Id
from student
group by Dept_Id
having min(St_Age)>24




select St_Fname ,count(st_Id) ,Dept_Id -- count(st_ID) is aggregated
from student
where St_Fname like 'A%'
group by Dept_Id,St_Fname
having min(St_Age)>21


--group by without having
--having wihtout group

select*from student
select count(St_Fname)
from student                --you treat the table as one group
having min(St_Age)>19


select*from student
select count(St_Fname)
from student
having min(St_Age)>20                  --you treat the table as one group but you have one value ==20 so the group had been excluded

