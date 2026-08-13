-- Retrieve a number of students who have a value in their age
select count(St_Age)
from Student

-- Get all instructors Names without repetition
select distinct Ins_Name
from Instructor

--Display student with the following Format (use isNull function)
--Student ID Student Full Name  Department name
select St_Id  as 'Student Id' ,
isNull(St_Fname,' ')+''+isNull(St_Lname,'') as 'student Full Name' , 
isnull(Dept_Name,'No Department') as 'Department name'
from Department d right join Student s
on d.Dept_Id=s.Dept_Id


-- Display instructor Name and Department Name 
-- Note: display all the instructors if they are attached to a department or not
select Ins_Name,Dept_Name
from Instructor i left join Department d
on i.Dept_Id=d.Dept_Id

-- Display student full name and the name of the course he is taking 
-- For only courses which have a grade  
select St_Fname+' '+St_Lname as Full_name ,Crs_Name
from Student s join Stud_Course sc
on s.St_Id=sc.St_Id
join Course c 
on c.Crs_Id=sc.Crs_Id
where Grade is not null

-- Display number of courses for each topic name
select Top_Name,count(Crs_Id) as NoOfCourses from Course c join Topic t
on c.Top_Id=t.Top_Id
group by Top_Name

-- Display max  and min sal from instructor
select max(Salary) as Max_salary, min(Salary) as Min_Salary
from Instructor

-- Display instructors who have salaries less than the average salary of all instructors.
select Ins_Name
from Instructor 
having Salary<(select avg(Salary) from Instructor)

-- Display the Department name that contains the instructor who receives the minimum salary
select  Dept_Name
from Department d join Instructor i 
on d.Dept_id=i.Dept_id
where Salary=(select min(Salary) from Instructor)


 --Select max two salaries in the instructor table
 select max(Salary) as salaries
 from Instructor
 union 
 select max(Salary)
 from Instructor
 where Salary<(select max(salary) from Instructor )
 order by salaries desc


 -- Select instructor name and his salary but if there is no salary display instructor bonus keyword. “use coalesce Function”
select Ins_Name,coalesce(cast(Salary as nvarchar(20)),'instructor bonus')
from Instructor

--  Select Average Salary for instructors 
select avg(Salary) as Avg_Salary from Instructor

-- Select Student first name and the data of his supervisor 

select s2.St_Fname as 'Student' ,s1.St_Fname as 'Supervisor' ,s1.St_Address, s1.St_Age,s1.Dept_Id
from 
Student s1 join Student s2
on s1.St_Id=s2.St_super

-- Write a query to select a random student from each department. “using one of Ranking Functions”
select St_Fname,Dept_Id
from (
select St_Fname,d.Dept_Id,
Row_Number()over(partition by d.Dept_Id order by NewId()) as random_Id from 
Student s join Department d
on s.Dept_Id=d.Dept_Id
)as temp
where random_Id=1



-- Write a query to select the highest two salaries in Each Department for instructors who have salaries. “using one of Ranking Functions”
select Dept_id,Salary from(
select d.Dept_id,Salary,Row_Number()over(partition by d.Dept_id order by Salary desc) as ranking
from Department d join Instructor i
on d.Dept_Id=i.Dept_Id
where Salary is not null
) as temp
where ranking <=2

----------------------------------------------------------------------------------------

-- Display the SalesOrderID, ShipDate of the SalesOrderHeader table (Sales schema) to show SalesOrders that occurred within the period ‘7/28/2002’ and ‘7/29/2014
select SalesOrderID,ShipDate
from Sales.SalesOrderHeader
where OrderDate>='2002-7-28' and  OrderDate<='2014-7-29'

-- Display only Products(Production schema) with a StandardCost below $110.00 (show ProductID, Name only)
select ProductId,Name
from Production.Product
where StandardCost<110.00

--Display ProductID, Name if its weight is unknown
select ProductId,Name 
from Production.Product
where weight is null

--Display all Products with a Silver, Black, or Red Color
select* from Production.Product
where Color in ('Silver','Black','Red')


--Display any Product with a Name starting with the letter B
select* from Production.Product
where Name like 'B%'

--Run the following Query
--UPDATE Production.ProductDescription, SET Description = 'Chromoly steel_High of defects', WHERE ProductDescriptionID = 3
--Then write a query that displays any Product description with underscore value in its description.
update Production.ProductDescription 
set Description='Chromoly steel_High of defects'
where ProductDescriptionID=3

select Description
from Production.ProductDescription
where Description like '%[_]%'

-- Calculate sum of TotalDue for each OrderDate in Sales.SalesOrderHeader table for the period between  '7/1/2001' and '7/31/2014'
select sum(TotalDue) as total
from Sales.SalesOrderHeader
where OrderDate between '2001-7-1' and '2014-7-31'
group by OrderDate

-- Display the Employees HireDate (note no repeated values are allowed
select distinct HireDate 
from HumanResources.Employee

-- Calculate the average of the unique ListPrices in the Product table
select avg(distinct ListPrice) as Avg_ListPrice
from Production.Product


--Display the Product Name and its ListPrice within the values of 100 and 120 the list should have the following format
--"The [product name] is only! [List price]" (the list will be sorted according to its ListPrice value)

select Name,CONCAT('The ',Name,' is only! ',ListPrice) 
from Production.Product
order by ListPrice

--Do the following:
--Transfer the rowguid ,Name, SalesPersonID, Demographics from Sales.Store table  in a newly created table named [store_Archive]
--Note: Check your database to see the new table and how many rows in it?
--Try the previous query but without transferring the data?

select rowguid,Name,SalesPersonID,Demographics into store_Archive
from Sales.Store
select*from store_Archive

select rowguid,Name,SalesPersonID,Demographics into temp
from Sales.Store
where 1=2    -- No data , only the structure of the table

-- Using the “union” statement, retrieve today's date in different styles using the convert or format function.
select 
format(getdate(),'dd-MM-yyyy')
union
select 
format(getdate(),'dd MM yyyy')
union 
select format(getdate(),'dddd MMMM yyyy')
union 
select format(getdate(),'ddd MMM yyyy')
union 
select format(getdate(),'dd MM yyyy hh:mm:ss tt')



