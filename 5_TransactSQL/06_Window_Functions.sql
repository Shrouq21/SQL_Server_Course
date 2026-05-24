--  NTILE(): Splits rows into equal groups (tiles)

-- Divide all courses into 3 groups based on Top_Id order
select *,
       NTILE(3) over(order by Top_Id asc) as NT
from Course;

-- Same idea but selecting specific columns only
select Crs_Id, Crs_Name,
       NTILE(3) over(order by Top_Id asc) as NT
from Course;



--  RANK(): Ranking with gaps when ties exist


-- Rank inside each Crs_Duration group
-- Ties get same rank, but next rank is SKIPPED
select *,
       RANK() over(partition by Crs_Duration order by Top_id asc) as R
from Course;

-- Same but selecting only important columns
select Crs_Id, Crs_Name,
       RANK() over(partition by Crs_Duration order by Top_id asc) as R
from Course;



--  DENSE_RANK(): Ranking WITHOUT gaps


-- Same as RANK but no skipping numbers after ties
select *,
       DENSE_RANK() over(partition by Crs_Duration order by Top_id asc) as R
from Course;



--  ROW_NUMBER(): Unique numbering per partition


-- Always gives unique sequence numbers per Crs_Duration group
select *,
       ROW_NUMBER() over(partition by Crs_Duration order by Top_id asc) as R
from Course;



--  LAG & LEAD: Previous and next row values


-- Without partition: works across entire table
select *,
       LAG(Crs_Name)  over(order by Top_id) as _prev,
       LEAD(Crs_Name) over(order by Top_id) as _Next
from Course;

-- With partition: works inside each Crs_Duration group only
select *,
       LAG(Crs_Name)  over(partition by Crs_Duration order by Top_id) as _prev,
       LEAD(Crs_Name) over(partition by Crs_Duration order by Top_id) as _Next
from Course;



--  FIRST_VALUE & LAST_VALUE


-- FIRST_VALUE = first row in ordered window
-- LAST_VALUE = last row in window (needs full frame)

select *,
       LAST_VALUE(Crs_Duration) over(
           order by Top_id desc
           rows between unbounded preceding and unbounded following
       ) as _Last,

       FIRST_VALUE(Crs_Duration) over(
           order by Top_id asc
       ) as _first
from Course;



--  PERCENT_RANK(): position between 0 and 1


-- Relative rank inside each Crs_Duration group
select *,
       PERCENT_RANK() over(partition by Crs_Duration order by Top_id) as percent_
from Course;

-- Same but forcing precision formatting
select *,
       CAST(
           PERCENT_RANK() over(partition by Crs_Duration order by Top_id)
           as decimal(18,4)
       ) as _percent
from Course;