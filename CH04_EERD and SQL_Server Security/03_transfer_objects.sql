-- Transfer Objects Between Schemas

-- Transfer Student table from dbo schema to HR schema
ALTER SCHEMA HR TRANSFER dbo.Student;


-- This moves the table from dbo schema to HR schema.
-- The table and its data are not recreated or deleted.
-- Its name becomes HR.Student.