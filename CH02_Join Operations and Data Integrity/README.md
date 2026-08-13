## Chapter 2: Joins
This chapter covers **Joins, Self Joins, DML with Joins, the `LIKE` operator, Identity Columns, Data Deletion, and NULL Handling** using SQL Server.

---

# 1. Joins

A **JOIN** is used to combine rows from two or more tables based on a relationship between them.

## Cross Join

A `CROSS JOIN` produces the **Cartesian product** of two tables.

Every row from the first table is combined with every row from the second table.

```sql
SELECT Sname, Dname
FROM Student
CROSS JOIN Dept;
```

If there are 4 students and 4 departments:

```text
4 × 4 = 16 rows
```

There is no `ON` condition because a Cross Join does not require matching values.

The following is another way to write a Cross Join:

```sql
SELECT Sname, Dname
FROM Student, Dept;
```

When multiple tables are listed in `FROM` without a join condition, the result is a Cartesian product.

---

## Inner Join

An `INNER JOIN` returns only the rows that have matching values in both tables.

Example:

```sql
SELECT Sname, Dname
FROM Student s
INNER JOIN Dept d
    ON d.Did = s.Did;
```

Only students whose `Did` matches a department's `Did` are returned.

### Equi Join

An **Equi Join** is a join where the matching condition uses the equality operator `=`.

```sql
ON d.Did = s.Did
```

The previous example is therefore an Equi Join.

---

## Table Aliases

Aliases give tables shorter names and make queries easier to read.

```sql
SELECT sname, Dname
FROM Student s
INNER JOIN Dept d
    ON d.Did = s.Did;
```

Here:

```text
s → Student
d → Dept
```

Instead of repeatedly writing the complete table names, we can use their aliases.

---

## Adding Conditions to an INNER JOIN

A condition can be added to filter the result.

For example:

```sql
SELECT st_fname, dept_name
FROM Student s
INNER JOIN Department d
    ON d.dept_id = s.dept_id
WHERE st_age > 23;
```

For an `INNER JOIN`, a filtering condition can often be placed in either `ON` or `WHERE` and produce the same result:

```sql
ON d.dept_id = s.dept_id
   AND st_age > 23
```

or:

```sql
ON d.dept_id = s.dept_id
WHERE st_age > 23
```

However, this is **not generally interchangeable with OUTER JOINs**, where moving a condition between `ON` and `WHERE` can change the result.

---

# 2. Outer Joins

Outer joins allow us to keep rows even when there is no matching row in the other table.

## LEFT JOIN

A `LEFT JOIN` returns:

* All rows from the left table.
* Matching rows from the right table.
* `NULL` values for the right table when no match exists.

```sql
SELECT sname, dname
FROM Student s
LEFT OUTER JOIN Dept d
    ON d.Did = s.Did;
```

In this example, **all students** are returned, even if a student does not have a matching department.

---

## RIGHT JOIN

A `RIGHT JOIN` returns:

* All rows from the right table.
* Matching rows from the left table.
* `NULL` values for the left table when no match exists.

```sql
SELECT sname, dname
FROM Student s
RIGHT OUTER JOIN Dept d
    ON d.Did = s.Did;
```

Here, **all departments** are returned, even departments that do not have any students.

---

## FULL OUTER JOIN

A `FULL OUTER JOIN` returns:

* Matching rows from both tables.
* Unmatched rows from the left table.
* Unmatched rows from the right table.

Unmatched columns contain `NULL`.

```sql
SELECT sname, dname
FROM Student s
FULL OUTER JOIN Dept d
    ON d.Did = s.Did;
```

A simple way to remember it:

```text
FULL OUTER JOIN
= LEFT JOIN + RIGHT JOIN
```

---

# 3. Self Join

A **Self Join** occurs when a table is joined with itself.

It is useful when rows in a table have a relationship with other rows in the same table.

A common example is an employee-supervisor relationship.

```sql
CREATE TABLE Employee
(
    eid INT PRIMARY KEY,
    ename NVARCHAR(20),
    superid INT FOREIGN KEY REFERENCES Employee(eid)
);
```

Here, `superid` references `eid` from the **same table**.

This is called a **self-referencing foreign key**.

Example:

```text
Employee
────────────────
eid   ename    superid
1     Ahmed    NULL
2     Eman     1
3     Ali      1
4     Khalid   2
5     Nada     2
```

Ahmed is the supervisor of Eman and Ali.

Eman is the supervisor of Khalid and Nada.

---

## Self Join Using INNER JOIN

```sql
SELECT x.ename AS EmpName,
       y.ename AS SuperName
FROM Employee x
INNER JOIN Employee y
    ON y.eid = x.superid;
```

Although there is only one `Employee` table, we use two aliases:

```text
x → Employee (employee)
y → Employee (supervisor)
```

The condition:

```sql
y.eid = x.superid
```

means:

> Find the employee whose `eid` is stored in the current employee's `superid`.

---

## Self Join Using LEFT JOIN

```sql
SELECT x.ename AS EmpName,
       y.ename AS SuperName
FROM Employee x
LEFT JOIN Employee y
    ON y.eid = x.superid;
```

Using `LEFT JOIN` also returns employees who do not have a supervisor.

For example, Ahmed has:

```text
superid = NULL
```

so Ahmed will still appear, with `SuperName = NULL`.

---

## Finding All Supervisors

We can use `DISTINCT` to return each supervisor only once:

```sql
SELECT DISTINCT y.ename
FROM Employee x
INNER JOIN Employee y
    ON y.eid = x.superid;
```

---

# 4. Joins Across Multiple Tables

We can join more than two tables by following the relationships between them.

Example:

```sql
SELECT st_fname, crs_name, grade
FROM Student s
INNER JOIN Stud_Course sc
    ON s.st_id = sc.st_id
INNER JOIN Course c
    ON c.crs_id = sc.crs_id;
```

Here:

```text
Student
   ↓
Stud_Course
   ↓
Course
```

We can continue joining additional tables:

```sql
SELECT st_fname, crs_name, grade, dept_name
FROM Student s
INNER JOIN Stud_Course sc
    ON s.st_id = sc.st_id
INNER JOIN Course c
    ON c.crs_id = sc.crs_id
INNER JOIN Department d
    ON d.dept_id = s.dept_id;
```

A useful rule of thumb is:

```text
For N related tables, we often need N - 1 join relationships.
```

However, this is not a strict SQL rule. More complex queries can contain additional join conditions.

---

# 5. DML with Joins

Joins can also be used with `UPDATE` and `DELETE`.

## UPDATE

We can update rows in one table based on information from another table.

Example:

```sql
UPDATE stud_course
SET grade += 10
FROM Student s, stud_course sc
WHERE s.st_id = sc.st_id
  AND st_address = 'cairo';
```

The grades in `stud_course` are updated for students whose address is Cairo.

A simpler update can also use a condition directly:

```sql
UPDATE stud_course
SET grade += 10
WHERE st_id = 1;
```

---

## DELETE with JOIN

We can delete rows from one table based on a related table.

```sql
DELETE sc
FROM stud_course sc, Course c
WHERE c.crs_id = sc.crs_id
  AND crs_name = 'SQL Server';
```

Here, `sc` specifies that the rows to be deleted are from `stud_course`.

The `Course` table is used to determine which courses are related to those rows.

---

# 6. LIKE Operator

The `LIKE` operator is used for **pattern matching**.

SQL Server provides several pattern-matching characters.

## `%`

`%` represents **zero or more characters**.

### Starts with `a`

```sql
WHERE st_fname LIKE 'a%'
```

Examples:

```text
ahmed
ali
adel
```

### Ends with `a`

```sql
WHERE st_fname LIKE '%a'
```

### Contains `a`

```sql
WHERE st_fname LIKE '%a%'
```

---

## `_`

`_` represents **exactly one character**.

### Second character is `a`

```sql
WHERE st_fname LIKE '_a%'
```

The first character can be anything, but the second character must be `a`.

### Exactly three characters

```sql
WHERE st_fname LIKE '___'
```

Each `_` represents one character.

### At least three characters

```sql
WHERE st_fname LIKE '___%'
```

The first three characters must exist, and `%` allows any additional characters.

---

## Combining Characters

```sql
WHERE st_fname LIKE 'a%h'
```

Means:

> Starts with `a` and ends with `h`.

```sql
WHERE st_fname LIKE '%a_'
```

Means:

> The second-to-last character is `a`.

---

# 7. SQL Server LIKE Character Classes

SQL Server also supports character classes inside square brackets.

## `[abc]`

Matches **one character** from the specified set.

```sql
WHERE st_fname LIKE '[ahm]%'
```

The first character must be:

```text
a OR h OR m
```

---

## `[a-h]`

Matches one character within a range.

```sql
WHERE st_fname LIKE '[a-h]%'
```

The first character must be between `a` and `h`.

---

## `[^abc]`

Matches one character that is **not** in the specified set.

```sql
WHERE st_fname LIKE '[^ahm]%'
```

The first character cannot be:

```text
a, h, or m
```

---

## Searching for Special Characters

Square brackets can be used when we want to search for characters that have a special meaning in `LIKE`.

For example, to find a literal `%`:

```sql
WHERE st_fname LIKE '%[%]%'
```

To find a literal underscore:

```sql
WHERE st_fname LIKE '%[_]%'
```

The second pattern means:

> The string contains `_`.

---

## Important Correction

The following patterns from the original notes were incorrect:

```sql
LIKE '***'
LIKE '***%'
LIKE '********M********'
```

`*` is **not** the single-character wildcard in SQL Server `LIKE`.

Use `_` instead.

For example:

```sql
LIKE '___'
```

means exactly 3 characters.

And:

```sql
LIKE '_M%'
```

means the second character is `M`.

---

## Matching Multiple Characters

This pattern:

```sql
LIKE '[(ah)(am)]%'
```

does **not** mean "starts with `ah` or `am`".

If we want a string to start with either `ah` or `am`, we can write:

```sql
WHERE st_fname LIKE 'ah%'
   OR st_fname LIKE 'am%'
```

---

# 8. Identity Columns

An `IDENTITY` column automatically generates numeric values when new rows are inserted.

Syntax:

```sql
IDENTITY(seed, increment)
```

Example:

```sql
CREATE TABLE myemp
(
    id INT PRIMARY KEY IDENTITY(1,1),
    ename VARCHAR(20)
);
```

Here:

```text
1 → seed (starting value)
1 → increment
```

So the generated values will normally be:

```text
1, 2, 3, 4, 5, ...
```

Another example:

```sql
id INT IDENTITY(1,2)
```

generates:

```text
1, 3, 5, 7, 9, ...
```

---

# 9. Identity Gaps

Identity values are **not guaranteed to be continuous**.

For example:

```text
1
2
3
```

If the row with ID 3 is deleted, the next inserted row will normally receive:

```text
4
```

not 3.

Therefore:

> Identity columns are used to generate values automatically; they should not be relied upon for gap-free numbering.

---

# 10. IDENTITY_INSERT

Normally, SQL Server generates the identity value automatically.

If we need to insert our own identity value, we can temporarily enable `IDENTITY_INSERT`.

```sql
SET IDENTITY_INSERT myemp ON;
```

When using `IDENTITY_INSERT`, we must explicitly specify the identity column:

```sql
INSERT INTO myemp(id, ename)
VALUES (17, 'Eman');
```

Then turn it off:

```sql
SET IDENTITY_INSERT myemp OFF;
```

If the inserted value is greater than the current identity value, SQL Server updates the current identity value accordingly. Therefore, after inserting `17`, the next automatically generated value can be `18`.

---

# 11. Identity Functions

## `@@IDENTITY`

Returns the last identity value generated in the current session, regardless of scope.

It can be affected by an identity generated by a trigger.

---

## `SCOPE_IDENTITY()`

Returns the last identity value generated in the **current scope and session**.

It is generally safer than `@@IDENTITY` when we want the identity generated by our own `INSERT`.

```sql
SELECT SCOPE_IDENTITY();
```

---

## `IDENT_CURRENT()`

Returns the current identity value for a specific table.

```sql
SELECT IDENT_CURRENT('myemp');
```

It is not limited to the current session.

---

## `IDENT_INCR()`

Returns the increment value of the identity column.

```sql
SELECT IDENT_INCR('myemp');
```

For:

```sql
IDENTITY(1,2)
```

the result is:

```text
2
```

---

## `IDENT_SEED()`

Returns the seed (starting value).

```sql
SELECT IDENT_SEED('myemp');
```

For:

```sql
IDENTITY(1,2)
```

the result is:

```text
1
```

Remember:

```text
IDENT_SEED → starting value
IDENT_INCR → increment value
```

---

# 12. DELETE vs TRUNCATE vs DROP

These commands all remove data, but they have different effects.

| Command          | Removes Rows  | Keeps Table | WHERE Allowed | Resets Identity |
| ---------------- | ------------- | ----------- | ------------- | --------------- |
| `DELETE`         | Yes           | Yes         | Yes           | No              |
| `TRUNCATE TABLE` | Yes, all rows | Yes         | No            | Yes             |
| `DROP TABLE`     | Yes           | No          | No            | N/A             |

---

## DELETE

```sql
DELETE FROM Student
WHERE sid = 1;
```

`DELETE`:

* Removes rows.
* Supports `WHERE`.
* Keeps the table structure.
* Can remove selected rows or all rows.
* Is fully logged row-by-row.
* Can be rolled back when executed inside a transaction.

Without a `WHERE` condition:

```sql
DELETE FROM Student;
```

all rows are removed, but the table remains.

---

## TRUNCATE TABLE

```sql
TRUNCATE TABLE Student;
```

`TRUNCATE TABLE`:

* Removes all rows.
* Does not support `WHERE`.
* Keeps the table structure.
* Uses minimal logging compared with `DELETE`.
* Resets the identity counter.
* Can be rolled back when executed inside a transaction.

It is generally faster than `DELETE` when removing all rows from a large table.

`TRUNCATE TABLE` is commonly classified as a DDL operation because it deallocates data pages rather than deleting rows individually. It **does not remove or change the table definition**.

---

## DROP TABLE

```sql
DROP TABLE Student;
```

`DROP TABLE` removes:

* The table data.
* The table structure.
* The table itself.

After executing it, the table no longer exists.

---

# 13. Resetting an Identity

`DBCC CHECKIDENT` can be used to change the identity value.

```sql
DBCC CHECKIDENT('myemp', RESEED, 0);
```

When the table is empty, reseeding to `0` commonly causes the next generated identity value to be `1` when the increment is `1`.

The exact next generated value can depend on whether the table contains rows, so identity behavior should be checked for the specific situation.

---

# 14. NULL Handling

`NULL` represents a missing or unknown value.

## Checking for NULL

Use:

```sql
WHERE column IS NULL
```

or:

```sql
WHERE column IS NOT NULL
```

Do **not** use:

```sql
WHERE column = NULL
```

because `NULL` must be tested using `IS NULL` or `IS NOT NULL`.

Example:

```sql
SELECT st_fname
FROM Student
WHERE st_fname IS NOT NULL;
```

---

## ISNULL()

`ISNULL()` replaces a `NULL` value with another value.

```sql
SELECT ISNULL(st_fname, 'empty')
FROM Student;
```

If `st_fname` is NULL:

```text
NULL → 'empty'
```

It can also use another column as the replacement value:

```sql
SELECT ISNULL(st_fname, st_lname)
FROM Student;
```

This means:

> Return `st_fname` if it is not NULL; otherwise, return `st_lname`.

