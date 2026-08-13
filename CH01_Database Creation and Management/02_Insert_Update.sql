-- Insert & Update (DML)
Use ITI

insert into dept
values(1,'ahmed',1000)
insert into dept
values(2,'Yara',2000),(3,'Ramez',3000) ,(4,'fathy',4000)

update dept 
set dsalary =8000 

update dept
set dsalary=9000    

update dept
set dsalary =6000 , dname='Ramy'
where did=2
update dept
set dsalary +=1000
where did =1

update dept
set dsalary=NULL    --only works because dsalary is nullable 

update dept
set dname=default
where did=2

delete from dept  -- (Metadata still as it is) -> data is deleted but table structure remains
where did=1

delete from dept 

select *from dept