-- Select any 2 rows
-- Without ORDER BY, SQL Server does not guarantee which rows are returned
SELECT TOP(2) * FROM Students;

-- Select all rows
SELECT * FROM Students;

-- Select top 5 names
SELECT TOP(5) FullName FROM Students;

-- Select top row with a condition
SELECT TOP(1) * 
FROM Students 
WHERE Age >= 24;

-- Select top 2 rows ordered by age descending
SELECT TOP(2) FirstName, Age
FROM Students
ORDER BY Age DESC;

-- Select the top 3 rows, including any additional rows tied
-- with the 3rd row according to the ORDER BY column(s)
SELECT TOP(3) WITH TIES *
FROM Students
ORDER BY Age DESC;