-- =============================================
-- Create Login and Database User
-- =============================================

-- Create SQL Server login
CREATE LOGIN Login1
WITH PASSWORD = 'StrongPassword123';

-- Switch to target database
USE YourDatabaseName;


-- Create database user mapped to login
CREATE USER Login1
FOR LOGIN Login1;


-- Grant SELECT permission on Student table
GRANT SELECT
ON dbo.Student
TO Login1;
