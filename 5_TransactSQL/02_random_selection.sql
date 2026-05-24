-- Demonstrates how to select rows in random order using NEWID()

-- Add a random unique identifier to each row
SELECT *, NEWID() AS RandomID FROM Students;

-- Order all rows randomly
SELECT *, NEWID() AS RandomID FROM Students
ORDER BY RandomID;

-- Select a single random row
SELECT TOP(1) *
FROM Students
ORDER BY NEWID();

-- Create a table

create table trial
(
userid uniqueidentifier primary key default Newid(), 
username varchar(20)
)