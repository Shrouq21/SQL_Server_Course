create table EMPLOYEE(
FNAME nvarchar(50) ,
LName nvarchar(50),
SSN int primary key,
BDATE date,
ADDRESS nvarchar(50),
SEX char(1) ,
SALARY decimal(10,2),
SUPERSSN int,
DNO int 
)
create table DEPARTMENT(
DNAME nvarchar(50),
DNUMBER int primary key,
MGRSSN int foreign key references EMPLOYEE(SSN),
MGRSTARTDATE date
)
alter table EMPLOYEE
add constraint Fk_employee_department
foreign key(DNO) references department(DNUMBER)

alter table EMPLOYEE
add constraint Fk_employee_superssn
foreign key(SUPERSSN) references EMPLOYEE(SSN)

create table DEPT_LOCATIONS(
DNUMBER int foreign key references DEPARTMENT(DNUMBER),
DLOCATION nvarchar(50),
primary key(DNUMBER,DLOCATION)
)

create table PROJECT(
PNAME nvarchar (50),
PNUMBER int primary key,
PLOACATION nvarchar(50),
DNUM int references DEPARTMENT(DNUMBER)
)

create table WORKS_ON(
ESSN int foreign key references EMPLOYEE(SSN),
PNO int foreign key references PROJECT(PNUMBER),
HOURS decimal (5,2),
primary key(ESSN,PNO)
)

create table DEPENDENT(
ESSN int foreign  key references EMPLOYEE(SSN),
DEPENDENT_NAME nvarchar(50),
SEX char,
BDATE date,
RELATIONSHIP nvarchar(50),
primary key(ESSN,DEPENDENT_NAME)
)

insert into employee values('Hanaa','Sobhy',102660,'1970-10-15','269 El-Haram st. Giza','M',1200,null,null)
insert into DEPARTMENT values('DP1',10,102660,'2006-01-03')

select*from DEPARTMENTS


-- Display all the employees Data. 
select*from employee

--Display the employee First name, last name, Salary and Department number.
select Fname,Lname,Salary,Dno
from Employee

--Display all the projects names, locations and the department which is responsible about it.
select Pname,Plocation,Dnum
from Project

--If you know that the company policy is to pay an annual commission for each employee with specific percent equals 10% of his/her annual salary .Display each employee full name and his annual commission in an ANNUAL COMM column (alias).
select (Fname+' '+Lname) as Full_name,Salary*12*0.10 as Annual_Comm
from employee

--Display the employees Id, name who earns more than 1000 LE monthly.
select SSN ,Fname+' ' +Lname as Full_name from employee
where Salary>1000

--Display the employees Id, name who earns more than 10000 LE annually.
select SSN ,Fname+' ' +Lname as Full_name from employee
where Salary*12>10000

--Display the names and salaries of the female employees 
select Fname+' '+Lname , Salary from employee
where sex='F'

--Display each department id, name which managed by a manager with id equals 968574.
select Dnum,Dname
from Departments
where MGRSSN=968574

--Display the ids, names and locations of  the pojects which controled with department 10.
select Pnumber,Pname,Plocation 
from Project
where Dnum=10