# Chapter 4: SQL Schema and Security Management

 This Chapter introduces SQL Server concepts related to database organization and security:

* Creating schemas
* Creating tables in specific schemas
* Understanding the default `dbo` schema
* Transferring objects between schemas
* Creating synonyms
* Creating SQL Server logins and database users
* Granting permissions

---

## Schemas

Schemas are logical containers used to organize database objects such as:

* Tables
* Views
* Stored procedures
* Functions

A schema belongs to a **database** and provides a namespace for its objects.

Examples:

* `HR`
* `Sales`

```sql
CREATE SCHEMA HR;

CREATE SCHEMA Sales;
```

---

## Default Schema

If the schema is not explicitly specified when creating an object, SQL Server uses the user's **default schema**.

For example:

```sql
CREATE TABLE Student
(
    Id INT PRIMARY KEY,
    EName VARCHAR(20)
);
```

If the user's default schema is `dbo`, the table will be created as:

```text
dbo.Student
```

Therefore, specifying the schema explicitly is often clearer:

```sql
CREATE TABLE dbo.Student
(
    Id INT PRIMARY KEY,
    EName VARCHAR(20)
);
```

> The default schema is not necessarily `dbo`; it depends on the user's configuration.

---

## Creating Tables in Specific Schemas

A table can be created directly inside a specific schema by specifying the schema name:

```sql
CREATE TABLE Sales.Student
(
    Id INT PRIMARY KEY,
    EName VARCHAR(20)
);
```

This creates the table:

```text
Sales.Student
```

The schema becomes part of the object's full name.

---

## Object Transfer

Objects can be transferred between schemas using:

```sql
ALTER SCHEMA TargetSchema
TRANSFER SourceSchema.ObjectName;
```

Example:

```sql
ALTER SCHEMA HR
TRANSFER dbo.Student;
```

This changes the table from:

```text
dbo.Student
```

to:

```text
HR.Student
```

The table is not recreated, and its data is not deleted. The object is simply transferred from one schema to another.

Other examples:

```sql
ALTER SCHEMA HR
TRANSFER dbo.Instructor;

ALTER SCHEMA Sales
TRANSFER dbo.Department;
```

---

## Synonyms

A **synonym** is an alternative name for an existing database object.

It does **not** create a copy of the object.

Example:

```sql
CREATE SYNONYM Dept
FOR Sales.Department;
```

The original object is:

```text
Sales.Department
```

It can now also be accessed using:

```sql
SELECT * FROM Dept;
```

The synonym is only another name that points to the existing object.

> The target object must already exist when creating the synonym.

---

## Logins and Users

SQL Server separates authentication at the server level from access inside a database.

### Login

A **login** is created at the SQL Server level and is used to authenticate a person or application.

### User

A **user** is created inside a specific database and is associated with a login.

In simple terms:

```text
Login → SQL Server
User  → Database
```

A login can be mapped to a user in a database.

---

## Permissions

Permissions determine what a user is allowed to do with database objects.

Common permissions include:

* `SELECT` — read data
* `INSERT` — add data
* `UPDATE` — modify data
* `DELETE` — remove data

Example:

```sql
GRANT SELECT
ON dbo.Student
TO UserName;
```

This allows `UserName` to read data from the `dbo.Student` table.

Permissions can be granted on different database objects depending on the required access.

