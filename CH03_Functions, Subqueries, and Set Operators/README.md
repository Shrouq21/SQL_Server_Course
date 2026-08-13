# Chapter 3: Advanced SQL Queries, Aggregations, and Built-in Functions

This chapter introduces advanced SQL concepts commonly used for data analysis, reporting, and real-world database applications. It covers aggregate functions, grouping, subqueries, set operators, built-in functions, string manipulation, date handling, and conditional logic.

---

# 1. Aggregate Functions

Aggregate functions perform calculations over multiple rows and return a single result.

## Common Aggregate Functions

* `COUNT()`
* `SUM()`
* `AVG()`
* `MIN()`
* `MAX()`

## Important Notes

* Aggregate functions always use parentheses.
* Most aggregate functions ignore `NULL` values.
* `COUNT(*)` counts **all rows**, including rows containing `NULL` values.
* `COUNT(column)` counts only **non-NULL** values.
* `AVG(column)` calculates the average using only non-NULL values.
* Aggregate functions may become expensive on very large datasets because SQL Server must process many rows.

## Handling NULL Values

If `NULL` should be treated as zero during calculations:

```sql
AVG(ISNULL(Salary, 0))
```

Another approach is:

```sql
SUM(Salary) / COUNT(*)
```

However, `AVG()` is generally simpler and preferred unless different behavior is required.

---

# 2. GROUP BY

The `GROUP BY` clause groups rows that share the same values and produces one summarized row for each group.

## Rules

* Any selected column that is **not inside an aggregate function** must appear in the `GROUP BY` clause.
* Each group produces one summarized result row.

Example:

```sql
SELECT Dept_ID, COUNT(*)
FROM Student
GROUP BY Dept_ID;
```

---

# 3. WHERE vs HAVING

Filtering occurs at different stages of query execution.

| Clause   | Purpose                       |
| -------- | ----------------------------- |
| `WHERE`  | Filters rows before grouping  |
| `HAVING` | Filters groups after grouping |

## Important Notes

* `WHERE` cannot contain aggregate functions.
* `HAVING` is commonly used with aggregate functions.
* `GROUP BY` can be used without `HAVING`.
* `HAVING` can also be used without `GROUP BY`. In this case, SQL Server treats the entire result set as one group.

---

# 4. SQL Query Execution Order

Although SQL is written from top to bottom, SQL Server executes clauses in the following order:

1. `FROM`
2. `JOIN`
3. `WHERE`
4. `GROUP BY`
5. `HAVING`
6. `SELECT`
7. `ORDER BY`
8. `TOP`

Understanding this order explains why:

* Column aliases cannot be used in the `WHERE` clause.
* Aggregate functions cannot be used in `WHERE`.

---

# 5. Subqueries

A subquery is a query nested inside another SQL query.

## Key Concepts

* The inner query executes first.
* The outer query uses the result produced by the inner query.
* A subquery may return:

  * A single value
  * Multiple values
  * A table

## Multiple-Value Subqueries

When a subquery returns multiple values, use operators such as:

* `IN`
* `NOT IN`
* `ANY`
* `ALL`

instead of `=`.

---

# 6. Derived Tables

A derived table is the result of a subquery placed inside the `FROM` clause.

Example:

```sql
SELECT *
FROM (
    SELECT St_Fname + ' ' + St_Lname AS FullName
    FROM Student
) AS Students;
```

## Rules

* Every derived table **must have an alias**.
* SQL Server treats it as a temporary table during query execution.
* Derived tables are useful when filtering or querying computed columns.

---

# 7. Subqueries vs JOIN

Many problems can be solved using either subqueries or joins.

## Notes

* SQL Server's optimizer often produces similar execution plans for equivalent subqueries and joins.
* `JOIN` statements are often easier to read and maintain.
* Subqueries are useful when the logic is naturally expressed in multiple steps.

---

# 8. Set Operators

Set operators combine the results of multiple queries.

## UNION

Combines result sets and removes duplicate rows.

## UNION ALL

Combines result sets while keeping duplicate rows.

Usually faster than `UNION` because no duplicate removal is required.

## INTERSECT

Returns only rows that appear in both queries.

## EXCEPT

Returns rows that exist in the first query but not in the second.

## Rules

* Every query must return the same number of columns.
* Corresponding columns must have compatible data types.
* Column names are taken from the first `SELECT`.
* `ORDER BY` can appear only once, after the final query.

---

# 9. System Functions

System functions provide information about the current SQL Server environment.

Examples include:

* `DB_NAME()`
* `SUSER_NAME()`
* `HOST_NAME()`

These functions are commonly used for administration and debugging.

---

# 10. Date and Time Functions

Date functions simplify working with dates and times.

## Topics Covered

* Retrieving the current date and time
* Extracting year, month, and day
* Calculating date differences
* Adding or subtracting time intervals
* Finding the last day of a month
* Validating dates
* Formatting dates

Common functions include:

* `GETDATE()`
* `YEAR()`
* `MONTH()`
* `DAY()`
* `DATEPART()`
* `DATENAME()`
* `DATEDIFF()`
* `DATEADD()`
* `DATEFROMPARTS()`
* `ISDATE()`
* `EOMONTH()`
* `FORMAT()`
* `CAST()`
* `CONVERT()`

---

# 11. NULL Handling Functions

Proper NULL handling is essential in SQL.

## ISNULL

Replaces a NULL value with another value.

```sql
ISNULL(Salary, 0)
```

Characteristics:

* Accepts exactly two arguments.
* Returns the data type of the first argument.
* SQL Server-specific.

---

## COALESCE

Returns the first non-NULL value from a list.

```sql
COALESCE(HomePhone, MobilePhone, OfficePhone, 'No Phone')
```

Characteristics:

* Accepts two or more arguments.
* ANSI SQL standard.
* Useful when multiple fallback values are required.

### Data Type Behavior

`COALESCE` returns the data type with the **highest precedence** among its arguments.

If different data types are mixed, SQL Server performs implicit conversion, which may produce errors.

To avoid this, explicitly cast values when necessary.

---

## NULLIF

Returns `NULL` if two expressions are equal.

```sql
NULLIF(Value1, Value2)
```

Otherwise, it returns the first expression.

---

# 12. String Functions

String functions manipulate text values.

## Common Functions

* `CONCAT()`
* `CONCAT_WS()`
* `UPPER()`
* `LOWER()`
* `LEN()`
* `SUBSTRING()`
* `LEFT()`
* `RIGHT()`
* `CHARINDEX()`
* `PATINDEX()`
* `REPLACE()`
* `STUFF()`
* `TRIM()`
* `LTRIM()`
* `RTRIM()`
* `REVERSE()`
* `REPLICATE()`

## Notes

* `CONCAT()` automatically converts values to strings.
* `CONCAT()` ignores `NULL` values.
* These functions are commonly used for formatting, searching, cleaning, and manipulating text.

---

# 13. String Splitting and Aggregation

SQL Server provides built-in functions for converting between multiple rows and delimited strings.

## STRING_AGG()

Combines multiple row values into a single string.

Example:

```sql
STRING_AGG(Skill, ', ')
```

---

## STRING_SPLIT()

Splits a delimited string into multiple rows.

Example:

```sql
STRING_SPLIT('C#,SQL,Java', ',')
```

This is useful for working with comma-separated values such as skills or tags.

---

# 14. Mathematical Functions

Mathematical functions perform numeric calculations.

Examples include:

* `ABS()`
* `FLOOR()`
* `CEILING()`
* `ROUND()`
* `SQRT()`
* `SQUARE()`
* `POWER()`
* `RAND()`

---

# 15. Logical and Conditional Functions

These functions implement decision-making inside SQL queries.

## Conditional Functions

* `CASE`
* `IIF`

They are commonly used for:

* Categorizing data
* Displaying conditional values
* Updating records using business rules

## Validation Functions

* `ISDATE()`
* `ISNUMERIC()`

These functions validate whether a value can be interpreted as a specific data type.

---

# 16. Conditional Updates

Conditional updates allow different rows to be updated using different logic.

Example use cases include:

* Salary increases
* Employee classification
* Status changes
* Business rule implementation

The `CASE` expression is commonly used inside an `UPDATE` statement to apply different values based on conditions.


# FORMAT() Function

`FORMAT()` is used to format date/time values into a specific string representation.

## Date Format Patterns

| Pattern | Meaning | Example |
|---|---|---|
| `d` | Day without leading zero | `1` |
| `dd` | Day with 2 digits | `01` |
| `M` | Month without leading zero | `8` |
| `MM` | Month with 2 digits | `08` |
| `MMM` | Abbreviated month name | `Aug` |
| `MMMM` | Full month name | `August` |
| `yy` | 2-digit year | `26` |
| `yyyy` | 4-digit year | `2026` |
| `ddd` | Abbreviated day name | `Thu` |
| `dddd` | Full day name | `Thursday` |

## Time Format Patterns

| Pattern | Meaning | Example |
|---|---|---|
| `h` | Hour in 12-hour format | `2` |
| `hh` | Hour in 12-hour format with 2 digits | `02` |
| `H` | Hour in 24-hour format | `14` |
| `HH` | Hour in 24-hour format with 2 digits | `14` |
| `mm` | Minutes | `35` |
| `ss` | Seconds | `42` |
| `tt` | AM/PM | `PM` |

## Important: FORMAT() Is Case-Sensitive

The format patterns are **case-sensitive**. Uppercase and lowercase letters can have different meanings.

For example:

- `MM` → Month
- `mm` → Minutes
- `hh` → 12-hour format
- `HH` → 24-hour format
- `yyyy` → 4-digit year
- `yy` → 2-digit year

Therefore, changing the case is **not always acceptable**.

For example:

- `MM` represents the month.
- `mm` represents the minutes.

Similarly:

- `hh` represents a 12-hour clock.
- `HH` represents a 24-hour clock.

The correct pattern for a 4-digit year is:

`yyyy`

not:

`YYYY`

`FORMAT()` in SQL Server uses .NET formatting patterns, which are case-sensitive.