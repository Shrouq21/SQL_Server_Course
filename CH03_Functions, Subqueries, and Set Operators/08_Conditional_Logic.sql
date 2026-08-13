-- Mathematical Functions:
-- ABS, FLOOR, CEILING, ROUND, SQRT, POWER, RAND

-- Logical Functions:
-- ISDATE, ISNUMERIC


 select abs(-5)

 select floor(123.888)
 select ceiling(123.8)

 select round(123.875433,2)

 select sqrt(25)

 select square(7)


 
 select power(salary,3)
 from instructor


 select rand()  --random number



 select isdate('1/1/2000')


 select isnumeric('ahmed')

 select isnumeric('12')


 select choose(3,'ahmed','ali','omar','khalid') -- (index,idx1,idx2,idx3,idx4) ->'omar'=index 3

 -- CASE is used for conditional logic
-- Similar to if-else statements

 select*from instructor

 select ins_name,salary
 from instructor

 select ins_name, 'Value'=
          case 
		  when salary>=3000 then 'high salary'
		  when salary<3000 then 'low'
		  else 'no data'
		  end 
from instructor


 select ins_name, 
          case 
		  when salary>=3000 then 'high salary'
		  when salary<3000 then 'low'
		  else 'no data'
		  end  as crt
from instructor


select ins_name,
       case gender
	   when 'f' then 'female'
	   when 'M' then 'male'
	   end as gend
from instructor


-- Increase salary based on conditions:
-- High salary gets 20% increase
-- Low salary gets 10% increase


select ins_name,iif(salary>=3000 ,' high','low ')
from instructor

-- Increase the salary of every instructor by 20%.
update instructor
  set salary=salary*1.20

update instructor
set salary= 
     case 
	     when salary>=3000 then salary*1.20
		 else salary*1.10
	end