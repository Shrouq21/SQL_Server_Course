-- Date Functions
-- Used for date calculations and formatting
-- DATEDIFF returns the difference between two dates
-- DATEADD adds or subtracts time units from a date


select getdate()

select year(getdate())
select month(getdate())
select day(getdate())

select datepart(month,getdate()) --int
select datename(month,getdate()) --string

select Dept_Name, Manager_hiredate --date type
from department

select Dept_Name ,year (Manager_hiredate)
from Department


select Dept_Name,month(Manager_hiredate)
from Department

select Dept_Name,Datediff(year,manager_hiredate,getDate()) --substract manager_hiredate and getdate then return it in year
from department

-- Datadiff() takes 3 parameters
--DATEDIFF(unit, start_date, end_date)

--unit → the part of the date you want to measure (year, month, day, etc.)

--start_date → the earlier date (here: Manager_hiredate)

--end_date → the later date (here: GETDATE() → current date and time)

select datefromparts(2000,12,22)--(year,month,day) ,range(1-9999,1-12,1-31)



-- ISDATE checks whether a string can be converted to a valid date
-- Returns 1 if valid, 0 if invalid


select isdate('ahmed') --isdate(string) (bool)  --0
 
select isdate('1/1/2000') --1

select  dateadd(day,7,getdate())     --dateadd(datepart,number,date)

select dateadd(day,-7,getdate()) --substract   7 days ago

select dateadd(month,1,getdate());  --next month

select dateadd(year,-1,getdate()) --last year


 -- converting
 -- GETDATE() → returns a datetime type, not a string.
-- Internally, SQL Server stores it as a date + time number, not as text.

select convert(varchar(50),getdate()) --is better
select cast(getdate() as varchar(50))


select convert(varchar(50),getdate(),101) --  02/04/2026
select convert(varchar(50),getdate(),102) -- 2026.02.04
select convert(varchar(50),getdate(),103)  -- 04/02/2026
select convert(varchar(50),getdate(),104)  -- 04.02.2026
select convert(varchar(50),getdate(),105) -- 04-02-2026



select format(getdate(),'dd-MM-yyyy')
select format(getdate(),'dddd MMMM yyyy')
select format(getdate(),'ddd MMM yy')
select format(getdate(),'dddd')
select format(getdate(),'MMMM')
select format(getdate(),'hh:mm:ss')
select format(getdate(),'hh')
select format(getdate(),'hh tt')
select format(getdate(),'hh mm tt')
select format(getdate(),'dd-MM-yyyy hh:mm:ss tt')

select eomonth(getdate())  --get end of month (return data)

select format(eomonth(getdate()),'dd') --if you want a part from the data

select format(eomonth(getdate()),'dddd')

select eomonth(getdate(),2) --after two month from now

select eomonth(getdate(),-2)



-- NULL Handling Functions
-- ISNULL: replaces NULL with a specified value
-- COALESCE: returns the first non-NULL value
-- NULLIF: returns NULL if two values are equal

select isnull(st_fname,st_lname)
from student

select coalesce(st_fname,st_lname,st_address,'No data') 
from student


select nullif('ahmed','ahmed') --compare two values 
--if first looks likes secod return null
--else return first value


select st_fname +' '+convert(varchar(20),st_age)
from student

select st_fname,' ',st_age
from student


-- CONCAT converts all values to string and ignores NULLs
-- STRING_AGG converts multiple rows into a single string
-- STRING_SPLIT converts a string into multiple rows

select concat(st_fname,' ',st_age)  --no null values all values convert to string
from student
--concat convert anything to string

select concat('stud name = ' ,st_fname, ' &age= ',st_age)
from student
