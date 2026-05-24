-- Insert data into Dept

insert into Dept
values(10,'SD'),(20,'HR'),(30,'IS'),(40,'Admin')

-- Insert data into Student

insert into Student
values(1,'Ahmed',10),(2,'Khalid',10),(3,'Eman',20),(4,'Omar',null)
select sname,Dname
from student,Dept

-- Insert data into Employee (self-reference)

insert into employee values
(1,'ahmed',null),
(2,'Eman',1),
(3,'Ali',1),
(4,'khalid',2),
(5,'nada',2)