# Practical Exercises

1. Display all employee names and their department names.

`✔️Solution`

```sql
SELECT fname,lname,deptname FROM employee e, dept d 
WHERE e.deptId = d.deptId;
```

2. Find the name of the supervisor for employee id 433.

`✔️Solution`

```sql
SELECT e.fname 'Employee name' , s.fname 'Supervisor 
fname' FROM employee e, employee s WHERE e.employeeID 
= 433 AND e.supervisor=s.employeeid;
```


3. Find all employees’ full names ("lastname, firstname" format) with salary, and their supervisor’s name with salary.

`✔️Solution`

```sql
SELECT e.lname||', '||e.fname "Employee Name", 
       e.salary "Employee Salary", 
	   s.lname||', '||s.fname "Supervisor Name", 
	   s.salary "Supervisor Salary" 
FROM employee e, employee s WHERE e.supervisor=s.employeeid;
```



4. Find each employee’s salary information and level based on the salary.

`✔️Solution`

```sql
SELECT fname,lname,salary,levelno FROM employee e, 
emplevel lvl WHERE salary BETWEEN lowsalary AND highsalary;
```


5. Display each employee’s name, department name, position description, and qualification description.

`✔️Solution`

```sql
SELECT fname,lname,deptname,posDesc,qualDesc FROM 
employee e, position p, department d, qualification q 
WHERE e.deptid=d.deptid AND e.positionid=p.positionid 
AND e.qualid=q.qualid;
```

6. Find all employees in the sales department.

`✔️Solution`
```sql
SELECT lname, fname, deptname 
FROM employee e, dept d WHERE e.deptid=d.deptid AND 
UPPER(d.deptname)='SALES';
```

7. Display employee names and dependent information using an outer join.

`✔️Solution`
```sql
SELECT fname,lname,dependentid,depdob, relation 
FROM employee e, dependent d WHERE e.employeeid = d.employeeid(+);
```


8. Find out the names and number of years worked along with their department names in descending order by number of years worked.

`✔️Solution`

```sql
SELECT lname, fname, deptname, round((sysdate-hiredate)/365) YEARS 
FROM employee e, dept d WHERE e.deptid=d.deptid ORDER BY YEARS DESC;
```


9. Display the qualifications of employees who work as 'Manager'.

`✔️Solution`

```sql
SELECT e.fname, e.lname , q.qualDesc 
FROM employee e, qualification q 
WHERE e.employeeid = q.qualid AND p.positionid=e.positionid AND 
upper(p.positiondesc)='MANAGER';
```

10. Display total salaries of employees who have ‘Masters’ qualification.

`✔️Solution`

```sql
SELECT Sum(Salary) FROM employee e, qualification q 
WHERE e.qualid = q.qualid AND upper(q.qualdesc) = 'MASTERS';
```

11. Count the members of each department. Display department name, department id and employee count.

`✔️Solution`

```sql
SELECT Count(e.employeeid), d.deptname, e.deptid
FROM employee e, Department d
WHERE e.deptid = d.deptid GROUP BY e.deptid,d.deptname;
```





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


![](https://i.imgur.com/4n5DeZT.png)
