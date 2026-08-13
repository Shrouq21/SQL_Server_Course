--Display the Department id, name and id and the name of its manager.
select Dnum,Dname,MGRSSN,Fname+' '+Lname as Full_name
from Departments d inner join Employee e
on d.MGRSSN=e.Dno

--Display the name of the departments and the name of the projects under its control.
select Dname,Pname
from Departments d inner join Project p
on d.Dnum=p.Dnum

--Display the full data about all the dependence associated with the name of the employee they depend on him/her.
select ESSN,Dependent_name,d.Sex,d.Bdate,Fname+' '+Lname as Full_name
from Dependent d join Employee e
on d.ESSN=e.SSN

--Display the Id, name and location of the projects in Cairo or Alex city.
select Pnumber,Pname,Plocation 
from Project
where City='Cairo' or City='Alex'

--Display the Projects full data of the projects with a name starts with "a" letter.
select * from Project
where Pname like 'a%'

--display all the employees in department 30 whose salary from 1000 to 2000 LE monthly
select Fname+' ' +Lname as Full_name
from Employee
where Dno=30 and Salary between 1000 and 2000

--Retrieve the names of all employees in department 10 who works more than or equal 10 hours per week on "AL Rabwah" project.
select Fname+' '+Lname as Full_nama
from employee e join Works_for w
on e.SSN=w.ESSn
join Project p on w.Pno=p.Pnumber
where e.Dno=10 and Hours>10 and Pname='AL Rabwah'

--Find the names of the employees who directly supervised with Kamel Mohamed.
select* from employee
select e1.Fname+' '+e1.Lname as Full_name
from Employee e join Employee e1
on e.SSN=e1.Superssn
where e.Fname='Kamel' and e.lname='Mohamed'

--Retrieve the names of all employees and the names of the projects they are working on, sorted by the project name.
select Pname,fname+' ' +lname as Full_name
from Project p join Works_for w
on p.Pnumber=w.Pno
join employee e
on e.SSN=w.ESSn
order by Pname

--For each project located in Cairo City , find the project number, the controlling department name ,the department manager last name ,address and birthdate.
select Pnumber,Dname,Lname,Address,Bdate
from Project p join Departments d
on p.Dnum=d.Dnum
join employee e
on e.SSN=d.MGRSSN
where City='Cairo City'

--Display All Data of the managers
select Fname+' '+Lname as Full_name ,SSN,Bdate,Address,Sex,Salary,Superssn,Dno
from Employee e join Departments d
on e.SSN=d.MGRSSN

--Dislay All Employees data and the data of their dependents even if they have no dependents
select* from 
Employee left join Dependent
on Employee.SSN=Dependent.ESSN

--Insert your personal data to the employee table as a new employee in department number 30, SSN = 102672, Superssn = 112233, salary=3000.
insert into Employee values('Aya','Essam',102672,'2005-8-14','Nasr City','F',3000,112233,30)

--Insert another employee with personal data your friend as new employee in department number 30, SSN = 102660, but don’t enter any value for salary or supervisor number to him.
insert into Employee(Fname,Lname,SSN,Bdate,Address,Sex,Dno) values
('Ahmed','khaled',102660,'2002-9-14','Nasr City','M',30)

--Upgrade your salary by 20 % of its last value. 
update employee
set Salary=Salary+Salary*0.20