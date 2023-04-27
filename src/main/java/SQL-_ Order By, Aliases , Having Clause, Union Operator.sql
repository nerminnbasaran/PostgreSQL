
CREATE TABLE words
( 
  word_id CHAR(10) UNIQUE,
  word VARCHAR(50) NOT NULL,
  number_of_letters SMALLINT
);

INSERT INTO words VALUES (1001, 'hot', 3);
INSERT INTO words VALUES (1002, 'hat', 3);
INSERT INTO words VALUES (1003, 'hit', 3);
INSERT INTO words VALUES (1004, 'hbt', 3);
INSERT INTO words VALUES (1008, 'hct', 3);
INSERT INTO words VALUES (1005, 'adem', 4);
INSERT INTO words VALUES (1006, 'selena', 6);
INSERT INTO words VALUES (1007, 'yusuf', 5);

SELECT * FROM words;

--ORDER BY: TO put the records in ascending or descening order we use order by.
--Order By can be used just with SELECT.

--Put the records in ascending order by using number_of_letters
SELECT * FROM words
ORDER BY number_of_letters ASC --> ASC is optional, it is ascending order as default.

--Put the records in descending order by using word
SELECT * FROM words
ORDER BY word DESC--> DESC is not optional. If you do not type DESC, it will be in ascending order.

--In Order By, instead of column names, field numbers can be used as well.
SELECT * FROM words
ORDER BY 3 ASC;

SELECT * FROM words
ORDER BY 2 DESC;--> 2 stands for 'word' column


CREATE TABLE points
(
    name VARCHAR(50),
    point SMALLINT
);

INSERT INTO points values('Ali', 25);
INSERT INTO points values('Veli', 37);
INSERT INTO points values('Kemal', 43);
INSERT INTO points values('Ali', 36);
INSERT INTO points values('Ali', 25);
INSERT INTO points values('Veli', 29);
INSERT INTO points values('Ali', 45);
INSERT INTO points values('Veli', 11);
INSERT INTO points values('Ali', 125);

SELECT * FROM points;

--Put the records in descending order by using name field, and ascending order by using points field

SELECT *
FROM points
ORDER BY name DESC, point ASC;




CREATE TABLE employees 
(  
  employee_id CHAR(9), 
  employee_first_name VARCHAR(20),
  employee_last_name VARCHAR(20)
);

INSERT INTO employees VALUES(14, 'Chris', 'Tae');
INSERT INTO employees VALUES(11, 'John', 'Walker');
INSERT INTO employees VALUES(12, 'Amy', 'Star');
INSERT INTO employees VALUES(13, 'Brad', 'Pitt');
INSERT INTO employees VALUES(15, 'Chris', 'Way');

SELECT * FROM employees;

CREATE TABLE addresses 
(  
  employee_id CHAR(9), 
  street VARCHAR(20),
  city VARCHAR(20),
  state CHAR(2),
  zipcode CHAR(5)
);

INSERT INTO addresses VALUES(11, '32nd Star 1234', 'Miami', 'FL', '33018');
INSERT INTO addresses VALUES(12, '23rd Rain 567', 'Jacksonville', 'FL', '32256');
INSERT INTO addresses VALUES(13, '5th Snow 765', 'Hialeah', 'VA', '20121');
INSERT INTO addresses VALUES(14, '3rd Man 12', 'Weston', 'MI', '12345');
INSERT INTO addresses VALUES(15, '11th Chris 12', 'St. Johns', 'FL', '32259');

SELECT * FROM addresses;


--ALIASES

--How to put aliases for table names
--1)Select employee_first_name and state, for employee first name use "firstname" as field name and for state use "employee state" as field name

SELECT e.employee_first_name AS firstname, a.state AS "employee state"
FROM employees e, addresses a
WHERE e.employee_id = a.employee_id;

--How to put multiple fields into a single field and use aliases  for the field
--2)Get employee id use "id" as field name, get firstname and lastname put them into the same field and use "full_name" as field name
SELECT employee_id AS id, employee_first_name || ' ' || employee_last_name AS full_name
FROM employees;

--GROUP BY

CREATE TABLE workers 
(  
  id CHAR(9), 
  name VARCHAR(50), 
  state VARCHAR(50), 
  salary SMALLINT,
  company VARCHAR(20)
);

INSERT INTO workers VALUES(123456789, 'John Walker', 'Florida', 2500, 'IBM');
INSERT INTO workers VALUES(234567890, 'Brad Pitt', 'Florida', 1500, 'APPLE');
INSERT INTO workers VALUES(345678901, 'Eddie Murphy', 'Texas', 3000, 'IBM');
INSERT INTO workers VALUES(456789012, 'Eddie Murphy', 'Virginia', 1000, 'GOOGLE');
INSERT INTO workers VALUES(567890123, 'Eddie Murphy', 'Texas', 7000, 'MICROSOFT');
INSERT INTO workers VALUES(456789012, 'Brad Pitt', 'Texas', 1500, 'GOOGLE');
INSERT INTO workers VALUES(123456710, 'Mark Stone', 'Pennsylvania', 2500, 'IBM');

SELECT * FROM workers;


--Find the total salary for every employee
SELECT name, SUM(salary) AS total_salary
FROM workers
GROUP BY name
ORDER BY total_salary DESC;

--Find the number of employees per state in descending order by employee number
SELECT state, COUNT(state) AS "number of employees"
FROM workers
GROUP BY state
ORDER BY "number of employees" DESC

--Find the number of the employees whose salary is more than $2000 per company
SELECT company, COUNT(company)
FROM workers
WHERE salary > 2000
GROUP BY company;

--Find the minimum and maximum salary for every company
SELECT company, MIN(salary) AS minimum_salary_per_company, MAX(salary) AS maximum_salary_per_company
FROM workers
GROUP BY company;

--HAVING CLAUSE
--Find the total salary if it is greater than 2500 for every employee
SELECT name, SUM(salary) AS total_salary
FROM workers
GROUP BY name
HAVING SUM(salary) > 2500;-->After Group By, Where can NOT be used. We have to use HAVING to filter.



--SELECT name, SUM(salary) AS total_salary
--FROM workers
--WHERE SUM(salary) > 2500  --> We can NOT use aggragate functions with WHERE clause.(SUM(), AVG(), MIN(), MAX(), COUNT)
--GROUP BY name;

--Find the number of employees if it is more than 1 per state
SELECT state, COUNT(state)
FROM workers
GROUP BY state
HAVING COUNT(state) > 1;-->HAVING is for filtering(if) for group by. After HAVING we have to use aggregate function. DO NOT use field names.

--Find the minimum salary if it is more than 2000 for every company
SELECT company, MIN(salary) AS min_salary_per_company
FROM workers
GROUP BY company
HAVING MIN(salary) > 2000;

--Find the maximum salary if it is less than 3000 for every state
SELECT state, MAX(salary)
FROM workers
GROUP BY state
HAVING MAX(salary) < 3000;

--UNION Operator: 1) It is used to join the result of 2 queries
--				  2) UNION Operator returns unique records. It removes the repeated records.
--				  3) By using UNION operator we are able to put different fields into a single field.
--				  4) When we put diffent fields into a sinlge field, data types must be same.
		

--Find the state whose salary is greater than 3000, employee names less than 2000 without duplication.

SELECT state AS "state/name", salary
FROM workers
WHERE salary > 3000

UNION

SELECT name, salary
FROM workers
WHERE salary < 2000;

--Find the state whose salary is greater than 3000, employee names less than 2000 with duplication.

SELECT state AS "state/name", salary
FROM workers
WHERE salary > 3000

UNION ALL--> UNION ALL does same thing with UNION but it gives repeat records.

SELECT name, salary
FROM workers
WHERE salary < 2000;

--Find all common employee names whose salary is greater than 1000 and less than 2000

SELECT name
FROM workers
WHERE salary > 1000

INTERSECT--> Returns unique common records

SELECT name
FROM workers
WHERE salary < 2000


--Find the employee names whose salary is less than 3000 and not working in GOOGLE
SELECT name
FROM workers
WHERE salary < 3000

EXCEPT-->It is used to extract one query result from another query result. It returns unique records.

SELECT name
FROM workers
WHERE company = 'GOOGLE'


SELECT * FROM workers;