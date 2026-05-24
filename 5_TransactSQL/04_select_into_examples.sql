-- Demonstrates creating new tables from SELECT statements

-- Create a new table with all columns
SELECT * INTO NewStudents FROM Students;

-- Create a new table with selected columns
SELECT FirstName, LastName INTO AdultStudents
FROM Students
WHERE Age > 24;

-- Create an empty table with the same structure
SELECT * INTO EmptyStudents
FROM Students
WHERE 1=2;