# Views, Objects, Transactions, and Data Control


---


## What is View ?
A view is an Oracle object that gives a user logical view of data from an underlying table or tables. You can restrict what users can view by allowing them to see only a few columns from a table. When a view is created from more than one table, the user can view data from the view without using join conditions and complex conditions.The application programs can access data with data independence. The same data can be viewed differently with different views. Views also hide names of the underlying tables, so the user does not know where the data is coming from. In short, a view is a logical representation of a subset of data from one or more tables. A view is stored as a SELECT statement in the data dictionary.

* A `simple view` is based on one table, it does not contain group functions or grouped data, and data manipulation is always possible through it.
* A `complex view` is based on one or more tables, it may contain group functions and/or grouped data, and data manipulation is not always possible through it.

## Create View

A view is created with a SELECT subquery. The subquery cannot use an ORDER BY clause, but a view can.

```sql
CREATE [OR REPLACE] [FORCE|NOFORCE] VIEW viewname [column aliases]
AS SELECT-subquery
[WITH CHECK OPTION [CONSTRAINT constraintname]]
[WITH READ ONLY];
```

* In the syntax, OR REPLACE replaces an existing view with the same name, if it already exists. 
* The FORCE option creates a view even if the underlying table does not exist yet. 
* The default is NOFORCE, which does not create a view if the underlying table does not exist.
* The column aliases are used for the columns selected by the subquery.
* The number of aliases must match the number of columns selected by the subquery.
* The SELECT subquery can use all clauses except for the ORDER BY clause.
* The WITH CHECK OPTION applies to the WHERE clause condition in the subquery.
* It allows insertion and update of rows based on the condition that satisfies the view.
* The CHECK OPTION can also be given an optional constraint name.
* The WITH READ ONLY option is to make sure that the data in the underlying table are not changed through view

```sql
CREATE OR REPLACE FORCE VIEW dept_sal_view AS
SELECT d.deptname DEPARTMENT,
MIN(e.salary) LOWEST,
MAX(e.salary) HIGHEST,
AVG(e.salary) AVERAGE
FROM employee e, dept d
WHERE e.deptid = d.deptid
GROUP BY d.deptname;
```
## Remove View


* A user who owns a view or has the privilege to remove it, can remove a view.
* The removal of a view does not affect data in the underlying table.
* When a view is removed, a “View dropped” message is displayed.
* The general syntax is `DROP VIEW viewname;`

for example ;
```sql
DROP VIEW dept_sal_vu;
```

## Alter View


* When you alter an underlying table, the view becomes invalid.
* You need to recompile that view to make it valid again.
*  The ALTER VIEW statement is used for recompilation of a view.

```sql
ALTER VIEW dept_sal_vu COMPILE;
```


* Same statement is used to check validity of a view, in case the underlying table is dropped.
* ALTER VIEW statement lets you add constraints to view.
* You can use clauses like MODIFY CONSTRAINT and DROP CONSTRAINT.



---


## Sequences


* A sequence is an Oracle object that is used to generate sequence of numbers.
* Many times you create a table with surrogate key column such as StudentId, FacultyId, or EmployeeId.
* These columns have a numeric data type.
* Sequencing is a perfect solution for generating values for such numeric columns.
* These values can be unique or recycled again, depending upon the column.
* If a sequence is used for a primary key column, values must be unique!
* A sequence is not limited to the primary key columns but can be used on any numeric column.

The general syntax is

```sql
CREATE SEQUENCE sequencename
[INCREMENT BY n]
[START WITH s]
[MAXVALUE x | NOMAXVALUE]
[MINVALUE m | NOMINVALUE]
[CYCLE | NOCYCLE]
[CACHE c | NOCACHE]
[ORDER | NOORDER];
```


* `INCREMENT BY n`: The increment value for the number generation is n.
    * The default increment is 1.
* `START WITH s`: The starting value for the sequence is s.
    * The default start value is 1.
* `MAXVALUE` x: The maximum value for the generated number is x.
* `NOMAXVALUE`: The sequence will keep generating until the maximum allowable value is generated in ascending order.
    * `NOMAXVALUE` is –1 for a sequence in descending order (default).
* `MINVALUE` m: The minimum value for the generated number is m.
* `NOMINVALUE`: The minimum value is 1 for a sequence in ascending order and for a sequence in descending order (default).
* `CYCLE`: The sequence continues generating after reaching the maximum or minimum value.
* `NOCYCLE`: No more generation after maximum or minimum value is reached (default).
* `CACHE c`: The Oracle server generates numbers in advance and stores them in a cache memory area for improved system performance.
    * The default value for c is 20.
    * If the user provides a number, the server will store that many numbers in the cache memory.
* `NOCACHE`: The server does not store any sequence numbers in memory in advance.
* `ORDER`: The numbers are generated in chronological order.
* `NOORDER`: The numbers are not generated in chronological order.

```sql
CREATE SEQUENCE empid_seq
INCREMENT BY 1
START WITH 544
MAXVALUE 999
NOCACHE;
```

There are pseudo-columns named `CURRVAL` and `NEXTVAL` to reference sequence values.
* The `NEXTVAL` column returns the next available number in the sequence.
* The `CURRVAL` column gives the current sequence value.
* The `NEXTVAL` column is used with the sequence name (e.g. sequencename.`NEXTVAL`) to generate the next sequence number.
* When the new sequence number is generated, the current number is stored in the `CURRVAL`.
* The `NEXTVAL` must be used at least once in order to get the value from CURRVAL.

1. Create a sequence like given
```
CREATE SEQUENCE dept_id_seq
START WITH 90 INCREMENT BY 1;
```

2. Then, insert a new department to DEPT table by using the sequence given above.

`INSERT INTO dept VALUES (dept_id_seq.NEXTVAL, 'IT', 'Bronx’, 111);`

3. Insert a new employee by using two sequences like given below:

`INSERT INTO employee (employeeid, lname, fname, deptid) VALUES (employee_id_seq.NEXTVAL, 'Viquez', 'Heillyn’, dept_id_seq.CURRVAL);`

4. Now, all the user sequences can be viewed by using given query below:

```
SELECT sequence_name, last_number, max_value, min_value, increment_by
FROM user_sequences;
```

## Modify Sequence

* A sequence can be modified by using ALTER SEQUENCE privilege.
* The modified sequence does not affect past numbers, but only numbers generated in the future.
* Modification of the sequence does not allow you to change the START WITH option.
* The sequence has to be removed and re-created to change the starting value.
* The maximum value cannot be set to a number less than the current number.


```sql
ALTER SEQUENCE sequencename
[INCREMENT BY n]
[MAXVALUE x | NOMAXVALUE]
[MINVALUE m | NOMINVALUE]
[CYCLE | NOCYCLE]
[CACHE c | NOCACHE]
[ORDER | NOORDER];
```


## Drop Sequence 

* You can drop a sequence with the DROP SEQUENCE statement.
* A removed sequence cannot be used anymore

```sql
DROP SEQUENCE dept_deptid_seq;
```

---



# RowID Pseudocolmn

* Every row has a unique system generated address called the ROWID.
* The address contains exact location of the row, and index files store ROWID to retrieve rows.
* The row address or physical storage location of row consists of data object number, data block number, number of the row within the data block, and the data file number.
* The ROWID can be used in a query for faster access of a row, but it cannot be changed.
* If a row is deleted and then is inserted again, it gets a new ROWID

```sql
SELECT ROWID, employeeid, lname, fname
FROM employee WHERE employeeid=200;
```

```sql
SELECT employeeid, lname, fname
FROM employee WHERE ROWID = 'AAAHaCAABAAMbaAAF';
```
![](https://i.imgur.com/uqiJPi0.png)


---

# Transactions


* Oracle groups your SQL statements into transactions.
* A transaction consists of a series of Data Manipulation Language (DML) statements, one Data Definition Language (DDL) statement, or one Data Control Language (DCL) statement.
* Due to transaction control, Oracle guarantees data consistency.
* The transaction control statements give you flexibility to undo transactions or write transactions to the disk.
* Transactions provide consistency in case of a system failure.
* In Oracle, your transactions start with the first executable SQL statement you issue.


The transaction **ends** when one of the following occurs:

* A COMMIT or ROLLBACK transaction control statement is used.
* A DDL , AKA dynamic link library is a collection of small programs that larger programs can load when needed to complete specific tasks, (CREATE, ALTER, DROP, RENAME, or TRUNCATE) statement isexecuted (automatic commit).
* A DCL (GRANT or REVOKE) statement is executed (automatic commit).
* A user properly exits (commit).
* The system crashes (rollback).
* Once a transaction ends, the new transaction starts with your next executable SQL statement.



---

## Locking Rows

* When a user issues a SELECT query, rows are not locked.
* Oracle does not lock rows for viewing.
* The rows with DML query changes are locked until changes are committed.
* Suppose you want to view rows and also change them.
* You would want to lock those rows for future changes.
* You would use the SELECT…FOR UPDATE OF statement for such manual locks.
 The general syntax is;
 
```sql
SELECT columnnames
FROM tablenames
[WHERE condition]
FOR UPDATE OF columnnames
[NOWAIT];
```




---


# Practice Exercises



1. Create a view to include all employee information, but hide salary and commission.


3. Create a view to include department name and average salary by department.


5. Lock employee ID 123 for update of salary to 100000. Update the row and commit it.


7. Create a view that will display employee ID, name, department number, and total income (salary+commission) of each employee in department 10. Prevent change of department through the view.



8. Create a view that will display department names and sum of all employee income by department.


10. Create a sequence "deptid_seq" to generate department Id (for dept table) and another sequence "empid_seq" to generate employee Id (for employee table). Use "deptid_seq" to add a new department. Then, add yourself as a new employee to the department you just created





---


# Tables and Rows

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


