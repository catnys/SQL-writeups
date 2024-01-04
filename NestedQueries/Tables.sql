-- Delete Existing Tables (if any)
drop table employee cascade constraints;
drop table qualification cascade constraints;
drop table emplevel cascade constraints;
drop table dependent cascade constraints;
drop table dept cascade constraints;
drop table position cascade constraints;

-- Create Employee DB Tables and Constraints
create table qualification(qualId number(3) primary key, qualDesc varchar2(20));

create table position(positionId number(3) primary key, positionDesc varchar2(20));

create table emplevel(levelNo number(3) primary key, lowSalary number(6), highSalary number(6));

create table dept(deptId number(3) primary key, deptname varchar2(20), location varchar2(20), employeeId number(5));

create table employee(
employeeId number(5) primary key, 
lname varchar2(20) NOT NULL, 
fname varchar2(20) NOT NULL, 
positionId number(3) references position(positionId), 
supervisor number(5) references employee(employeeId), 
hiredate date, 
salary number(6), 
commission number(6), 
deptId number(3) references dept(deptId), 
qualId number(3) references qualification(qualId));

create table dependent(
employeeId number(5), 
dependentId number(3), 
depDOB date, 
relation varchar2(20), 
constraint d_pk primary key(dependentId,employeeId), 
constraint dept_empId_fk foreign key(employeeId) references employee(employeeId));

alter table dept add constraint dept_fk foreign key(employeeId) references employee(employeeId);
