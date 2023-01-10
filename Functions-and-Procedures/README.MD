# Named Blocks: Procedures and Functions




---


# Procedures


* A procedure is a named PL/SQL program block that can perform one or more tasks.
* A procedure is the building block of modular programming.
* The general block structure of a procedure is

```
CREATE [OR REPLACE] PROCEDURE ProcedureName
[ (parameter1 [, parameter2...]) ]
IS
[ Constant/Variable declarations ]
BEGIN
Executable statements
[ EXCEPTION
exception handling statements ]
END [ ProcedureName ];
```

* where ProcedureName is a user-supplied name that follows the rules used in naming identifiers.

* The parameter list has the names of parameters passed to the procedure by the calling program as well as the information passed out of the procedure to the calling program.
* The local constants and variables are declared after the reserved word IS.
* If there are no local identifiers to declare, there is nothing between the reserved words IS and BEGIN.
* The executable statements are written after `BEGIN` and before `EXCEPTION` or `END`.
* There must be at least one executable statement in the body.
* The reserved word EXCEPTION and the exception-handling statements are optional.


### Procedure Header


* The definition that comes before the IS reserved word is called the procedure header.
* The procedure header contains the name of the procedure and the parameter list with data types, if any.
* The parameter list in the header contains the name of a parameter with its type.
* The parameter names used in the procedure header do not have to be the same as the names used in the call.
* The number of parameters in the call and in the header must match, and the parameters must be in the same order


### Procedure Body 


* The procedure body contains declaration, executable, and exception handling sections.
* The declaration and exception-handling sections are optional.
* The executable section contains action statements, and it must contain at least one action statement.
* The procedure body starts after the IS reserved word.
* If there is no local declaration, the IS reserved word is followed by the reserved word BEGIN.
* The body ends with the reserved word `END`.
* There can be more than one `END` statement in the program, so it is a good idea to use the procedure name as the optional label after reserved word `END`.


### Procedure Parameters 


* Parameters are used to pass values back and forth from the calling environment to the Oracle server.
* The values passed are processed and/or returned with procedure execution.
* There are three types of parameters:
    * IN
    * OUT
    * IN OUT



| Parameter Type | Description |
| -------------- | ----------- |
| IN               |     Passes a value into the program; read-only type of value; it  cannot be changed; default parameter type. For example, constants, literal, and expressions can be used  as IN parameters.        |
|        OUT        |       Passes a value back from the program; write-only type of  value; cannot assign a default value. If a program is  successful, value is assigned. For example, a variable can be used as OUT parameter.       |
| IN OUT           | Passes a value in and returns a value back; value is read  from and then written to.  For example, a variable can be used as a IN OUT parameter.        |


### Actual and Formal Parameters

* The parameters passed in a call statement are called the actual parameters.
* The parameter names in the header of a module are called the formal parameters.
* The actual parameters and their matching formal parameters must have the same data types.
* In a procedure call, the parameters are passed without data types.
* The procedure header contains formal parameters with data types, but the size of the data type is not required.
* There are two different ways in PL/SQL to link formal parameters and actual

    * In Positional notation the formal parameter is linked with an actual parameter implicitly by position.
    *  In Named notation the formal parameter is linked with an actual parameter explicitly by name.


![](https://i.imgur.com/Pdepbqj.png)


The formal parameter and actual parameters (the values of the parameters) are linked in the call statement with the symbol `=>`. The general syntax is `FormalParameterName => ArgumentValue`. For example, `EMPNO => 543`. The procedure becomes invalid if the table it is based on is deleted or altered. The compiled version of procedure is stored, which should be compiled in case of alterations to the table(s). You can recompile that procedure with the `ALTER PROCEDURE ProcedureName COMPILE;`



### Calling a procedure 


A call to the procedure is made through an executable PL/SQL statement.
 The procedure is called by specifying its name, along with the list of parameters (if any) in parentheses. The call statement ends with a semicolon `ProcedureName [ (parameter1, ...) ];`.

For example,
```
monthly_salary (v_salary);
calculate_net (v_monthly_salary, 0.28);
display_messages;
```

In these examples of procedure calls, parameters are enclosed in parentheses. You can use a variable, constant, expression, or literal value as a parameter. If you are not passing any parameters to a procedure, there is no need to use parentheses.



```sql
CREATE OR REPLACE PROCEDURE DEPENDENT_INFO
IS
CURSOR DEP_CUR IS
SELECT LNAME, FNAME, COUNT(DEPENDENTID) CNT
FROM EMPLOYEE E, DEPENDENT D
WHERE E.EMPLOYEEID = D.EMPLOYEEID
GROUP BY LNAME, FNAME;
BEGIN
FOR DEP_REC IN DEP_CUR LOOP
IF DEP_REC.CNT >= 2 THEN
DBMS_OUTPUT.PUT_LINE(DEP_REC.LNAME ||', '|| DEP_REC.FNAME 
|| ' has ' || DEP_REC.CNT || ' dependents');
END IF;
END LOOP;
END;

EXECUTE DEPENDENT_INFO;
```
**output**

```
PROCEDURE DEPENDENT_INFO compiled
anonymous block completed
Dev, Derek has 2 dependents
```


---

Another Example,

```sql
CREATE OR REPLACE PROCEDURE SEARCH_EMP
(I_EMPID IN NUMBER, 
O_LAST OUT VARCHAR2, 
O_FIRST OUT VARCHAR2)
IS
BEGIN
    SELECT LNAME, FNAME
    INTO O_LAST, O_FIRST
    FROM EMPLOYEE
    WHERE EMPLOYEEID = I_EMPID;
EXCEPTION
    WHEN OTHERS THEN 
    DBMS_OUTPUT.PUT_LINE('Employeeld ' || TO_CHAR(I_EMPID) || ' does not exist');
END SEARCH_EMP;
```


```sql
DECLARE
    V_LAST EMPLOYEE.LNAME%TYPE;
    V_FIRST EMPLOYEE.FNAME%TYPE;
    V_ID EMPLOYEE.EMPLOYEEID%TYPE := &EMP_ID;
BEGIN
    SEARCH_EMP(V_ID, V_LAST, V_FIRST);
    IF V_LAST IS NOT NULL THEN
        DBMS_OUTPUT.PUT_LINE('Employee: ' || V_ID);
        DBMS_OUTPUT.PUT_LINE('Name: ' || V_LAST || ', ' || V_FIRST);
    END IF;
END;
```


**output**

```
anonymous block completed
Employee: 111
Name: Smith, John
anonymous block completed
Employeeld 555 does not exist
```




---


## Functions

* A function, like a procedure, is a named PL/SQL block. Like a procedure, it is also a stored block. The main difference between a function and a procedure is that a **function always returns a value back to the calling block**. A function is characterized as follows, A function can be passed zero or more parameters. A function must have an explicit `RETURN` statement in the executable section to return a value. The data type of return value must be declared in the function’s header. A function cannot be executed as a standalone program. A function may have parameters of IN, OUT, and IN OUT types, but the primary use of a function is to return a value with an explicit `RETURN` statement.The use of OUT and IN OUT parameter types in functions is rare and considered a bad practice.


```sql
CREATE [ OR REPLACE ] FUNCTION FunctionName
[ (parameter1 [, parameter2...]) ]
RETURN DataType
IS
[ Constant | Variable declarations ]
BEGIN
Executable statements
RETURN ReturnValue
[ EXCEPTION
exception handling statements
RETURN ReturnValue ]
END [ FunctionName ];
```

* The RETURN statement does not have to be the last statement in the body of a function. 
* The body may contain more than one RETURN statement, but only one RETURN is executed with each function call.
* If you have RETURN statements in the exception section, you would need one return for each exception.


### Function Header
* The function header comes before the reserved word IS.
* The header contains the name of the function, the list of parameters (if any), and the RETURN data type.
###  Function Body
* A function’s body must contain at least one executable statement.
* If there is no declaration, the reserved word BEGIN follows the reserved word IS.
* If there is no exception handler, you can omit the word EXCEPTION.
* The function name label next to END is optional.
* There can be more than one return statement, but only one RETURN is executed in a function call.

### Return Data Types
* A function can return a value of scalar data type such as
    * VARCHAR2,
    * NUMBER,
    * BINARY_INTEGER,
    * BOOLEAN.
* It can also return a composite or complex data type such as
    * a PL/SQL table,
    * a PL/SQL record,
    * a nested table,
    * VARRAY,
    * LOB.


For example,
```
v_salary := get_salary (&emp_id);
IF emp_exists (v_empid) ...
```


* In the first example of a function call, the function get_salary is called from an assignment statement with the substitution variable emp_id as its actual parameter.
* The function returns the employee’s salary, which is assigned to the variable v_salary.
* In the second example, the function call to the function emp_exists is made from an IF statement.
* The function searches for the employee and returns a Boolean `TRUE` or `FALSE` to the statement.



```sql
CREATE OR REPLACE FUNCTION GET_DEPTNAME
    (I_DEPTID IN NUMBER)
    RETURN VARCHAR2
IS
    V_DEPTNAME VARCHAR2(12);
BEGIN
    SELECT DEPTNAME
    INTO V_DEPTNAME
    FROM DEPT
    WHERE DEPTID = I_DEPTID;
    RETURN V_DEPTNAME;
END GET_DEPTNAME;
```
    
```sql
DECLARE
    V_DEPTID EMPLOYEE.DEPTID%TYPE;
    V_DEPT_NAME VARCHAR2(12);
    V_EMPID EMPLOYEE.EMPLOYEEID%TYPE := &EMP_ID;
BEGIN
    SELECT DEPTID
    INTO V_DEPTID FROM EMPLOYEE
    WHERE EMPLOYEEID = V_EMPID;
    V_DEPT_NAME := GET_DEPTNAME(V_DEPTID);
    DBMS_OUTPUT.PUT_LINE('Employee: ' || V_EMPID);
    DBMS_OUTPUT.PUT_LINE('Department Name: ' || V_DEPT_NAME);
EXCEPTION
    WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE(V_EMPID || ' not found.');
END;
```

**output**

```
anonymous block completed
Employee: 111
Department Name: Finance
```



---


```sql
CREATE OR REPLACE FUNCTION DO_TOTAL
(I_AMOUNT IN NUMBER, I_TOTAL IN NUMBER)
RETURN NUMBER
IS
V_RESULT NUMBER(8) := 0;
BEGIN
V_RESULT := I_TOTAL + I_AMOUNT;
RETURN V_RESULT;
END DO_TOTAL;
```



```sql
DECLARE
    V_SAL EMPLOYEE.SALARY%TYPE;
    V_COMM EMPLOYEE.COMMISSION%TYPE;
    V_TOTSAL NUMBER(8) := 0;
    V_TOTCOMM NUMBER(8) := 0;
    V_TOTAL NUMBER(8);
    COUNTER NUMBER(2) := 10;
BEGIN
    DBMS_OUTPUT.PUT_LINE('DEPTID SALARY COMMISSION');
    DBMS_OUTPUT.PUT_LINE('------ ------ ----------');
    WHILE COUNTER <= 40 LOOP
    SELECT SUM(NVL(SALARY, 0)), SUM(NVL(COMMISSION, 0))
    INTO V_SAL, V_COMM FROM EMPLOYEE
    WHERE DEPTID = COUNTER;
    DBMS_OUTPUT.PUT_LINE(COUNTER || ' ' || TO_CHAR(V_SAL, '$999,999') ||
    ' ' || TO_CHAR(V_COMM, '$999,999'));
    V_TOTSAL := DO_TOTAL(V_TOTSAL, V_SAL);
    V_TOTCOMM := DO_TOTAL(V_TOTCOMM, V_COMM);
    COUNTER := COUNTER + 10;
END LOOP;
    V_TOTAL := V_TOTSAL + V_TOTCOMM;
    DBMS_OUTPUT.PUT_LINE('SUBTOTAL ' || TO_CHAR(V_TOTSAL, '$999,999') || ' ' ||
    TO_CHAR(V_TOTCOMM, '$999,999'));
    DBMS_OUTPUT.PUT_LINE('TOTAL OF SALARY AND COMMISSION: ' ||
    TO_CHAR(V_TOTAL, '$999,999'));
END;
```

**output**
```
DEPTID SALARY COMMISSION
------ ------ ----------
10 $375,000 $35,000
20 $146,500 $20,000
30 $69,500 $8,000
40 $150,000 $10,000
SUBTOTAL $741,000 $73,000
TOTAL OF SALARY AND COMMISSION: $814,000
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
