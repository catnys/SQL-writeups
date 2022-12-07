-------------------------
--NESTEDQUERIES ANSWERS--
-------------------------

--1. Display employee Jinku Shaw’s department name.
---------------------------------------------------
EQUIJOIN:
select deptname from employee e, dept d 
where e.deptid=d.deptid and upper(lname)='SHAW' and upper(fname)='JINKU';
SUBQUERY:
select deptname from dept where deptid=
  (select deptid from employee where upper(lname)='SHAW' and upper(fname)='JINKU');


--2. Find name of the supervisor for employee number 433.
---------------------------------------------------
select lname, fname from employee where employeeid=
  (select supervisor from employee where employeeid=433);


--3. Who has same qualification as Stanley Garner?
---------------------------------------------------
select lname, fname from employee where qualid=
  (select qualid from employee where lname='Garner' and fname='Stanley');


--4. Which department has more employees than department 20?
---------------------------------------------------
select deptid, count(*) from employee group by deptid having count(*)>
  (select count(*) from employee where deptid=20);


--5. Which employees are working in the company longer than Larry Houston?
---------------------------------------------------
select lname, fname from employee where hiredate<
  (select hiredate from employee where lname='Houston' and fname='Larry');


--6. Find all employees in the sales department by using a nested query.
---------------------------------------------------
select lname, fname from employee where deptid=
  (select deptid from dept where deptname='Sales');


--7. Create a new table, EMP30, and populate it with employees in 
--department 30, using an existing table and a subquery.
--Use EmployeeId, Lname, Fname, HireDate and Salary columns.
---------------------------------------------------
create table emp30 as select employeeid, lname, fname, hiredate, salary from employee where deptid=30;


--8. Add more rows to EMP30 table with employee in department 40. 
--Do not transfer employee’s salary.
---------------------------------------------------
insert into emp30 (employeeid, lname, fname, hiredate) 
  select employeeid, lname, fname, hiredate from employee where deptid=40;


--9. Use multiple level subquery to display dependent information 
--for employees, who belong to FINANCE department.
---------------------------------------------------
select * from dependent where employeeid IN 
 (select employeeid from employee where deptid=
   (select deptid from dept where deptname='Finance'));


--10. Use set operator and subquery to find employees, who do not have any dependents.
---------------------------------------------------
select lname, fname from employee where employeeid=ANY
  (select employeeid from employee minus select distinct employeeid from dependent);


--11. Write a subquery that finds average salary by each department.
--Check to find if employee 543’s salary satisfies
--=ANY, <ANY, >ANY, <ALL, or >ALL condition against those departmental average salaries.
---------------------------------------------------
select lname, fname from employee where employeeid=543 and salary =ANY 
  (select avg(salary) from employee group by deptid);

select lname, fname from employee where employeeid=543 and salary >ANY 
  (select avg(salary) from employee group by deptid);

select lname, fname from employee where employeeid=543 and salary <ANY 
  (select avg(salary) from employee group by deptid);

select lname, fname from employee where employeeid=543 and salary >ALL 
  (select avg(salary) from employee group by deptid);

select lname, fname from employee where employeeid=543 and salary <ALL 
  (select avg(salary) from employee group by deptid);
