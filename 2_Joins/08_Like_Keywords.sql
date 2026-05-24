--  Keywords and Like operator

select * from student
where st_fname='ahmed'
select * from student where st_fname like 'Ahmed'


SELECT * FROM student WHERE st_fname LIKE 'a%'   -- starts with 'a'
SELECT * FROM student WHERE st_fname LIKE '%a'   -- ends with 'a'
SELECT * FROM student WHERE st_fname LIKE '%a%'  -- contains 'a'
SELECT * FROM student WHERE st_fname LIKE '_a%'  -- second char is 'a'

SELECT * FROM student WHERE st_fname LIKE 'a%h'  -- starts with 'a' and ends with 'h'
SELECT * FROM student WHERE st_fname LIKE '%a_'  -- char before last is 'a'
SELECT * FROM student WHERE st_fname LIKE '___'  -- word with exactly 3 chars
SELECT * FROM student WHERE st_fname LIKE '_M__' -- second char is 'M'
SELECT * FROM student WHERE st_fname LIKE '___%' -- word with 3 chars or more
SELECT * FROM student WHERE st_fname LIKE 'ahm%' -- starts with 'ahm'
SELECT * FROM student WHERE st_fname LIKE '[ahm]%' -- starts with 'a', 'h', or 'm'
SELECT * FROM student WHERE st_fname LIKE '[^ahm]%' -- does not start with 'a', 'h', or 'm'
SELECT * FROM student WHERE st_fname LIKE '[a-h]%' -- starts with letters a to h
SELECT * FROM student WHERE st_fname LIKE '[^a-h]%' -- does not start with letters a to h
SELECT * FROM student WHERE st_fname LIKE '[(ah)(am)]%' -- starts with 'ah' or 'am'
SELECT * FROM student WHERE st_fname LIKE '%[%]' -- contains '%'
SELECT * FROM student WHERE st_fname LIKE '%[_]%' -- contains '_', e.g., 'ahmed_mohamed'