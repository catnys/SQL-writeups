# Cursors

## What is a cursor ?

When you execute an SQL statement from a PL/SQL block, Oracle assigns a private work area for that statement. That work area, called a “cursor”, stores the statement and the results returned by execution of that statement. A cursor is either created implicitly or explicitly. There are two types of Cursors



| Cursor Type | Explanation                                                                                                                                                                                                                                                                                  |
| ----------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Dynamic     | In a dynamic cursor, a cursor variable is used that can change its value. The variable can refer to different SQL statements at different times                                                                                                                                              |
| Static      | The contents of a static cursor are known at compile time. The contents of a static cursor are known at compile time. There are two sub-fields of it ,those are implicit and explicit. In Implicit Static Cursor is not defined by user; however, Explicit Static Cursor is defined by user. |

## Implicit Cursors

* PL/SQL creates an implicit cursor when a SQL statement is executed from within the program block.
* The implicit cursor is created only if an explicit cursor is not attached to that SQL statement.
* Oracle opens an implicit cursor, and the pointer is set to the first (and the only row) in the cursor.
* Then the SQL statement is fetched and executed by the SQL engine on the Oracle server.
* The PL/SQL engine closes the implicit cursor automatically.
* A programmer cannot perform all these operations on an implicit cursor that are possible on explicit cursor statements.
* PL/SQL creates an implicit cursor for each DML statement in PL/SQL code.
* You cannot use an explicit cursor for DML statements.
* You can choose to declare an explicit cursor for a SELECT statement that returns only one row of data.
* If  an explicit cursor is not declared for a SELECT statement returning one row of data, an implicit cursor is created for it.
* You have no control over an implicit cursor.
* The implied queries perform operations on implicit cursors.
* PL/SQL actually tries to fetch twice to make sure that a TOO_MANY_ROWS exception does not exist. 
* The explicit cursor is more efficient because it does not try that extra fetch.
* It is possible to use an explicit cursor for a SELECT statement that returns just one row because you have control over it.


```sql
CURSOR deptname_cur IS
SELECT DeptName, Location FROM dept WHERE DeptId = 10;
```

# Explicit Cursors 

* An explicit cursor is declared as a SELECT statement in the PL/SQL block.
* It is given a name, and you can use explicit statements to work with it.
* You have total control of when to open the cursor, when to fetch a row from it, and when to close that cursor.
* There are cursor attributes in PL/SQL to get the status information on explicit cursors.
* An explicit cursor can be declared for a SELECT statement that returns one or more rows.
* You cannot use an explicit cursor for a DML statement.

Four actions can be performed on an explicit cursor:
1. Declare it.
2. Open it.
3. Fetch row(s) from it.
4. Close it.


### Declaring an Explicit Cursor

* If you want to retrieve rows in a specific order into a cursor, an `ORDER BY` clause can be used in the SELECT statement.

```
DECLARE
    CURSOR CursorName IS
    SELECT statement;
```

* CursorName is the name of the cursor that follows identifier naming rules.
* The SELECT statement is any valid data retrieval statement.
* The cursor declaration is done in the DECLARE section of the PL/SQL block, but a cursor cannot be used in programming statements or expressions like other variables.
* A cursor is based on a SELECT statement, so it is linked to at least one table from the database.
* The list that follows can contain names of columns, local variables, constants, functions, and bind variables. 
* It is possible for a variable to have the same name as a column in a table.
* If you try to use them both together in a SELECT statement, the column gets higher precedence.


Explicit cursor declaration:
```sql
DECLARE
    CURSOR dept_cur IS SELECT * FROM dept;
BEGIN
    -- program body
END;
```

Another example:

```sql
DECLARE
    CURSOR employee_cur IS
SELECT employeeid, salary FROM employee WHERE deptid = 20;
BEGIN
    -- program body
END;
```



### Actions on Explicit Cursor

* Actions are performed on cursors declared in the DECLARE section of the block.
* Before rows can be retrieved from a cursor, you must first open the cursor

### Openina a Cursor

* When a cursor is opened, its SELECT query is executed.
* The active set is created using all tables in the query and restricting rows that meet the criteria.
* The data retrieved by the SELECT query is brought into the cursor or the work area.
* The cursor points to the first row in the active set.
* PL/SQL uses an OPEN statement to open a cursor.

```sql    
OPEN CursorName;
```

You must open a cursor that has not been opened in the program block or is closed to retrieve data into it. If you try to open a cursor that is already open, it results in the following;


Oracle error:
`ORA-06511: PL/SQL: cursor already open`

* The errors with prefix ORA are oracle database errors.
* The errors with prefix PLS are PL/SQL errors.

### Fetching data from a cursor

* The SELECT statement creates an active set based on tables in the FROM clause, column names in the SELECT clause, and rows based on conditions in the WHERE clause.
* The cursor is a virtual table that you can work with.
* You can retrieve a row that the cursor is pointing to.
* The values from a row are retrieved into variables or into a PL/SQL record to perform processing.
* After reading values from a row into variables, the cursor pointer moves to the next row in the active set.
* The number of variables must match the number of columns in the row.


In PL/SQL, a FETCH statement is used for this action.
```sql
FETCH CursorName INTO VariableList / RecordName;
```

where VariableList may include a local variable, a table, or a bind variable. RecordName is the name of a record structure.
For example,

```sql
FETCH employee_cur INTO v_empnum, v_sal;
```
or

```sql
FETCH employee_cur INTO emp_rec;
```

where emp_rec is declared with %ROWTYPE declaration attribute:


`emp_rec employee_cur%ROWTYPE;`

### Closing a cursor

* When you are done with a cursor, you should close it.
* A closed cursor can be reopened again.
* If you terminate your PL/SQL program without closing an open cursor, it will not result in an exception.
* In fact, the local cursor declared in a PL/SQL block is closed automatically when the block terminates.
* It is a good habit to close an open cursor before terminating the block.
* There is a limit to the number of cursors a user may open simultaneously.
* The default value is in a parameter called OPEN_CURSORS, which has default value of 50.
* A user releases memory by closing a cursor

PL/SQL uses the CLOSE statement to close a cursor.
```
CLOSE CursorName;
```

For example,

```
CLOSE employee_cur;
```
## Explicit Cursor Attributes

* Actions can be performed on cursors with OPEN, FETCH, and CLOSE statements.
* You can get information about the current status of a cursor or result of the last fetch by using cursor attributes.
* The four explicit cursor attributes are explained like given below.




| Attribute   | Definition                                                                                                                                                                                                           |
| ----------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `%ISOPEN`   | returns TRUE if the cursor is open, otherwise it returns FALSE.                                                                                                                                                      |
| `%FOUND`    | returns TRUE if the last fetch returned a row, otherwise it returns FALSE.                                                                                                                                           |
| `%NOTFOUND` | returns TRUE if the last fetch did not return a row, otherwise it returns FALSE. It is the opposite of the `%FOUND` attribute.                                                                                       |
| `%ROWCOUNT` | returns total number of rows returned. When a cursor is opened and no fetch is done from it, `%ROWCOUNT = 0`. With every fetch, %ROWCOUNT is incremented by 1. The cursor must be open before using %ROWCOUNT on it. |



```sql
SET SERVEROUTPUT ON
DECLARE
    V_LAST EMPLOYEE.LNAME%TYPE;
    V_FIRST EMPLOYEE.FNAME%TYPE;
    V_SAL EMPLOYEE.SALARY%TYPE;
CURSOR employee_cur IS
    SELECT LNAME, FNAME, SALARY FROM EMPLOYEE WHERE DEPTID = 20;
BEGIN
    IF NOT employee_cur%ISOPEN THEN
        OPEN employee_cur;
    END IF;
    LOOP
        FETCH employee_cur INTO V_LAST, V_FIRST, V_SAL;
        EXIT WHEN NOT employee_cur%FOUND;
        DBMS_OUTPUT.PUT_LINE(V_FIRST || ' ' || V_LAST || ' earns $' || V_SAL);
    END LOOP;
DBMS_OUTPUT.PUT_LINE(employee_cur%ROWCOUNT || ' EMPLOYEE(S) FOUND');
END;
```


## Implicit Cursor Attributes

An implicit cursor cannot be opened, fetched from, or closed with a statement. Moreover, Implicit Cursors cannot be named . The cursor attributes are available for an implicit cursor with the name SQL as a prefix.

* SQL%ISOPEN
* SQL%ROWCOUNT
* SQL%NOTFOUND
* SQL%FOUND

If an implicit cursor is not open, SQL%ROWCOUNT will return NULL. Similarly, the other three attributes will return FALSE. You will never get an INVALID_CURSOR error for an implicit cursor. The %ISOPEN attribute will always return a FALSE because it is open only during statement’s execution.  It is opened and closed implicitly. When a SELECT statement returns no rows or more than one row, `NO_DATA_FOUND` or `TOO_MANY_ROWS` exceptions respectively are raised respectively.
The cursor attribute SQL applies to the last SQL statement executed in the block.

# Implicit Cursor Attributes

## Cursor For loop

The cursor is opened implicitly when the loop starts, a row is fetched into the record from the cursor with every iteration of the loop, the cursor is closed automatically when the loop ends, and the loop ends when there are no more rows. The cursor FOR loop automates all the cursor actions;

```sql
FOR RecordName IN CursorName LOOP
Loop statements;
. . .
END LOOP;
```

where RecordName is the name of the record that is declared implicitly in the loop and is destroyed when the loop ends. CursorName is the name of declared explicit cursor.

```sql
SET SERVEROUTPUT ON
DECLARE
    CURSOR EMPLOYEE_CUR IS
SELECT LNAME, FNAME, SALARY FROM EMPLOYEE;
BEGIN
    FOR EMP_REC IN EMPLOYEE_CUR LOOP
        IF EMP_REC.SALARY > 75000 THEN
            DBMS_OUTPUT.PUT_LINE(EMP_REC.FNAME || ' ' || EMP_REC.LNAME);
            DBMS_OUTPUT.PUT_LINE('Salary: $' || EMP_REC.SALARY);
            DBMS_OUTPUT.PUT_LINE('');
        END IF;
    END LOOP;
END;
```

## Cursor Sub-Query Using For Loop
The use of a subquery in the cursor FOR loop eliminates declaration of an explicit cursor. The cursor is created by a subquery in the FOR loop statement itself.


```sql
SET SERVEROUTPUT ON
BEGIN
    FOR EMP_REC IN (SELECT FNAME, LNAME, SALARY, COMMISSION
        FROM EMPLOYEE WHERE DEPTID = 10) LOOP
        DBMS_OUTPUT.PUT_LINE(EMP_REC.FNAME || ' ' ||
        EMP_REC.LNAME || ' $' ||
        TO_CHAR(EMP_REC.SALARY + NVL(EMP_REC.COMMISSION, 0)));
    END LOOP;
END;
```

## Cursor With Parameters

A cursor can be declared with parameters, which allow you to pass values to the cursor. The values are passed to the cursor when it is opened, and they are used in the query when it is executed. With the use of parameters you can open and close a cursor many times with different values. The cursor with different values will then return different active sets each time it is opened. When parameters are passed, you need not worry about the scope of variables.


```sql
CURSOR CursorName
[(Parameter1 DataType, Parameter2 DataType, . . .)]
IS
SELECT query;
```

> When a cursor is opened, values are passed to the cursor. Each value must match the positional order of parameters in a cursor’s declaration


```sql
SET SERVEROUTPUT ON
DECLARE
    V_FIRST EMPLOYEE.FNAME%TYPE;
    V_LAST EMPLOYEE.LNAME%TYPE;
    D_ID NUMBER(2) := &DEPARTMENT_ID;
    CURSOR EMPLOYEE_CUR(DEPT_NUM EMPLOYEE.DEPTID%TYPE) IS
        SELECT LNAME, FNAME FROM EMPLOYEE WHERE DEPTID = DEPT_NUM;
BEGIN
    OPEN EMPLOYEE_CUR(D_ID);
    DBMS_OUTPUT.PUT_LINE('Employees in Department ' || TO_CHAR(D_ID));
    LOOP
        FETCH EMPLOYEE_CUR INTO V_LAST, V_FIRST;
        EXIT WHEN EMPLOYEE_CUR%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(V_LAST || ', ' || V_FIRST);
    END LOOP;
    CLOSE EMPLOYEE_CUR;
END;
```





## Exceptions

In PL/SQL, errors are known as exceptions. An exception occurs during the execution of a program when an unwanted situation arises. The exceptions can occur due to a system error, a user error, or an application error. When the exception occurs, control of the current program block shifts to another section of the program known as the exception section to handle exceptions. If the exception handler part exists, it is performed. If an exception handler does not exist in the current block, control propagates to the outer blocks. If the handler is not in any blocks, PL/SQL returns an error and the script stops. PL/SQL provides ways to trap and handle errors, and it is possible to create PL/SQL programs with full protection against errors. When exception-handling code is written for an exception, the exception can occur anywhere in the block and the same handler can handle it.

The syntax of an anonymous block is given below.
*  Control transfers from the execution section to the exception section.
*  PL/SQL browses through the section to look for the handler.
*  If the handler is present, it is executed. The program may have more than one exception handler in it, written with WHEN…THEN statements like an ELSIF structure or CASE structure.
 
 
```sql
DECLARE
/* Declaration of constants, variables, cursors, and exceptions*/
BEGIN
/* Exception is raised here.*/
EXCEPTION
/* Exception is trapped here.*/
END;
```


The general syntax of an exception section is

```sql
EXCEPTION
WHEN ExceptionName1 [OR ExceptionName2, . . .] THEN
Executable statements
[WHEN ExceptionName3 [OR ExceptionName4, . . .] THEN
Executable statements]
[WHEN OTHERS THEN 
Executable statements]
```

An exception is handled when the exception name matches the name of the raised exception. The exceptions are trapped by name. If an exception is raised but there is no handler for it, WHEN OTHERS clause is performed if present. If there is no handler for an exception and there is no WHEN OTHERS clause, the error number and associated message are displayed to the user.



```sql
DECLARE
    V_FIRST EMPLOYEE.FNAME%TYPE;
    V_LAST EMPLOYEE.LNAME%TYPE;
    D_ID NUMBER(2) := &DEPARTMENT_ID;
BEGIN
    SELECT LNAME, FNAME
        INTO V_LAST, V_FIRST
            FROM EMPLOYEE
                WHERE DEPTID = D_ID;
    DBMS_OUTPUT.PUT_LINE(V_LAST || ', ' || V_FIRST);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No such department with employees');
WHEN TOO_MANY_ROWS THEN
        DBMS_OUTPUT.PUT_LINE('More than one employee in Dept. ' || D_ID);
END;
```




# Practice Exercises

1. Create a PL/SQL block to declare a cursor to select last name, first name, salary, and hire date from the EMPLOYEE table. Retrieve each row from the cursor and print the employee’s information if the employee’s salary is greater than $50,000 and the hire date is before 31-DEC-2012 (explicit cursor problem).

2. Create a PL/SQL block that declares a cursor.
* Pass a parameter to the cursor of the type that is the same as the Salary column in Employee table to the cursor.
*  Open the cursor with a value for the parameter.
* Retrieve information into the cursor for a salary higher than the parameter value.
* Use a loop to print each employee’s information from the cursor (cursor with parameter problem).

3. Create a PL/SQL block that declares a cursor to update salaries of employees.
* Retrieve each row from the cursor by using for loop
* Alter rows for department id 10 and during this time, lock related rows.
* Control if salary of the employee is less than 100000, give 15% raise. If salary of employee is greater than 100000, give 10% raise.
* Display old salaries and new salaries (explicit cursor problem).

4. Create a PL/SQL block that satisfies given properties below.
* Retrieve qualification Id as a substitution variable.
* By using the given qualification Id, display name, surname and department Id of employees.
* Handle NO_DATA_FOUND and TOO_MANY_ROWS exceptions.




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
