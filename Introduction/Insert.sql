INSERT INTO position VALUES (1, 'President');
INSERT INTO position VALUES (2, 'Manager');
INSERT INTO position VALUES (3, 'Programmer');
INSERT INTO position VALUES (4, 'Accountant');
INSERT INTO position VALUES (5, 'Salesman');

INSERT INTO emplevel VALUES (1, 1, 25000);
INSERT INTO emplevel VALUES (2, 25001, 50000);
INSERT INTO emplevel VALUES (3, 50001, 100000);
INSERT INTO emplevel VALUES (4, 100001, 500000);

INSERT INTO qualification VALUES (1, 'Doctorate');
INSERT INTO qualification VALUES (2, 'Masters');
INSERT INTO qualification VALUES (3, 'Bachelors');
INSERT INTO qualification VALUES (4, 'Associates');
INSERT INTO qualification VALUES (5, 'High School');

INSERT INTO dept VALUES (10,'Finance', 'Charlotte', null);
INSERT INTO dept VALUES (20, 'InfoSys', 'New York', null);
INSERT INTO dept VALUES (30, 'Sales', 'Woodbridge', null);
INSERT INTO dept VALUES (40, 'Marketing', 'Los Angeles', null);

INSERT INTO employee VALUES (111, 'Smith', 'John', 1, NULL, 
	TO_DATE ('04/17/1995', 'mm/dd/yyyy'), 265000, 35000, 10, 1);
INSERT INTO employee VALUES (543, 'Dev', 'Derek', 2, 111, 
	TO_DATE ('03/15/2010', 'mm/dd/yyyy'), 80000, 20000, 20, 1);
INSERT INTO employee VALUES (246, 'Houston', 'Larry', 2, 111, 
	TO_DATE ('05/19/1997', 'mm/dd/yyyy'), 150000, 10000, 40, 2);
INSERT INTO employee VALUES (123, 'Roberts', 'Sandi', 2, 111, 
	TO_DATE ('12/01/2006', 'mm/dd/yyyy'), 75000, NULL, 10, 2);
INSERT INTO employee VALUES (433, 'McCall', 'Alex', 3, 543, 
	TO_DATE ('05/10/2012', 'mm/dd/yyyy'), 66500, NULL, 20, 4);
INSERT INTO employee VALUES (135, 'Garner', 'Stanley', 2, 111, 
	TO_DATE ('06/29/2011', 'mm/dd/yyyy'), 45000, 5000, 30, 5);
INSERT INTO employee VALUES (200, 'Shaw', 'Jinku', 5, 135, 
	TO_DATE ('01/02/2015', 'mm/dd/yyyy'), 24500, 3000, 30, NULL);
INSERT INTO employee VALUES (222, 'Chen', 'Sunny', 4, 123, 
	TO_DATE ('08/15/2014', 'mm/dd/yyyy'), 35000, NULL, 10, 3);

INSERT INTO dependent VALUES (543, 1, TO_DATE ('09/28/1958', 'mm/dd/yyyy'), 'Spouse');
INSERT INTO dependent VALUES (543, 2, TO_DATE ('10/14/1988', 'mm/dd/yyyy'), 'Son');
INSERT INTO dependent VALUES (200, 1, TO_DATE ('06/10/1976', 'mm/dd/yyyy'), 'Spouse');
INSERT INTO dependent VALUES (222, 1, TO_DATE ('02/04/1975', 'mm/dd/yyyy'), 'Spouse');

UPDATE dept SET employeeId=123 WHERE deptId=10;
UPDATE dept SET employeeId=543 WHERE deptId=20;
UPDATE dept SET employeeId=135 WHERE deptId=30;
UPDATE dept SET employeeId=246 WHERE deptId=40;
