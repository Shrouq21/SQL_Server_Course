-- Select & Order by (DQL)
Use ITI

select * from Student  -- All columns from the Student table.

select * from Student
where St_Address ='Cairo'

select St_Fname,St_Lname from Student

select St_Fname,St_Lname from Student
where St_Age>20

select * from Student 
order by St_Age

select *from Student 
order by St_Age desc,Dept_Id asc

select *from Student 
order by St_Age desc,Dept_Id desc

select *from Student 
order by St_Age ,Dept_Id desc

select *from Student 
order by St_Age desc,Dept_Id asc

select St_Fname,St_Lname from Student 
order by St_Fname 

select St_Fname,St_Lname,St_Age from Student
order by St_Fname , St_Lname desc 

select St_Fname+ ' ' +St_Lname
from Student

select St_Fname +' ' +St_Lname as fullname  --  "Full Name" is an alias.
from Student


select St_Fname +' ' +St_Lname fullname 
from Student


select St_Fname +' ' +St_Lname [full_name] 
from Student

-- If an alias contains spaces or reserved keywords,
-- surround it with [] or "".
select St_Fname +' ' +St_Lname "full name" 
from Student

select * from Student 
where st_fname is Null

select *from Student
where st_fname is not Null

select *from Student 
where st_fname is not Null and St_Lname is not Null

select *from Student 
where st_fname is not Null or St_Lname is not Null

select * from Student 
where St_Address='Cairo' or St_Address='Alex'

select *from Student
where St_Address='Cairo' and St_Address='Alex' -- returns no rows


select *from Student
where St_Age =22 or St_Age =23 or St_Age =30
 --==
select *from Student
where St_Age in (22,23,30)

select *from Student
where St_Age not in (22,23)

select *from Student 
where  St_Age   between 20 and 22  -- BETWEEN is inclusive.

select *from Student 
where St_Age not between 20 and 23

select *from Student
where St_Age>22 and St_Address='Alex' 


-- AND has higher precedence than OR.
-- Use parentheses when needed.
select *from Student
where St_Age>22 and St_Address='Alex' or st_address ='cairo' -


select distinct Dept_Id -- Display Dept_Id only 
from Student 

select distinct St_Age ,St_Address -- DISTINCT applies to the combination of (St_Age, St_Address).
from Student        

select St_Fname +' '+St_Age  -- You can't concatenate different data types without conversion.
from Student

select [full_name]=St_Fname +' ' +convert (varchar(20),St_Age)
from Student

select St_Fname +space(4)+convert(varchar(10),Dept_Id)
from Student    --  This does not affect the stored data
