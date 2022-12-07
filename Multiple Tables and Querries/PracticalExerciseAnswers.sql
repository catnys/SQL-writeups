------------------------------
--PRACTICAL EXERCISE ANSWERS--
------------------------------

--1. Display all employee names and their department names.
select lname, fname, deptname 
from employee e, dept d where e.deptid=d.deptid;


--2. Find name of the supervisor for employee number 433.
select e.lname "Employee Name", s.lname "Supervisor Name" 
from employee e, employee s where e.supervisor=s.employeeid and e.employeeid=433;


--3. Find all employees’ full names (lastname, firstname format) with salary, and their supervisor’s name with salary.
select e.lname||', '||e.fname "Employee Name", 
       e.salary "Employee Salary", 
	   s.lname||', '||s.fname "Supervisor Name", 
	   s.salary "Supervisor Salary" 
from employee e, employee s where e.supervisor=s.employeeid;


--4. Find each employee’s salary information and level based on the salary.
select lname, fname, salary, levelno 
from employee, emplevel where salary between lowsalary and highsalary;


--5. Display each employee’s name, department name, position description, and qualification description. Which employee is missing? Why?
select lname, fname, deptname, positiondesc, qualdesc 
from employee e, dept d, position p, qualification q 
where e.deptid=d.deptid and e.positionid=p.positionid and e.qualid=q.qualid;
--Including missing employee using outer join:
select lname, fname, deptname, positiondesc, qualdesc 
from employee e, dept d, position p, qualification q 
where e.deptid=d.deptid and e.positionid=p.positionid and e.qualid=q.qualid(+);


--6. Find all employees in the sales department.
select lname, fname, deptname 
from employee e, dept d where e.deptid=d.deptid and upper(d.deptname)='SALES';


--7. Display employee names and dependent information using an outer join.
--v1
select lname, fname, dependentid, depdob, relation 
from employee e, dependent d where e.employeeid=d.employeeid(+);
--v2
select lname, fname, dependentid, depdob, relation
from employee e left outer join dependent d
on e.employeeid=d.employeeid;


--8. Find out the names and number of years worked along with their department names in descending order by number of years worked
select lname, fname, deptname, round((sysdate-hiredate)/365) YEARS 
from employee e, dept d where e.deptid=d.deptid order by YEARS desc;

 
--9. Display qualifications of employees who work as ‘Manager’.
select e.lname, e.fname, q.qualdesc 
from employee e, position p, qualification q 
where p.positionid=e.positionid and e.qualid=q.qualid and upper(p.positiondesc)='MANAGER';


--10. Display total salaries of employees who have ‘Masters’ qualification.
select sum(salary) from employee e, qualification q
where e.qualid = q.qualid and upper(q.qualdesc) = 'MASTERS';


--11. Count the members of each department. Display department name, department id and employee count.
select d.deptname, e.deptid, count(e.employeeid) 
from employee e, dept d where e.deptid=d.deptid group by e.deptid, d.deptname;
