-- Demonstrates different ways to insert data

-- Create a simple table
CREATE TABLE People
(
    ID INT PRIMARY KEY,
    Name VARCHAR(50)
);

-- Insert a single row
INSERT INTO People VALUES (1, 'Alice');

-- Insert multiple rows at once
INSERT INTO People VALUES (2, 'Bob'), (3, 'Charlie'), (4, 'Diana');

-- Insert rows from another table
INSERT INTO People (ID, Name)
SELECT StudentID, FirstName
FROM Students
WHERE Age > 28;