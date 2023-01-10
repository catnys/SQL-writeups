set serveroutput on
set verify off

--Question 1
------------
CREATE OR REPLACE PROCEDURE get_employee
	(id IN NUMBER,
	last OUT VARCHAR2,
	first OUT VARCHAR2,
	sal OUT NUMBER)
IS
BEGIN
	SELECT lname, fname, salary
	INTO last, first, sal
	FROM employee
	WHERE employeeid = id;
EXCEPTION
	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE('Employee ' || id || ' does not exist.');
END get_employee;
/

--Anonymous block to test get_employee
DECLARE
	empid employee.employeeid%TYPE := &s_empid;
	last employee.lname%TYPE;
	first employee.fname%TYPE;
	sal employee.salary%TYPE;
BEGIN
	get_employee(empid, last, first, sal);
	IF last IS NOT NULL THEN
		DBMS_OUTPUT.PUT_LINE('Name: ' || first || ' ' || last);
		DBMS_OUTPUT.PUT_LINE('Salary: ' || sal);
	END IF;
END;
/   

--Question 2
------------
CREATE OR REPLACE FUNCTION check_dept
	(id IN NUMBER)
	RETURN BOOLEAN
IS
	departmentid dept.deptid%TYPE;
BEGIN
	SELECT deptid
	INTO departmentid
	FROM dept
	WHERE deptid = id;
	IF departmentid IS NOT NULL THEN
		RETURN TRUE;
	END IF;
EXCEPTION
	WHEN NO_DATA_FOUND THEN
	RETURN FALSE;
END;
/

--Anonymous block to test check_dept
DECLARE
	departmentid dept.deptid%TYPE := &s_deptid;
	found BOOLEAN;
BEGIN
	found := check_dept(departmentid);
	IF found = TRUE THEN
		DBMS_OUTPUT.PUT_LINE('Department ' || departmentid || ' exists.');
	ELSE
		DBMS_OUTPUT.PUT_LINE('Department ' || departmentid || ' does not exist.');
	END IF;
END;
/

--Question 3
------------
CREATE OR REPLACE FUNCTION find_dept
	(id IN NUMBER)
	RETURN dept.deptname%TYPE
IS
	departmentname dept.deptname%TYPE;
BEGIN
	SELECT deptname
	INTO departmentname
	FROM employee e, dept d
	WHERE e.deptid = d.deptid AND
		  e.employeeid = id;
	IF departmentname IS NOT NULL THEN
		RETURN departmentname;
	END IF;
EXCEPTION
	WHEN NO_DATA_FOUND THEN
	RETURN NULL;
END;
/
--Anonymous block to test find_dept
DECLARE
	empid employee.employeeid%TYPE := &s_empid;
	departmentname dept.deptname%TYPE;
BEGIN
	departmentname := find_dept(empid);
	IF departmentname IS NOT NULL THEN
		DBMS_OUTPUT.PUT_LINE('Employee ' || empid || ' works for ' || departmentname || ' department.');
	ELSE
		DBMS_OUTPUT.PUT_LINE('Employee ' || empid || ' does not exist.');
	END IF;
END;
/

--Question 4
------------
CREATE OR REPLACE PROCEDURE delete_dept
	(id IN NUMBER)
IS
	departmentname dept.deptname%TYPE;
BEGIN
	SELECT deptname
	INTO departmentname
	FROM dept
	WHERE deptid = id;
	
	IF departmentname IS NOT NULL THEN
		UPDATE employee SET deptid = NULL where deptid = id;
		DELETE dept WHERE deptid = id;
		--COMMIT;
		DBMS_OUTPUT.PUT_LINE('Department ' || departmentname || ' deleted.');
	END IF;
	
EXCEPTION
	WHEN NO_DATA_FOUND THEN
	DBMS_OUTPUT.PUT_LINE('Department ' || id || ' does not exist.');
END;
/
--Anonymous block to test delete_dept
DECLARE
	departmentid dept.deptid%TYPE := &s_deptid;
BEGIN
	delete_dept(departmentid);
END;
/
