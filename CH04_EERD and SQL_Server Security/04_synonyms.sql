-- A synonym is an alternative name for an existing database object.
-- It does NOT create a copy of the object.
CREATE SYNONYM Dept
FOR Sales.Department;


-- Usage
SELECT * FROM Dept;