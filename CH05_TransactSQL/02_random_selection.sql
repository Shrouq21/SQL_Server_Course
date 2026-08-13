-- NEWID() generates a uniqueidentifier value for each row
-- It can be used to randomize the order of rows
SELECT *, NEWID() AS RandomID
FROM Students;

-- Order all rows randomly
SELECT *, NEWID() AS RandomID FROM Students
ORDER BY RandomID;

-- Select a single random row
SELECT TOP(1) *
FROM Students
ORDER BY NEWID();

-- If userid is not provided during INSERT,
-- SQL Server automatically generates a uniqueidentifier using NEWID()

create table trial
(
userid uniqueidentifier primary key default Newid(), 
username varchar(20)
)