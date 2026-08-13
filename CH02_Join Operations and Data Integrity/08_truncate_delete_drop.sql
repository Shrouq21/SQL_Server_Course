--drop ,delete ,truncate

drop table student --ddl data&metadata
delete from student --dml data only          

truncate table student -- deleted all data, faster than delete, resets identity



insert into myemp values('ramy')
insert into myemp values('hany')
truncate table myemp  --reset identity again

-- TRUNCATE is considered a DDL statement because it resets the identity and deallocates data pages.
