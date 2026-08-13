-- String functions

-- CONCAT converts all values to string and ignores NULLs
-- STRING_AGG converts multiple rows into a single string
-- STRING_SPLIT converts a string into multiple rows

select concat('Ahmed','Ramez','Eman')

-- cancat_ws() -> CONCAT With Separator
-- It works like CONCAT(), but it automatically inserts a separator between each value.

select concat_ws('&' ,'Ahmed','Ali')

select concat_ws('& ' ,'ahmed','ali',quotename('khalid','"'),'eman') -- ahmed& ali& "khalid"& eman


select st_fname +' '+convert(varchar(20),st_age)
from student


select concat(st_fname,' ',st_age)  -- no null values all values convert to string
from student

-- concat convert anything to string

select concat('stud name = ' ,st_fname, ' &age= ',st_age)
from student

select string_agg(st_fname,',')   -- Concatenates multiple rows into a single string.
from student


select 'C#,MVC,HTML,JAVA'  --string


select *from string_split('C#,MVC,HTML,JAVA',',')  -- Splits a string into multiple rows.



select eid,ename,value
from mydata cross apply string_split (skills,',') -- CROSS APPLY executes STRING_SPLIT for each row.

--convert to string

select str('12')




--upper and lower case

select upper(st_fname),lower(st_fname)
from student

select len(st_fname),st_fname --length of string
from student


select*from student
select substring(st_fname,2,4)   -- Start from the second char and get 4 chars
from student


select substring(st_fname,1,len(st_fname)-1)from student



select*from student
where len(st_fname)>5

select left('ahmed',2)  -- Take 2 characters from the left side of the string.

select right('shrouq',2) -- Take 2 characters from the right side of the string.

select charindex('h','ahmedhassan') -- Returns the position of the first occurrence of the specified character.

select charIndex('A',st_fname) from student

select patIndex('%n','ahmedhassan')  -- Searches for a pattern using wildcard characters.




select replace ('ali/gmail.com','/','@') -- Replaces all occurrences of one substring with another.

select stuff('ahmedhassan',2,4,'li')  -- Deletes 4 characters starting at position 2, then inserts 'li'.


select trim('   ahmed   ') -- Remove spaces from right and left

select LTRIM('  ahme   ')  -- Remove from left

select Rtrim('     ahmed   ')  -- Remove from right 

select Reverse('ahmed')

select Replicate('ahmed',3)  -- Repeats the string the specified number of times.

