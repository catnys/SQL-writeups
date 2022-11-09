# Introduction to SQL World

## 🌟Before Starting... 

Hello everyone, I'm eleanoir, I'd like to prepare these writeups (hopefully I can continue with full motivation to write 'em :D) so that practice in creating tables in SQL worl, so lets get started.


## 🍪 What is SQL ?

SQL stands for `Structured Query Language` which is used for communicating with databases. Initially created in the 1970s, SQL is regularly used not only by database administrators, but also by developers writing data integration scripts to set up and run analytical queries. Inspite of the fact that SQL is an ANSI/ISO standard, there are different versions of the SQL language. However, they all support at least the basic commands (AKA CRUD Operations) in a same manner. SQL databases are better for multi-row transactions, while NoSQL which is also a class of Database Management that are non-relational and generally do not use SQ is better for unstructured data like documents or JSON. SQL databases are also commonly used for legacy systems that were built around a relational structure. As for speed, NoSQL is generally faster than SQL, especially for key-value storage. For example, unlike SQL stores its entities and attributes in JSON (Javasript Object Notation), MongoDB which is also a NoSQL Database stores their documents in BSON (binary format of JSON) file, and it is more faster than SQL Databases in terms of speed.

## ✨ What is Relational Database Management System ?

Relational Database Management System (AKA RDBMS) is known by storing, managing, and retrieving the data stored in a relational database. RDBMS is based on the relational model which has the major components, such as Table, Record/Tuple/Row, Field, and Column/Attribute. 

## 🎨 Data Types

Well, ofc. there are humongous types of data but I want to write down one of the most frequent ones. A data type specifies the type of data that will be stored in that column, so each column in a table is required to have a name and a data type.By providing a data type for a column, the wrong kinds of data are prevented from being stored in the column. Well, in general there are 3 types of data

* String types
* Numeric types
* Date and time types

| Data Type    | Explanation| 
| ------------ | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | 
| `varchar(n)` | stores a variable length string that can contain numbers, letters, and special characters. Its size can be from 0 to 65535 characters.The n parameter specifies the maximum string length in characters. `VARCHAR` is reserved by Oracle to support distinction between NULL and empty string in future, as ANSI standard prescribes.| 
| `number(n)`  | The NUMBER data which can be used for any column that is going to be employed in mathematical calculations type is used to store negative, positive, integer, fixed-decimal, and floating-point numbers.When a number type is used for a column, its precision and scale can be specified. Precision is the total number of significant digits in the number, both to the left and to the right of the decimal point. The decimal point is not counted in specifying the precision. Scale is the total number of digits to the right of the decimal point. The precision can range from 1 to 38. The scale can range from – 84 to 127. An integer is a whole number without any decimal part. To define a column with integer values, only the scale size is provided. | 
| `bit`        | it is the same as normal bit (1 or 0) :)|
| `date`       | The DATE data type is used for storing date and time values. Format: YYYY-MM-DD. The supported range is from '1000-01-01' to '9999-12-31. The range of allowable dates is between January 1, 4712 b.c. and December 31, 9999 a.d. The day, month, century, hour, minute, and second are stored in the DATE-type column. The default date format is DD-MON-YY, where DD indicates the day of the month, MON represents the month’s first three letters (capitalized), and YY represents the last two digits of the year. These three values are separated by hyphens. The default time format is HH:MM:SS A.M., representing hours, minutes and seconds in a 12-hour time format.|
| binary(n) | it is actually same as `char` however, it stores binary byte strings. Its parameter default 1, specifies the column length in the bytes. | 

for example, 

for `char` type,
> PHONE, SOCIAL_SECURITY_NUMBER, or MIDDLE_INITIAL columns can use the CHAR type

An `integer` is a whole number without any decimal part. To define a column with integer values, only the scale size is provided.

> EmployeeId in the EMPLOYEE table has values of 111, 246, 123, 433, and so on. The data type for it would be defined as NUMBER(3), where 3 represents the maximum number of digits. (max. 999)

A `fixed-point` decimal number has a specific number of digits to the right of the decimal poin

> The PRICE column has values in dollars and cents, which requires two decimal places - for example, values like 2.95, 3.99, 24.99, and so on. If it is defined as NUMBER(4,2), the first number specifies the precision and the second number the scale. (max. 99.99)

> A name such as Smith cannot be stored in a column with a NUMBER data type. Similarly, a job title such > as Manager cannot be stored in a column with a DATE data type.

A `floating-point` decimal number has a variable number of decimal places. The decimal point may appear after any number of digits, and it may not appear at all.

> TAXRATE, INTEREST_RATE, and STUDENT_GPA columns are likely to have variable numbers of decimal places. By defining a column as a floating-point number, a value can be stored in it with very high precision


## ☕️ Constraints 

Constraints enforce rules on tables. An Oracle table can be created with the column names, data types, and column sizes, which are sufficient just to populate them with actual data. Without constraints, however, no rules are enforced. In addition, they help us to make your database one with integrity, and are used in Oracle to implement integrity rules of a relational database and to implement data integrity at the individual-column level. Whenever a row/record is inserted, updated, or deleted from the table, a constraint must be satisfied for the operation to succeed. A table cannot be deleted if there are dependencies from other tables in the form of `foreign keys`. There are 2 types of constaints those are,

* **Integrity constraints**: define both the primary key and the foreign key with the table and primary key it references.
* **Value constraints**: define if NULL values are disallowed, if UNIQUE values are required, and if only certain set of values are allowed in a column.

### ☄️ Naming Constraints

Oracle identifies constraints with an internal or user-created name. A user cannot create constraints in two different tables with the same name. Here, table name is the name of the table where the constraint is being defined, column name is the name of the column to which the constraint applies, and constraint type is an abbreviation used to identify the constraint’s type.

`<table name>_<column name>_<constraint type>`

> For example, a constraint name emp_deptno_fk refers to a constraint in table EMP on column DeptNo of type foreign key. A constraint name dept_deptno_pk is for a primary key constraint in table DEPT on column DeptNo.



### 🌷 Defining Constraints

A constraint can be created at the same time the table is created, or it can be added to the table afterward. There are two levels where a constraint is defined:

* **Column level**: A column-level constraint references a single column and is defined along with the definition of the column. Any constraint can be defined at the column level except for a FOREIGN KEY and composite primary key constraints. The general syntax is

`Column datatype [CONSTRAINT constraint_name] constraint_type`

* **Table level**: A table-level constraint references one or more columns and is defined separately from the definitions of the columns. Normally, it is written after all columns are defined. All constraints can be defined at the table level except for the NOT NULL constraint. The general syntax is

`[CONSTRAINT constraint_name] constraint_typ (Column, . . .)`


#### 🔑 Primary Key 

The PRIMARY KEY constraint is also known as the entity integrity constraint.It creates a primary key for the table. A table can have only one primary key constraint. A column or combination of columns used as a primary key cannot have a null value and it can only have unique values. If a table uses more than one column as its primary key (i.e., a composite key),the key can only be declared at the table level.

- At the **column level**, the constraint is defined by

```
DeptId NUMBER (2) CONSTRAINT dept_deptid_pk PRIMARY KEY,`
```

- At the **table level**, the constraint is defined by

```
CONSTRAINT dept_deptid_pk PRIMARY KEY(DeptId),
```


#### 🔑 Foreign Key

The FOREIGN KEY constraint is also known as the referential integrity constraint. It uses a column or columns as a foreign key, and it establishes a relationship with the primary key of the same or another table. To establish a foreign key in a table, the other **referenced** table and its **primary key must already exist**. Foreign key and referenced primary key columns need not have the same name, but a foreign key value must match the value in the parent table’s primary key value or be NULL.
- At the table level (in the STUDENT table),
```
CONSTRAINT student_facultyid_fk FOREIGN KEY(FacultyId) REFERENCES faculty(FacultyId)
```

#### 🔥 Not Null

The NOT NULL constraint ensures that the column has a value and the value is not a null
(unknown or blank) value. A space or a numeric zero is not a null value. There is no need to use the NOT  NULL constraint for the primary key column, because it automatically gets the NOT NULL constraint. The foreign key is permitted to have null values, but a foreign key is sometimes given the NOT NULL constraint. This constraint cannot be entered at the table level. 
- At the `column level`, the constraint is defined by: 
```
Name VARCHAR2(15) CONSTRAINT faculty_name_nn NOT NULL,
```

```
Name VARCHAR2(15) NOT NULL,
```

In the second example, the user doesn't supply the constraint name, so Oracle will name
it with SYS_Cn format. ( btw SYS_C000010 is an Oracle server- named constraint)


#### ❄️ Unique

The UNIQUE constraint requires that every value in a column or set of columns
be unique. If it is applied to a **single column**, the column has unique values only. If it is applied to a **set of columns**, the group of columns has a unique value
together. The unique constraint **allows** `null` values unless `NOT NULL` is also applied to the
column. 
- At the `table level`, the constraint is defined by:
```
CONSTRAINT dept_dname_uk UNIQUE(DeptName),
```

- At the `column level`, the constraint is defined by:
```
DeptName VARCHAR2(12) CONSTRAINT dept_dname_uk UNIQUE
```
#### ✔️ Check

The CHECK constraint defines a condition that every row must satisfy. There can be more than one CHECK constraint on a column, and the CHECK constraint can be defined at the column as well as the table level.

- At the `column level`, the constraint is defined by:
```
DeptId NUMBER(2) CONSTRAINT dept_deptid_cc CHECK((DeptId >= 10) and (DeptId <= 99))
```

- At the `table level`, the constraint is defined by:

```
CONSTRAINT dept_deptid_cc CHECK((DeptId >= 10) and (DeptId <= 99))
```

* A `NOT NULL` constraint can be declared as a CHECK constraint. Then, it can be defined at column or table level.
```
Name VARCHAR2(15) CONSTRAINT faculty_name_ck CHECK(Name IS NOT NULL)
```


## 🚩 References

1. The official website of Oracle Database Documentation https://docs.oracle.com/
2. The official website of Oracle https://www.oracle.com 
3. The official website of MongoDB https://www.mongodb.com/
4. The official website of MongoDB Documentation https://www.mongodb.com/docs/

