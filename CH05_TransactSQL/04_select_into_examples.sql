-- SELECT INTO creates a new table and copies the selected data into it.
-- It does NOT copy all constraints, indexes, triggers, etc. from the original table.
SELECT * INTO NewStudents FROM Students;

-- Create a new table with selected columns
SELECT FirstName, LastName INTO AdultStudents
FROM Students
WHERE Age > 24;

-- WHERE 1=2 is always false, so no rows are copied.
-- The new table is created with the selected column structure.
SELECT * INTO EmptyStudents
FROM Students
WHERE 1=2;