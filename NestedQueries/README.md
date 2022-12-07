# Nested Queries

* A subquery is usually a `SELECT` query within one of the clauses in another `SELECT` query.
* Very powerful queries can be designed by using simple subqueries.
* A subquery is very useful when a query based on a table depends on the data in that subquery itself.
* The subquery can be used within a `WHERE`, `HAVING`, or `FROM` clause of another `SELECT` query.

There are two types of nested querries those are,
1. **Single-row subquery** 
2. **Multiple-row subquery**

## Single Row SubQuery

```sql
SELECT columnlist FROM tablename 
WHERE columnname operator 
(SELECT columnnames FROM tablename WHERE condition);
```   
* The subquery must be enclosed within a pair of parentheses.
* The subquery returns one column from one row in most cases. If 0 row is returned, the value is null. If more than one row is returned, an error occurs.
* The ORDER BY clause cannot be used in a subquery.
* The subquery is used on the right-hand-side of the condition.
* Relational operators `=`, `<>`(or `!=`), `>`, `>=`, `<` and `<=` are used in the outer queries condition.
* When a statement is written with a subquery, the inner query (subquery) is executed first.
* The inner query returns a value or a set of values to the outer query.
* Next the outer query is executed with the result from the inner query.

> Example: Find the name and salary information of employees who work in `FINANCE` department.


<details>
  <summary> Answer </summary>
  
```sql
SELECT Lname, Fname, Salary, DeptId 
    FROM employee 
    WHERE DeptId = 
    (SELECT DeptId FROM dept 
    WHERE UPPER(DeptName) = 'FINANCE'); 
```
</details>

### Create Tables Using Subqueries

```sql
CREATE TABLE tablename AS SELECT(query);
```

* The query will create a new table and populate it with the rows selected from the other table.
* When a new table is created with a sub or nested query, the primary key constraint is not transferred to the new table from the existing table.
* The NOT NULL is the only type of constraint that gets transferred to the new table.
* Other constraints can be added to the new table with ALTER TABLE statement.

```sql
CREATE TABLE temp AS
SELECT EmployeeId, Lname, Fname, Salary
FROM employee WHERE DeptId = 20;
```

The table called `temp` has been created.
| EmployeeId | Lname    | Fname  | Salary  |
| ---------- | -------- | ------ | ------- |
| 34         | Huston   | George | 12.000$ |
| 7          | Hamilton | Derek  | 72.000$ |
| 1          | Chapman  | Taylor | 56.000$ |



Another example,
```sql
SELECT * FROM temp;
```


### Inserting Records Using Subqueries

```sql
INSERT INTO tablename [(column list)]
SELECT columnnames FROM tablename WHERE condition;
```

* An existing table can be populated with a subquery.
* The table must already exist to insert rows into it.
* INSERT with a subquery does not create a new table.
* The INSERT statement does **not** use `VALUES` clause.
* The subquery replaces the VALUES clause and provides values for the new rows.
* The column list in INSERT is optional.
* The column list can be used from the nested SELECT query.

```sql
INSERT INTO temp (EmployeeId, Lname, Fname)
SELECT EmployeeId, Lname, Fname FROM employee WHERE DeptId=10;
```


### Updating Records Using Subqueries

* The optional WHERE clause is part of the outer UPDATE statement in the given syntax.

```sql
UPDATE tablename SET columnname = value or expression
WHERE columnname operator (SELECT subquery)
```
* The inner SELECT query may contain another WHERE clause

* You must be careful with the order of columns in both inner and outer queries. The order of columns must be same in both queries.
```sql
UPDATE tablename SET (columnnames) = (SELECT subquery)
[WHERE condition];
```

* If an employee is leaving and his/her `position`, `supervisor`, and `department` information are to be given to another existing employee, UPDATE can be performed with a subquery.

```sql
UPDATE employee
SET (PositionId, Supervisor, DeptId) =
(SELECT PositionId, Supervisor, DeptId
FROM employee WHERE EmployeeId=135)
WHERE EmployeeId=200;
```

### Deleting Records Using Subqueries

```sql
DELETE FROM tablename WHERE columnname = (SELECT subquery);
```

* A row or rows from a table can be deleted based on a value returned by a subquery.

> Example: Delete employees from the `Accounting` Department.


<details>
  <summary> Answer </summary>
  
```sql
DELETE FROM employee 
WHERE DeptId = 
(SELECT DeptId FROM dept 
 WHERE UPPER(DeptName) = 'ACCOUNTING');
```
</details>


## Multiple Row Nested Queries

* A multiple-row subquery returns more than one row.
* The operators used in single-row subqueries (`=`, `<>`, `>`, `>=`, `<` and `<=`) cannot be used with multiple-row subqueries.
* The IN operator looks for at least one match from the list of values provided.
* `ANY` and `ALL` clauses performs a comparison between a single column and a range of other values. 
* The `IN` operator looks for at least one match from the list of values provided. (Think like IN as = operator)
* The ANY operator can be used in combination with other relational operators. It serves like an “OR” operator, as it looks for match to any one value!



| Expression | Explanation                                    |
| ---------- | ---------------------------------------------- |
| `>ANY `    | higher than the minimum value in the list      |
| `=ANY`     | equal to any value in the list (similar to `IN`) |
| `<ANY`     | less than the maximum value in the list        |

* `ALL` means that the condition will be satisfied only if the operation is true for all values in the range. It can also be used with relational operators. 


| Expression | Explanation                                                                                                                                                   |
| ---------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `>ALL `    | higher than the minimum value in the list                                                                                                                     |
| `=ALL`     | is meaningless, no value can be equal to all values in a list (I know its kinda odd to put this in here, anyway I just wanna make it more clear implicitly :) ) |
| `<ALL`     | less than the maximum value in the list                                                                                                                       |
```sql
SELECT EmployeeId, Lname, Fname FROM employee
WHERE EmployeeID IN (SELECT EmployeeId FROM dependent
WHERE Relation = 'Spouse');
```
> Lets say inner query returns three values (200, 222, 543) for employees having the relation 'spouse', so the outer query returns the employee information who has a spouse.

```sql
SELECT EmployeeId, Lname, Fname, Salary FROM employee
WHERE Salary >ANY (SELECT Salary FROM employee
WHERE PositionId = 2) AND PositionId <> 2;
```
> Let inner query returns four values (150000, 75000, 80000, 45000). The `>ANY` operator checks for values larger than the minimum salary of 45000 in the list. The outer query also checks for PositionId not equal to 2. Rows with EmployeeId 111 and 433 are selected.

```sql 
SELECT EmployeeId, Lname, Fname, Salary 
FROM employee
WHERE Salary <ALL (SELECT AVG(Salary) 
FROM employee GROUP BY DeptId);
```
> The inner query returns four averages.One value per department: 125000, 73250, 34750, 150000, so `<ALL` operator means the employee with a salary less than the minimum in the list of values. Rows with EmployeeId 200 are selected. Then, Only one row with a salary of 24500 is picked.

## Tables and Rows

### `Employee`

| Constraint Type | Attribute Name | Data Type    |
| ----------------- | -------------- | ------------ |
| `PK`              | employeeId     | number(5)    |
| `NN`              | lname          | varchar2(20) |
| `NN`              | fname          | varchar2(20) |
| `FK`              | positionId     | number(3)    |
| `FK`              | supervisor     | number(5)    |
|                   | date           | date         |
|                   | salary         | number(6)    |
|                   | commission     | number(6)    |
| `FK`              | deptId         | number(3)    |
| `FK`              | qualId         | number(3)    |

### `Qualification`


| Constraint Type | Attribute Name | Data Type    |
| --------------- | -------------- | ------------ |
| `PK`            | qualId         | number(3)    |
|                 | qualDesc       | varchar2(20) |

### `Position`

| Constraint Type | Attribute Name | Data Type    |
| --------------- | -------------- | ------------ |
| `PK`            | posId         | number(3)    |
|                 | posDesc       | varchar2(20) |

### `Emplevel`

| Constraint Type | Attribute Name | Data Type |
| --------------- | -------------- | --------- |
| `PK`            | levelNo        | number(3) |
|                 | lowsalary      | number(6) |
|                 | highsalary     | number(6) |

### `Dept` 


| Constraint Type | Attribute Name | Data Type    |
| --------------- | -------------- | ------------ |
| `PK`            | deptId         | number(3)    |
|                 | deptName       | varchar2(20) |
|                 | location       | varchar2(20) |
| `FK`            | employeeId     | number(5)    |


### `Dependent` 

| Constraint Type | Attribute Name | Data Type    |
| --------------- | -------------- | ------------ |
| `PK` `FK`       | Text           | number(5)    |
| `PK`            | dependentId    | number(3)    |
|                 | depDOB         | date         |
|                 | relation       | varchar2(20) |


The image below also shows the relationship among tables.

![](https://i.imgur.com/rZZzqLA.png)


![](https://i.imgur.com/kt0bzHx.png)
