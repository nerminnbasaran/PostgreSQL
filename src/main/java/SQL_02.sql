--How to add Data into a table:

CREATE TABLE students
(
    student_id SMALLINT PRIMARY KEY,
    student_name VARCHAR(50) UNIQUE,
    student_age SMALLINT NOT NULL,
    student_dob DATE
    
    CONSTRAINT student_age_check CHECK(student_age BETWEEN 15 AND 20),--15 and 20 are inclusive
    CONSTRAINT student_name_upper_case CHECK(student_name = upper(student_name))

);

--1. Way: Insert data for all fields

INSERT INTO students VALUES(100,'ALI CAN', 16, '10-Aug-2007');
INSERT INTO students VALUES('101', 'VELI HAN', 20, '01-Jan-2003');

--For integer we do not use single quotes but if you use it will work as well
INSERT INTO students VALUES(102, 'AYSE TAN', 15, '29-Feb-2008');

--For varchar and date we have to use single quotes
INSERT INTO students VALUES(103, 'JOHN DOE', 19, '22-05-2004' );
INSERT INTO students VALUES(107, 'TOM JONNY', 18, '22-05-2005' );


--2. Way: How to insert data for specific field

INSERT INTO students(student_name, student_age, student_id) VALUES('MARK TWAIN', 16, 104);
INSERT INTO students(student_name, student_age, student_id) VALUES('MARY STAR', 17, 105);
INSERT INTO students(student_age, student_id) VALUES(20, 106);--UNIQUE constraint can not have dublicate values but it can have duplicate 'null'
INSERT INTO students(student_age, student_id) VALUES(20, 108);

--How to Update existing data
UPDATE students
SET student_name = 'LEO OCEAN'
WHERE student_id = 106;

--Update the dob of Ali to 11-Dec-1997
UPDATE students
SET student_dob = '11-Dec-1997'
WHERE student_name = 'ALI CAN';

--How to update multiple cell
--Update the dob of 105 to 11-Apr-2006 and name to 'TOM HANKS'
UPDATE students
SET student_name = 'TOM HANKS',
    student_dob = '11-Apr-2006'
WHERE student_id = 105;

--How to update multiple records(rows)
--Make the dob of all students 01-Aug-2021 if their ids are less than 104
UPDATE students
SET student_dob = '01-Aug-2021'
WHERE student_id < 104;

--Select maximum age from students table
SELECT MAX(student_age) FROM students;

--Select minimum age from students table
SELECT MIN(student_age) FROM students;

--Select average id from students table
SELECT AVG(student_id) FROM students;

--Update all students' age to the maximum age
UPDATE students
SET student_age = (SELECT MAX(student_age) FROM students);

--Update all students' dob to the minimum dob
UPDATE students
SET student_dob = (SELECT MIN(student_dob) FROM students);

SELECT * FROM students;

--Create workers table whose fields are worker_id, worker_name, worker_salary.
--worker_id will have primary key with the name worker_id_pk
--Insert 4 records into the workers table
--See the table on the console

CREATE TABLE workers
(
worker_id SMALLINT,
worker_name VARCHAR(50),
worker_salary SMALLINT,
CONSTRAINT worker_id_pk PRIMARY KEY(worker_id)
);

INSERT INTO workers VALUES(101, 'Ali Can', 10000);
INSERT INTO workers VALUES(102, 'Veli Han', 2000);
INSERT INTO workers VALUES(103, 'Ayse Kan', 7000);
INSERT INTO workers VALUES(104, 'Angie Ocean', 8500);

--Increase the salary of Veli Han to 20 percent less than the highest salary 
UPDATE workers
SET worker_salary = (SELECT MAX(worker_salary)*0.8 FROM workers)
WHERE worker_id = 102;

--Decrease the salary of Ali Can to 30 percent more than the lowest salary
UPDATE workers
SET worker_salary = (SELECT MIN(worker_salary)*1.3 FROM workers)
WHERE worker_name = 'Ali Can';

--Increase the salaries by 1000 if the salaries are less then the average salary 
UPDATE workers
SET worker_salary = worker_salary+1000
WHERE worker_salary < (SELECT AVG(worker_salary) FROM workers);

--Make the salaries equal to the average salary if the salaries are less then the average salary
UPDATE workers
SET worker_salary = (SELECT AVG(worker_salary) FROM workers)
WHERE worker_salary < (SELECT AVG(worker_salary) FROM workers);

SELECT * FROM workers;

--IS NULL
CREATE TABLE people
(
ssn INT,
name VARCHAR(50),
address VARCHAR(80)     
);

INSERT INTO people VALUES(123456789, 'Mark Star', 'Florida');
INSERT INTO people VALUES(234567890, 'Angie Way', 'Virginia');
INSERT INTO people VALUES(345678901, 'Maryy Tien', 'New Jersey');
INSERT INTO people(ssn, address) VALUES(456789012, 'Michigan');
INSERT INTO people(ssn, address) VALUES(567890123, 'California');
INSERT INTO people(ssn, name) VALUES(567890123, 'California');

--Change null names to "Name will be inserted later"
UPDATE people
SET name = 'Name will be inserted later'
WHERE name IS NULL;

--Change null addresses to "Address will be inserted later"
UPDATE people
SET address = 'Address will be inserted later'
WHERE address IS NULL;

--How to Delete record from a table
--Delete 'Angie Way' record from table
DELETE FROM people
WHERE name = 'Angie Way';

--Delete records which do not have name
DELETE FROM people
WHERE name = 'Name will be inserted later';

--Delete all records
DELETE FROM people;--Delete command deletes just records but does not drop(delete) table 

--Delete all records whose name is null or address is null
DELETE FROM people
WHERE name IS NULL OR address IS NULL;

--Delete all records whose SSN is greater than 123456789 and less than 345678901
DELETE FROM people
WHERE ssn > 123456789 AND ssn < 345678901;

--Delete all records whose name is not null
DELETE FROM people
WHERE name IS NOT NULL;

--Delete all records with TRUNCATE
TRUNCATE TABLE people;
--Truncate can not be used with 'where' so it deletes all records.
--If you delete records with Truncate you can not roll them back.

--Drop Table
DROP TABLE people;

SELECT * FROM people;

--DQL: It is language for reading data. We use 'SELECT'

CREATE TABLE workers
(
    id SMALLINT,
    name VARCHAR(50),
    salary SMALLINT,
    CONSTRAINT id4_pk PRIMARY KEY(id)
);  
    
INSERT INTO workers VALUES(10001, 'Ali Can', 12000);
INSERT INTO workers VALUES(10002, 'Veli Han', 2000);
INSERT INTO workers VALUES(10003, 'Mary Star', 7000);
INSERT INTO workers VALUES(10004, 'Angie Ocean', 8500);

--How to select all records
SELECT * FROM workers;

--How to get specific fields from a table
SELECT name FROM workers;

--How to get specific multiple fields
SELECT name, salary FROM workers;

--How to get specific record
SELECT * FROM workers
WHERE id = 10001;

--How to get multiple specific records
SELECT * FROM workers
WHERE id < 10003;

--Get records whose salary is 2000 or 7000 or 12000
--1. Way: NOT Recomended
SELECT * FROM workers
WHERE salary = 2000 OR salary = 7000 OR salary = 12000;

--2. Way: Instead of using OR agaian and again, use IN
SELECT * FROM workers
WHERE salary IN(2000, 7000, 12000);