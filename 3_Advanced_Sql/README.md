# Chapter 3: Advanced SQL Queries, Aggregations, and Built-in Functions

This chapter focuses on advanced SQL concepts used for data analysis, reporting, and real-world database operations. It covers aggregation, grouping, subqueries, set operators, system functions, and conditional logic.

---

## 1. Aggregate Functions

Aggregate functions are used for calculations and summarization over multiple rows.

### Common Aggregate Functions
- COUNT
- SUM
- AVG
- MIN
- MAX

### Important Notes
- Aggregate functions must use parentheses.
- NULL values are ignored by aggregate functions.
- COUNT(*) counts all rows, including rows with NULL values.
- COUNT(column) ignores NULL values.
- AVG(column) calculates using only non-NULL values.
- Aggregate operations can be expensive in terms of performance.

### Handling NULL Values
- Use ISNULL(column, 0) to replace NULL values during runtime.
- Alternatively, calculate averages manually using SUM / COUNT(*), but this is less efficient.

---

## 2. GROUP BY Clause

The GROUP BY clause is used to group rows that share the same values.

### Rules
- Any column used with an aggregate function must be included in the GROUP BY clause.
- Each group produces one summarized result row.

---

## 3. WHERE vs HAVING

Filtering data occurs at different stages in query execution.

| Clause  | Description                      |
|----------|----------------------------------|
| WHERE    | Filters rows before grouping     |
| HAVING   | Filters groups after aggregation |

### Key Rules
- WHERE cannot contain aggregate functions.
- HAVING is used with aggregate functions.

---

## 4. SQL Execution Order

SQL queries do not execute in the order they are written.

### Actual Execution Order
1. FROM  
2. JOIN  
3. WHERE  
4. GROUP BY  
5. HAVING  
6. SELECT  
7. ORDER BY  
8. TOP  

Understanding this order explains why aliases cannot be used in the WHERE clause.

---

## 5. Subqueries

A subquery is a query nested inside another query.

### Key Concepts
- The inner query executes first.
- Subqueries can return a single value, multiple values, or a table.
- Use IN, ANY, or ALL when the subquery returns multiple values.

---

## 6. Subqueries vs JOIN
- SQL Server often optimizes subqueries into joins.
- JOIN statements are usually faster and easier to read.
- Subqueries are useful for logical clarity.

---

## 7. Set Operators

Set operators combine results from multiple queries.

### Operators
- UNION: Combines results and removes duplicates
- UNION ALL: Combines results including duplicates (faster)
- INTERSECT: Returns common rows
- EXCEPT: Returns rows from the first query only

### Rules
- All queries must have the same number of columns.
- Data types must be compatible.
- Column names are taken from the first query.

---

## 8. System and Metadata Functions

Used to retrieve database and system information.

### Examples
- Database name
- Current user
- Host machine
- Table and column metadata
- Identity values

---

## 9. Date and Time Functions

Used for date calculations and formatting.

### Topics Covered
- Current date and time
- Extracting year, month, and day
- Date difference calculations
- Date addition and subtraction
- End-of-month calculations
- Date validation

---

## 10. NULL Handling Functions

Handling NULL values is essential in database systems.

### Functions
- ISNULL
- COALESCE
- NULLIF

COALESCE is preferred when multiple fallback values are required.

### Main Differences Between ISNULL and COALESCE

| Feature                | ISNULL                          | COALESCE                                                  |
|------------------------|----------------------------------|-----------------------------------------------------------|
| Number of arguments    | Only 2                          | 2 or more                                                 |
| Return type            | Type of first argument          | Type with highest precedence among all arguments          |
| ANSI standard          | SQL Server specific             | Standard SQL (works in many databases)                    |
| Multiple fallbacks     | Not possible                    | Yes                                                       |

### COALESCE Return Type Behavior
- COALESCE returns a single data type determined by highest precedence among its arguments.
- Simplified precedence: `int > decimal > float > datetime > nvarchar`
- Example: if one argument is int and another is nvarchar, SQL Server tries to convert the string to int, which can cause errors.

### COALESCE Data Type Tip
- All arguments should be the same data type.
- If types differ, SQL Server converts to the highest-precedence type, which can cause errors.
- Example: cast integers to strings if mixed with text:

```sql
COALESCE(CAST(Dept_Manager AS NVARCHAR(100)), Dept_Name, 'No data')
```

### ISNULL Behavior
- ISNULL(expr1, expr2)
  - Returns the same type as the first argument.
  - Only works with 2 arguments.
  - SQL Server does not use type precedence beyond the first argument.

---

## 11. String Functions

Used for text manipulation and formatting.

### Categories
- Case conversion
- Length and substring operations
- Pattern searching
- Replace and trim operations
- String concatenation

CONCAT safely handles NULL values and converts all inputs to strings.

---

## 12. String and Array Conversion

Modern SQL supports converting between strings and arrays.

### Concepts
- Aggregating rows into a single string
- Splitting strings into multiple rows
- Useful for skills, tags, and comma-separated values

---

## 13. Mathematical Functions

Used for numeric calculations.

### Examples
- Absolute value
- Rounding
- Square root
- Power
- Random number generation

---

## 14. Logical and Conditional Functions

Used to apply conditions within queries.

### Functions
- CASE
- IIF
- Logical validation functions

These are commonly used for categorization and conditional updates.

---

## 15. Conditional Updates

Update statements can apply different logic based on conditions.

### Use Cases
- Salary adjustments
- Status updates
- Business rules enforcement
