# Working w/ Multiple Tables

###### tags: `SQL` `Join` `Multi-Tables` `Set Operations`

---


### ✨ What is Database Normalization ?

Database normalization is a process used to organize a database into tables and columns. Moreover, it is useful because it minimizes duplicate data in any single table, and allows for data in the database to grow independently of each other. As an exchange, queries get slightly more complex since they have to be able to find data from different parts of the database, and performance issues can arise when working with many large tables. The main idea is each table should be about a specific topic and only supporting topics included. Take a spreadsheet containing the information as an example, where the data contains salespeople and customers serving several purposes, such as listing all customers your company calls upon to sell a product or identifying which salespeople call on specific customers. To achieve these objectives, we’ll use some established rules. This is called database normalization. There are three common forms of database normalization: first, secont, and third normal forms. They are also abbreviated as 1NF, 2NF, and 3NF respectively (NF stands for Normal Form).

## Join Operations

### 🍨Join

* `JOIN` clause which is used with `SELECT` statement is used to retrieve data by combining rows from one or multiple tables, based on a related column among them. In short, When the required data is in more than one table, related tables are joined using a `JOIN` condition.
* The join condition combines a row in one table with a row in another table based on the same values in the common columns. In most cases (but not always), the common columns are the `primary key` in one table and a `foreign key` in another.
* A Cartesian product results from a multi-table query that does not have a `WHERE` clause.
* The product operation joins each row in the first table with each row in the second table.
* The product normally results in an output with a large number of rows 
```
(# of rows of table1) x (# of rows of table2)
```

* Whenever retrieving data from more than one table, you must use a valid join condition(s) to avoid a Cartesian product.

`Syntax`
```sql    
SELECT Lname, Fname, QualDesc FROM Employee, Qualification;
```
Join example,
```sql
SELECT columns FROM table1, table2.... tablen WHERE table1.column = table2.column; 
```

Another Join example,

```sql
SELECT Lname, Fname, PositionDesc FROM Employee, Position;
```

### Inner Join

The INNER JOIN is a process that matches rows from the first table and the second table which have the same key to create a result row with the combined columns from both tables.

```sql
SELECT column, another_column, … FROM mytable INNER JOIN another_table ON mytable.id = another_table.id WHERE condition ORDER BY column, DESC/ASC LIMIT limitnum OFFSET offsetnum;
```


### 🌷 Equijoin

* The equijoin is a join with a join condition involving common columns from two tables.

`Syntax` 
```sql
SELECT columnnames FROM tablenames WHERE join condition(s);
```
* The join condition normally includes a foreign key column from one table and the referenced primary key column from the other table.
* When columns are retrieved from more than one table, the use of a table name qualifier in front of the column name tells Oracle to retrieve that column from the table specified.
* If a column name exists in only one of the two tables involved in the query, it is not necessary to use a table name as a qualifier.
* If a column exists in both tables involved, you must use the table name qualifier.,

(mostly I prefer to use this syntax below, however you can free to choose :) 💛)
```sql
SELECT employee.Lname, employee.Fname, position.PositionDesc
FROM employee, position
WHERE employee.PositionId=position.PositionId;
```

or you can prefer to use `JOIN .... ON ...`

```sql
SELECT employee.Lname, employee.Fname, position.PositionDesc
FROM employee JOIN position
ON employee.PositionId=position.PositionId;
```


### Non-Equijoin

* The join condition for such tables can be written using any operator other than the = operator. `NON EQUI JOIN` clause uses comparison operator instead of the equal sign like `>`, `<`, `>=`, `<=` through conditions.

```sql
SELECT e.Lname, e.Fname, e.Salary, lv.LevelNo
FROM employee e, emplevel lv
WHERE e.Salary BETWEEN lv.LowSalary AND lv.HighSalary;
```

### 🐾 Outer Join

* If a row in one table does not have a matching value in another table, the tables are not joined.
* The table that does not contain the matching value is known as the deficient table.
* The outer join uses the `(+)` operator in the join condition on the deficient side.

#### ➡️ Right Outer Join

* `RIGHT JOIN` clause joins two tables and fetches rows based on a condition, which is matching in both the tables, and the unmatched rows will also be available from the table written after the JOIN clause

```sql
SELECT e.Lname, e.Fname, q.QualDesc
FROM employee e RIGHT OUTER JOIN qualification q
ON e.Qualid=q.Qualid;
```

or 

```sql
SELECT e.Lname, e.Fname, q.QualDesc
FROM employee e, qualification q
WHERE q.Qualid=e.Qualid(+);
```
#### ⬅️ Left Outer Join

`LEFT JOIN` keyword returns all documents from the left table , and the matching documents from the right table. If there is no match, the result would be 0 records from the right side.

```sql
SELECT e.Lname, e.Fname, q.QualDesc
FROM employee e LEFT OUTER JOIN qualification q
ON e.Qualid=q.Qualid;
```

or 

```sql
SELECT e.Lname, e.Fname, q.QualDesc
FROM employee e, qualification q
WHERE e.Qualid=q.Qualid(+);
```

### 🍁 Self-Join

* When a table is joined to itself, two copies of the same table are loaded or used. In other words,A SELF `JOIN` is a join that is used to join a table by itself.
* They are treated like any two different tables, and a join is produced from those two copies
* You can also use another condition instead of WHERE clause according to your requirements.

```sql
SELECT e.Lname, e.Fname, s.Lname, s.Fname
FROM employee e, employee s
WHERE e.Supervisor=s.EmployeeId;
```
> In EMPLOYEE table, EmployeeId is the primary key column that describes each entity. For example, EmployeeId 200 represents employee Shaw, Jinku. The table also has another column called Supervisor, which contains IDs of employee supervisors. You can look up the supervisor ID, go to the EmployeeId column to find its match, and then read the name.

### Natural Join 

* `NATURAL JOIN` clause is a type of join operation that creates an implicit join by combining tables based on columns with the same name and data type.
* It is pretty much similar to Right or Left Outer Join however, we cannot use the `ON` or `USING` clause with natural join as we used in them.
* We don't have to specify the column names to join.
* The table at the end, always contains unique columns.
* It is possible to perform a `natural join` on more than two tables.

```sql
SELECT column   
FROM table   
NATURAL JOIN anothertable;  
```

## 🌟 Set Operations

### Union 
* It returns all rows from both queries
* Duplicate rows are not repeated

```sql
SELECT StudentId ID, Last, First FROM student
UNION
SELECT WorkerId, Last, First FROM worker;
```


### Union All

* It returns all rows from both queries
* Displays all duplicate rows

```sql
SELECT StudentId ID, Last, First FROM student
UNION ALL
SELECT WorkerId, Last, First FROM worker;
```


### Minus

* It returns rows that are returned by the first query minus rows that are returned by the second query

```sql
SELECT StudentId ID, Last, First FROM student
MINUS
SELECT WorkerId, Last, First FROM worker;
```

### Intersects

* It returns all rows that appear in both queries' results

```sql
SELECT StudentId ID, Last, First FROM student
INTERSECT
SELECT WorkerId, Last, First FROM worker;
```





---

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

