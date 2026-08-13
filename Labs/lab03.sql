--Display (Using Union Function)and depending on Female Employee.
 --The name and the gender of the dependence that's gender is Female 
 --And the male dependence that depends on Male Employee.
 select Dependent_name,Sex
 from Dependent
 where Sex='F'
 Union
 select Dependent_name,Sex
 from Dependent d join Employee e
 on d.ESSN=e.SSN
 where d.Sex='M' and e.Sex='M'

 --list the project name and the total hours per week (for all employees) spent on that project.	
 select Pname,sum(Hours)
 from Project p join Works_for w
 on  p.Pnumber=w.Pno
 group by p.Pnumber,p.Pname
--Display the data of the department which has the smallest employee ID over all employees' ID.
select* from Departments d
join Employee e
on e.Dno=d.Dnum
where e.SSN=(select min(SSN) from employee)


--For each department, retrieve the department name and the maximum, minimum and average salary of its employees.
select Dname,max(Salary) as max_salary,min(Salary) as min_salary,avg(Salary) as avg_salary
from Departments d join Employee e
on d.Dnum=e.Dno
group by Dname,Dnum
--List the full name of all managers who have no dependents.
select fname+' '+lname as Full_name 
from employee e  join Departments d
on e.SSN=d.MGRSSN
left join Dependent d1
on d.MGRSSN=d1.ESSN
where d1.ESSN is null
--For each department-- if its average salary is less than the average salary of all employees-- display its number, name and number of its employees.

select Dnum,Dname,count(*) as NoOfEmployyes
from Departments d join Employee e
on d.Dnum=e.Dno
group by Dnum,Dname
having (avg(salary)<(select avg(salary) from Departments d join Employee e on d.Dnum=e.Dno))

--Retrieve a list of employee’s names and the projects names they are working on ordered by department number and within each department, ordered alphabetically by last name, first name.
select Fname+' '+lname as Full_name ,Pname
from Departments d join Employee e 
on d.Dnum=e.Dno
join Works_for w on w.ESSn=e.SSN
join Project p on w.Pno=p.Pnumber
order by Dnum,Lname,Fname
--Try to get the max 2 salaries using sub query
select max(salary) as salaries from employee
union 
select max(Salary) from employee
where Salary<(select max(salary) from employee)
order by salaries desc
--Get the full name of employees that is similar to any dependent name
select Fname+' '+Lname as Full_name
from Employee 
where Fname+' '+Lname in(select Dependent_name from Dependent)
--Display the employee number and name if at least one of them have dependents (use exists keyword) self-study.

select SSN ,Fname 
from Employee e
where exists(
select 1
from Dependent d 
where d.ESSN=e.SSN
) 

--In the department table insert new department called "DEPT IT”, with id 100, employee with SSN = 112233 as a manager for this department. The start date for this manager is '1-11-2006'
insert into Departments values('DEPT IT',100,112233,'1-11-2006')

--Do what is required if you know that : Mrs.Noha Mohamed(SSN=968574)  moved to be the manager of the new department (id = 100), and they give you(your SSN =102672) her position (Dept. 20 --manager) 
--First try to update her record in the department table
--Update your record to be department 20 manager.
--Update the data of employee number=102660 to be in your teamwork (he will be supervised by you) (your SSN =102672)

update Departments
set MGRSSN=968574
where Dnum=100

update Departments
set MGRSSN=102672
where Dnum=20

update Employee
set superssn=102672
where SSN=102660

--Unfortunately the company ended the contract with Mr. Kamel Mohamed (SSN=223344) so try to delete his data from your database in case you know that you will be temporarily in his position.
--Hint: (Check if Mr. Kamel has dependents, works as a department manager, supervises any employees or works in any projects and handle these cases).

delete from Works_for
where ESSn=223344

update Departments
set MGRSSN=102672
where MGRSSN=223344

delete from Dependent 
where ESSN=223344

update  Employee
set Superssn=102672
where superssn=223344;

Delete from Employee
where SSN=223344
--Try to update all salaries of employees who work in Project ‘Al Rabwah’ by 30%
update Employee
set Salary=Salary+Salary*0.3
where SSN in
(
select SSN from Employee e join works_for w  on e.SSN=w.ESSn join Project p on p.Pnumber=w.Pno where p.Pname='Al Rabwah'
)