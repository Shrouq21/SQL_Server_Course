-- Date Functions
-- Used for date calculations and formatting
-- DATEDIFF returns the difference between two dates
-- DATEADD adds or subtracts time units from a date


select getdate()

select year(getdate())
select month(getdate())
select day(getdate())

select datepart(month,getdate()) -- It extracts the month as a number (int).
select datename(month,getdate()) -- It extracts the month as its name (nvarchar).

select Dept_Name, Manager_hiredate -- Manager_hiredate is a Date column
from department

select Dept_Name ,year (Manager_hiredate) -- To extract the year from it
from Department


select Dept_Name,month(Manager_hiredate)
from Department

select Dept_Name,Datediff(year,manager_hiredate,getDate()) --subtract manager_hiredate and getdate then  returns the difference in years.
from department

-- DateDIFF() takes 3 parameters
-- DATEDIFF(unit, start_date, end_date)

-- unit → the part of the date you want to measure (year, month, day, etc.)

-- start_date → the earlier date (here: Manager_hiredate)

-- end_date → the later date (here: GETDATE() → current date and time)

select datefromparts(2000,12,22)-- (year,month,day) ,range(1-9999,1-12,1-31) -> 2000-12-22



-- ISDATE checks whether a string can be converted to a valid date
-- Returns 1 if valid, 0 if invalid


select isdate('ahmed') --isdate(string)  ->   0
 
select isdate('1/1/2000') --  1

select  dateadd(day,7,getdate())     --dateadd(datepart,number,date)

select dateadd(day,-7,getdate()) --substract   7 days ago

select dateadd(month,1,getdate());  --next month

select dateadd(year,-1,getdate()) --last year


 -- converting
 -- GETDATE() → returns a datetime type, not a string.
 -- It returns the current date and time as a datetime value, for example: 2026-08-12 10:30:45.123
-- Internally, SQL Server stores it as a date + time number, not as text.

select convert(varchar(50),getdate()) --is better
select cast(getdate() as varchar(50))


select convert(varchar(50),getdate(),101) --  02/04/2026
select convert(varchar(50),getdate(),102) -- 2026.02.04
select convert(varchar(50),getdate(),103)  -- 04/02/2026
select convert(varchar(50),getdate(),104)  -- 04.02.2026
select convert(varchar(50),getdate(),105) -- 04-02-2026



select format(getdate(),'dd-MM-yyyy') -- 13-08-2026
select format(getdate(),'dddd MMMM yyyy') -- Thursday August 2026
select format(getdate(),'ddd MMM yy') -- Thu Aug 26
select format(getdate(),'dddd') -- Thursday
select format(getdate(),'MMMM') -- August
select format(getdate(),'hh:mm:ss') -- 02:35:42
select format(getdate(),'hh') -- 02
select format(getdate(),'hh tt') -- 02 PM
select format(getdate(),'hh mm tt') -- 02 35 PM
select format(getdate(),'dd-MM-yyyy hh:mm:ss tt') -- 13-08-2026 02:35:42 PM

select eomonth(getdate())  --get end of month (returns the last day of the month.)

select format(eomonth(getdate()),'dd') --if you want a part from the data

select format(eomonth(getdate()),'dddd')

select eomonth(getdate(),2) --after two month from now

select eomonth(getdate(),-2)


