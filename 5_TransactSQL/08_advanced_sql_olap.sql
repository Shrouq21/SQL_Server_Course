-- =========================================
-- GROUPING SETS
-- =========================================

-- Runs:
-- GROUP BY lid
-- UNION
-- GROUP BY lname

select lid,
       lname,
       SUM(lvalue) as total,
       grouping(lid) as llid,
       grouping(lname) as llname
from lastt
group by grouping sets(lid,lname)



-- =========================================
-- GROUPING SETS WITH ONE GROUP
-- =========================================

-- This means:
-- GROUP BY (lid,lname)

-- Notice:
-- Double parentheses ((lid,lname))
-- mean ONE grouping set containing BOTH columns

select lid,
       lname,
       SUM(lvalue) as total,
       grouping(lid) as llid,
       grouping(lname) as llname
from lastt
group by grouping sets((lid,lname))



-- =========================================
-- GROUPING SETS WITH GRAND TOTAL
-- =========================================

-- Runs:
-- GROUP BY lid
-- UNION
-- GROUP BY lname
-- UNION
-- GROUP BY ()

-- () means:
-- no grouping → grand total

select lid,
       lname,
       SUM(lvalue) as total,
       grouping(lid) as llid,
       grouping(lname) as llname
from lastt
group by grouping sets(lid,lname,())



-- =========================================
-- ROLLUP
-- =========================================

-- ROLLUP creates hierarchical aggregation

-- SQL internally generates:

-- GROUP BY (lid,lname,lvalue)
-- UNION
-- GROUP BY (lid,lname)
-- UNION
-- GROUP BY (lid)
-- UNION
-- GROUP BY ()

select lid,
       lname,
       lvalue,
       sum(lvalue) as total
from lastt
group by rollup (lid,lname,lvalue)



-- =========================================
-- CUBE
-- =========================================

-- CUBE generates ALL possible combinations

-- For 3 columns:
-- (lid,lname,lvalue)
-- (lid,lname)
-- (lid,lvalue)
-- (lname,lvalue)
-- (lid)
-- (lname)
-- (lvalue)
-- ()

select lid,
       lname,
       lvalue,
       sum(lvalue) as total
from lastt
group by cube (lid,lname,lvalue)



-- =========================================
-- PIVOT
-- =========================================

-- Converts rows into columns

-- lname values become columns:
-- [ahmed]
-- [eman]

-- lvalue becomes aggregated values

-- Remaining columns become grouping keys automatically

select *
from lastt
pivot(
    sum(lvalue)
    for lname in([ahmed],[eman])
) as pvt



-- =========================================
-- ANOTHER PIVOT EXAMPLE
-- =========================================

-- Creates columns:
-- [ahmed]
-- [khalid]

select *
from lastt
pivot(
    sum(lvalue)
    for lname in([ahmed],[khalid])
) as pv

-- UNPIVOT converts columns back into rows

select *
from EmployeeSales
unpivot(
    sales for salesman in([ahmed],[khalid])
) as unpvt