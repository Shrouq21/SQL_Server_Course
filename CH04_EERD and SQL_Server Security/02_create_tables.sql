
-- If the schema is not specified, SQL Server uses the user's default schema.
-- For many users this is dbo, but it is not guaranteed to be dbo.
CREATE TABLE dbo.Student
(
    Id INT PRIMARY KEY,
    EName VARCHAR(20)
);

--CREATE TABLE Student
--(
    --Id INT PRIMARY KEY,
   -- EName VARCHAR(20)
--);


-- Create table directly inside Sales schema
CREATE TABLE Sales.Student
(
    Id INT PRIMARY KEY,
    EName VARCHAR(20)
);
