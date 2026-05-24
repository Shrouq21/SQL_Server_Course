-- =========================================
-- SHOW CURRENT SQL SERVER USER
-- =========================================

-- SUSER_NAME() returns the currently logged-in SQL Server user

SELECT SUSER_NAME();



-- =========================================
-- ACCESS TABLE FROM ANOTHER DATABASE
-- =========================================

-- Full qualified name format:
-- Server.Database.Schema.Table

-- Here:
-- Server   = LAPTOP-GPED28K3
-- Database = ITI
-- Schema   = HR
-- Table    = Student

select *
from [LAPTOP-GPED28K3].[ITI].HR.Student



-- =========================================
-- ACCESS TABLE FROM Company_SD DATABASE
-- =========================================

-- dbo = default schema in SQL Server

select Dname
from [Company_SD].[dbo].[Departments]



-- =========================================
-- ACCESS TABLE FROM ITI DATABASE
-- =========================================

select Did
from [ITI].[dbo].[Dept]