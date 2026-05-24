# What `TOP` Does

`TOP(n)` selects the first `n` rows from the result set.

Example:

```sql
SELECT TOP(3) *
FROM Students;
```

This returns any 3 rows based on the database's current retrieval order.

## Why `ORDER BY` Is Important

A database table has no guaranteed order unless `ORDER BY` is used.

So SQL needs `ORDER BY` to know:

* which rows are highest,
* lowest,
* first,
* or last.

Example:

```sql
SELECT TOP(3) *
FROM Students
ORDER BY Age DESC;
```

This means:

1. Sort students by age from highest to lowest.
2. Return the first 3 rows.

## What `WITH TIES` Does

`WITH TIES` includes additional rows that have the same value as the last selected row according to the `ORDER BY` column.

Example:

```sql
SELECT TOP(3) WITH TIES *
FROM Students
ORDER BY Age DESC;
```

Suppose the data is:

| Name | Age |
| ---- | --- |
| Ali  | 25  |
| Sara | 24  |
| Mona | 24  |
| Adam | 24  |
| Omar | 22  |

After sorting by `Age DESC`:

1. Ali → 25
2. Sara → 24
3. Mona → 24

The 3rd row has age `24`.

`WITH TIES` adds all rows tied with `24`, so Adam is included too.

Final result:

| Name | Age |
| ---- | --- |
| Ali  | 25  |
| Sara | 24  |
| Mona | 24  |
| Adam | 24  |


## Why `WITH TIES` Requires `ORDER BY`

`WITH TIES` must compare rows using a specific column.

Without `ORDER BY`, SQL would not know:

* what values should be compared,
* or what "tied" means.

That is why this is invalid:

```sql
SELECT TOP(3) WITH TIES *
FROM Students;
```
SQL requires `ORDER BY` when using `WITH TIES`.

# Creating an Empty Table Using `SELECT INTO`

You can create a new table with the same structure as an existing table without copying any data by using a condition that is always false.



## Example

```sql
SELECT * INTO EmptyStudents
FROM Students
WHERE 1 = 2;
```

## How It Works

- `SELECT * INTO` creates a new table based on the selected columns.
- The condition:

```sql
WHERE 1 = 2
```

is always false.

- Since the condition is false:
  - no rows are copied
  - but SQL still creates the table structure.


## What Gets Copied?

The new table will contain:
- column names
- data types
- column order

But it will NOT copy:
- data
- primary keys
- foreign keys
- constraints
- indexes

---


# `UNIQUEIDENTIFIER`

`UNIQUEIDENTIFIER` is a special SQL Server data type used to store a GUID (Globally Unique Identifier).

Each GUID is globally unique, meaning it will never repeat across:
- tables
- databases
- servers
- systems

It is commonly used when strong uniqueness is needed instead of sequential integers like:

```text
1, 2, 3, 4
```



## Example GUID

```text
3F2504E0-4F89-11D3-9A0C-0305E82C3301
```

---

# `NEWID()`

`NEWID()` is a SQL Server function that generates a random GUID every time it is called.



## Example

```sql
SELECT NEWID();
```

Possible output:

```text
6F9619FF-8B86-D011-B42D-00CF4FC964FF
```



# `DEFAULT NEWID()`

When used with `DEFAULT`, SQL Server automatically generates a GUID if no value is provided during insertion.



## Example Table

```sql
CREATE TABLE MyUsers (
    userid UNIQUEIDENTIFIER DEFAULT NEWID(),
    username VARCHAR(50),
    _password VARCHAR(50)
);
```


## Example Insert

```sql
INSERT INTO MyUsers (username, _password)
VALUES ('Ali', '1234');
```

---

## What Happens?

Since no `userid` was provided:
- SQL Server automatically calls `NEWID()`
- a unique GUID is inserted into `userid`


# Why Use GUIDs?

## Advantages

- globally unique
- safe for distributed systems
- useful for replication and synchronization
- avoids ID collisions between databases



## Disadvantages

- larger than integers
- slower indexing compared to integer IDs
- harder to read manually

---

# Fully Qualified Table Name in SQL Server

SQL Server can identify database objects using the full naming structure:

```text
ServerName.DatabaseName.SchemaName.TableName
```

---

# Example

```sql
SELECT *
FROM [LAPTOP-GPED28K3].[ITI].HR.Student;
```


# Order Explanation

| Part | Meaning |
|---|---|
| `LAPTOP-GPED28K3` | Server Name |
| `ITI` | Database Name |
| `HR` | Schema Name |
| `Student` | Table Name |


# Important Notes

## Server Name
Represents the SQL Server instance.


## Database Name
The database containing the table.



## Schema Name
A logical container used to organize database objects.

Common schemas:
- `dbo`
- `HR`
- `Sales`



## Table Name
The actual table being queried.



# Why Use Fully Qualified Names?

Useful when:
- accessing tables from another database
- working with linked servers
- avoiding ambiguity between objects
- organizing large systems



# Summary

- `SELECT INTO` can create an empty table structure.
- `UNIQUEIDENTIFIER` stores globally unique IDs.
- `NEWID()` generates random GUIDs.
- `DEFAULT NEWID()` auto-generates IDs during insertion.
- SQL Server object naming follows:

```text
Server.Database.Schema.Table
```

---

#  Window Functions

SQL window functions allow you to perform calculations **across related rows without collapsing the result set**.

Unlike `GROUP BY`, window functions keep all rows and add extra computed columns.




##  Syntax

```sql
FUNCTION() OVER (
    PARTITION BY column
    ORDER BY column
)
```


##  Key Parts

###  OVER()
Defines a window function.



###  PARTITION BY
Splits data into groups (without removing rows).




###  ORDER BY (inside OVER)
Defines order inside each group.

Used for:
- ranking
- sequencing
- comparisons between rows



#  Ranking Functions



##  ROW_NUMBER()

Assigns a unique number to each row.

```sql
ROW_NUMBER() OVER (
    PARTITION BY Crs_Duration
    ORDER BY Top_Id
)
```

###  Features:
- always unique
- restarts per partition



##  RANK()

Assigns ranks but skips numbers for ties.

```sql
RANK() OVER (ORDER BY salary DESC)
```

### Example:
```
1, 1, 3, 4
```



##  DENSE_RANK()

Like `RANK()` but without gaps.

### Example:
```
1, 1, 2, 3
```



##  NTILE(n)

Splits rows into equal groups.

```sql
NTILE(3) OVER (ORDER BY Crs_Duration)
```

 Used for:
- quartiles
- segmentation
- distribution analysis

---

#  Analytical Functions



##  LAG()

Gets the previous row value.

```sql
LAG(Crs_Name) OVER (ORDER BY Top_Id)
```

 “What was before me?”



##  LEAD()

Gets the next row value.

```sql
LEAD(Crs_Name) OVER (ORDER BY Top_Id)
```

 “What comes after me?”



##  FIRST_VALUE()

Returns the first value in the window.

```sql
FIRST_VALUE(Crs_Name) OVER (ORDER BY Top_Id)
```

 Always returns the first row in the ordered window.



##  LAST_VALUE()

Returns the last value in the window.

 Requires full window frame:

```sql
LAST_VALUE(Crs_Name) OVER (
    ORDER BY Top_Id
    ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
)
```

 Ensures SQL considers the entire partition.



##  PERCENT_RANK()

Shows relative position between 0 and 1.

```sql
PERCENT_RANK() OVER (ORDER BY grade)
```

### Formula:
```
(rank - 1) / (total_rows - 1)
```



### Example (6 rows):

| Rank | Percent |
|------|--------|
| 1    | 0.0    |
| 2    | 0.2    |
| 3    | 0.4    |
| 4    | 0.6    |
| 5    | 0.8    |
| 6    | 1.0    |


#  DECIMAL(p, s) in SQL

The `DECIMAL` (or `NUMERIC`) data type is used to store numbers with exact precision, especially in financial and analytical calculations.



#  Syntax

```sql
DECIMAL(precision, scale)
```


# Meaning of Parameters

##  Precision (p)

- Total number of digits allowed
- Includes digits before and after the decimal point

##  Scale (s)

- Number of digits allowed **after the decimal point**



#  Example: DECIMAL(18,2)
```sql
DECIMAL(18,2)
```

### Meaning:
- 18 total digits
- 2 digits after the decimal point



### Example Value:

```
1234567890123456.78
```

 Total digits = 18  
 Decimal digits = 2  


#  Simple Intuition

Think of it like a box:

```
[__________________].[__]
   18 total digits     2 decimals
```

- Left side → whole number part
- Right side → decimal part


#  Why 18 is commonly used

- Standard size in SQL Server
- Safe for financial and percentage calculations
- Supports large numbers without overflow



#  More Examples

## DECIMAL(5,2)

```
123.45
```

## DECIMAL(10,3)

```
1234567.890
```

---

#  Important Note

If you exceed the precision:

- SQL will throw an error
- or truncate the value depending on configuration

---

#  GROUP BY vs PARTITION BY



##  GROUP BY

###  Purpose:
Aggregates and **reduces rows**

```sql
SELECT Crs_Duration, COUNT(*)
FROM course
GROUP BY Crs_Duration;
```

### Output:
| Crs_Duration | Count |
|--------------|-------|
| 30           | 5     |
| 60           | 3     |

 One row per group



##  PARTITION BY

###  Purpose:
Keeps all rows but adds calculations

```sql
SELECT *,
       COUNT(*) OVER (PARTITION BY Crs_Duration) AS cnt
FROM course;
```

### Output:
| Crs_Duration | Top_Id | cnt |
|--------------|--------|-----|
| 30           | 1      | 5   |
| 30           | 2      | 5   |

 Same rows + extra info



##  Key Difference

| Feature | GROUP BY | PARTITION BY |
|--------|----------|--------------|
| Keeps rows |  No |  Yes |
| Output type | Summary | Detailed |
| Used with | Aggregates | Window functions |


#  Quick Summary

-  `GROUP BY` → compress data
-  `PARTITION BY` → analyze data without losing rows
-  Window functions → perform row-based calculations
-  ORDER BY inside OVER → defines calculation order

---
 
#  SQL MERGE Statement (Update + Insert in One Query)

The `MERGE` statement is used to **synchronize two tables** by performing:
- UPDATE existing rows
- INSERT new rows

All in a single query.



#  Idea

> Compare two tables and decide:
- If a row exists → update it
- If a row does not exist → insert it



#  Tables Used

##  Target Table (Main Table)

```sql
lastt
```

##  Source Table (New Data)

```sql
dailyt
```



#  MERGE Syntax

```sql
MERGE INTO lastt AS T
USING dailyt AS S
ON T.Lid = S.dlid
```



#  Step 1: Matching Condition

```sql
ON T.Lid = S.dlid
```

 This is the key comparison rule:
> Match rows using IDs



#  Step 2: WHEN MATCHED → UPDATE

```sql
WHEN MATCHED THEN
UPDATE
SET T.lvalue = T.lvalue + S.dvalue
```

### Meaning:

If the row exists in BOTH tables:
- Update the existing value
- Add new value to old value



### Example:

Before:

| Lid | Value |
|-----|-------|
| 1   | 10    |

Source:

| dlid | value |
|------|-------|
| 1    | 5     |

After:

| Lid | Value |
|-----|-------|
| 1   | 15    |



#  Step 3: WHEN NOT MATCHED → INSERT

```sql
WHEN NOT MATCHED THEN
INSERT VALUES (S.dlid, S.dname, S.dvalue)
```

### Meaning:

If row exists in source but NOT in target:
> Insert it into target table



#  Step 4: OUTPUT Clause

```sql
OUTPUT $action;
```

### Meaning:

Shows what SQL did:

| Action |
|--------|
| INSERT |
| UPDATE |

---

#  Execution Flow

For each row in `dailyt`:

1. Check if ID exists in `lastt`
2. If YES → UPDATE
3. If NO → INSERT

---

#  SQL OLAP Operations (Grouping Sets, Rollup, Cube, Pivot, Unpivot)

This section explains advanced SQL aggregation techniques used in analytical queries.



#  1. GROUPING SETS

##  Idea

Run multiple GROUP BY queries in one statement.



## Example

```sql
SELECT Productid AS pid, SUM(quantity) AS quantities
FROM sales
GROUP BY GROUPING SETS (Productid, salesmanname);
```



##  Meaning

This is equivalent to:

```sql
GROUP BY Productid
UNION ALL
GROUP BY salesmanname
```



##  Output logic

- One aggregation per Productid
- One aggregation per salesmanname


#  2. GROUPING() Function

```sql
GROUPING(salesmanname)
GROUPING(productid)
```



##  Meaning

| Value | Meaning |
|------|--------|
| 0 | real value |
| 1 | aggregated (NULL due to grouping) |



##  Why useful?

It helps you detect:
- real rows
- summary rows



# 🔷 3. ROLLUP

```sql
GROUP BY ROLLUP(salesmanname, productid)
```



##  Idea

Creates hierarchical aggregation:

```text
Level 1: salesmanname + productid
Level 2: salesmanname total
Level 3: grand total
```



## Equivalent:

```sql
GROUP BY salesmanname, productid
UNION
GROUP BY salesmanname
UNION
GROUP BY ()
```


#  4. CUBE

```sql
GROUP BY CUBE(salesmanname, productid)
```



##  Idea

Generates **ALL combinations** of grouping:

- salesmanname
- productid
- both
- none



## Equivalent (conceptually):

```text
GROUP BY A, B
GROUP BY A
GROUP BY B
GROUP BY ()
```



##  Difference from ROLLUP

| Feature | ROLLUP | CUBE |
|--------|--------|------|
| Type | Hierarchical | All combinations |
| Output | Less rows | More rows |



#  5. PIVOT

##  Idea

Turns rows into columns.



## Example

```sql
SELECT *
FROM sales
PIVOT (
    SUM(quantity)
    FOR salesmanname IN ([ahmed],[khalid],[omar])
) AS pvt;
```



##  Meaning

| salesmanname | becomes |
|-------------|--------|
| ahmed       | column |
| khalid      | column |
| omar        | column |



## Result shape

| Productid | ahmed | khalid | omar |
|----------|------|--------|------|



#  6. PIVOT with Derived Table

```sql
SELECT *
FROM (
    SELECT CAST(productid AS VARCHAR(10)) AS productid,
           salesmanname,
           quantity
    FROM sales
) AS t
PIVOT (
    SUM(quantity)
    FOR salesmanname IN ([ahmed],[ali],[khalid])
) AS pvt;
```



##  Why subquery?

Because:
> PIVOT requires a clean dataset format



# 7. UNPIVOT

##  Idea

Opposite of PIVOT:
> Converts columns → rows


## Example

```sql
SELECT *
FROM ntable
UNPIVOT (
    qty FOR sal IN ([ahmed],[khalid],[ali])
) AS unpvt;
```



##  Meaning

| Column | becomes |
|--------|--------|
| ahmed | row |
| khalid | row |
| ali | row |



## Result shape

| productid | sal | qty |
|----------|-----|-----|



#  Summary Table

| Feature | Purpose |
|--------|--------|
| GROUPING SETS | multiple GROUP BY in one query |
| ROLLUP | hierarchical totals |
| CUBE | all combinations |
| PIVOT | rows → columns |
| UNPIVOT | columns → rows |


