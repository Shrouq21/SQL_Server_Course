-- Demonstrates how to select the top N rows from a table

-- Select the first 2 rows
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

-- Select top 3 rows including ties (rows with the same age as the 3rd row)
SELECT TOP(3) WITH TIES *
FROM Students
ORDER BY Age DESC;