# Working w/ Tables 


## 🌟 Creating an Oracle Table

Creating table examples as below,
```
CREATE TABLE bills (Name CHAR(30), Amount NUMBER, Account_ID NUMBER);
```
```

CREATE TABLE bills (Name CHAR(30) NOT NULL, Amount NUMBER, Account_ID NUMBER NOT NULL);
```
## 🌸 Displaying Tables

Oracle has SQL statements and SQL*Plus commands for the user to view that
information from Oracle’s Data Dictionary tables. To review information in the table, and to find out what is already created and what is to be created,
```
SELECT TABLE_NAME FROM USER_TABLES;
```

USER_TABLES is an Oracle system database table and TABLE_NAME is one of its
columns. The USER_TABLES table has many other columns. To display all columns, type the following statement:
```
SELECT * FROM USER_TABLES;
```

## 🍁 Viewig Tables As Structure

You can display the structure entered by you in a CREATE TABLE statement. If you have made any changes to the table’s structure, the changes will also show in the structure’s display. The SQL*Plus command to view a table’s structure is DESCRIBE (or DESC), which does not need a semicolon at the end because it is not a SQL statement.

## ❄️ Viewig Tablespace Info

You can get information about all available tablespaces to you by using data
dictionary view USER_TABLESPACES.
```
SELECT * FROM USER_TABLESPACES;
```
- Similarly, another data dictionary view USER_USERS gives user information about his/her account.
```
SELECT * FROM USER_USERS;
```

## 💫 Viewig Constraint Info

Oracle’s Data Dictionary table USER_CONSTRAINTS stores information about constraints you have entered for each column. When you type the statement, the table name must be typed in uppercase because Oracle saves table names in uppercase. If you type the table name in lowercase, no constraint names will be
displayed.

> For example, You will type only the first two lines of the statement in the next code to display all constraints in your account. The ORDER BY clause is added to sort constraint display by table name.
```
SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE, TABLE_NAME FROM USER_CONSTRAINTS ORDER BY TABLE_NAME;
```

Another Data Dictionary table USER_CONS_COLUMNS stores column related information about constraints. In this statement, only the table name within single quotes needs to be in uppercase because Oracle stores table names in that case.

## ☄️ Dropping a Constraint

In example below, `CASCADE` implies "*relationship between tables*" AKA `foreign keys`. If we type `CASCADE`, we meant that "*drop also relationship between the primary key and also foreign key*" ,so The `CASCADE` clause drops the dependent `foreign key` constraints, if any 

```
ALTER TABLE tablename DROP PRIMARY KEY|UNIQUE (columnname) | CONSTRAINT constraintname [CASCADE]
```
This statement drops the primary key constraint from the MAJOR table.
```ALTER TABLE major DROP PRIMARY KEY CASCADE```

## 🏈 Renaming a Constraint
```
ALTER TABLE tablename RENAME CONSTRAINT oldname TO newname;
```

## 🎨 Renaming a Column

```
ALTER TABLE tablename RENAME COLUMN oldname TO newname;
```


## 🧩 Renaming a Table
```
RENAME oldtablename TO newtablename
```

## 🌷 Truncating a Table

Truncating a table is removing all records/rows from the table. The structure of the table stays intact. The owner of the table with the DELETE TABLE privilege to truncate a table.

```
TRUNCATE TABLE tablename;
```

## 🌧 Dropping a Table

When a table is dropped, all data and the table’s structure are permanently deleted. The DROP operation cannot be reversed. Oracle does not ask you “Are You Sure?” question. The owner of the table or have the rights to do so. If you add optional CASCADE CONSTRAINTS clause, it removes `foreign key` **references** to the table also.

```
DROP TABLE tablename [CASCADE CONSTRAINTS];
```


## 🔥Try it Yourself !

Well, I have a pretty good example about creating tables in SQL. You can both find tables itself and also relations between one another below. Use SQL statements to create all six tables from the Corporation database.Define the `primary key`, `foreign key`, `NOT NULL`, `DEFAULT`, `CHECK`, and `UNIQUE` constraints in the `CREATE TABLE` statement. If not possible, use `ALTER TABLE` statement to add a constraint. Don't be shy, go ahead and check them :)


* `PK` : Primary Key
* `FK` : Foreign Key
* `NN` : Not Null
* `Unique`: Unique Key


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
| `PK`            | qualId         | number(3)    |
|                 | qualDesc       | varchar2(20) |

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


![](https://i.imgur.com/4n5DeZT.png)

Now, please feel free to go ahead and check the tables and try yourself. You can also find the answers in the folder.

## 🚩 References

1. The official website of Oracle Database Documentation https://docs.oracle.com/
2. The official website of Oracle https://www.oracle.com 
