--DQL: It is used for READING data. We use 'SELECT' keyword.

CREATE TABLE workers
(
	id SMALLINT,
	name VARCHAR(50),
	salary MONEY,
	CONSTRAINT id_pk PRIMARY KEY(id)	
);

INSERT INTO workers VALUES(10001, 'Ali Can', 12000);
INSERT INTO workers VALUES(10002, 'Veli Han', 2000);
INSERT INTO workers VALUES(10003, 'Mary Star', 7000);
INSERT INTO workers VALUES(10004, 'Angie Ocean', 8500);


--How to get all colums/fields:
SELECT * FROM workers;

--How to get specific fields from a table
SELECT name FROM workers;

--How to get specific multiple fields
SELECT name, id FROM workers;

--How to get specific record
SELECT * FROM workers
WHERE id = 10001;

SELECT * FROM workers
WHERE salary = '12000';

--How to get multiple specific records

--Call all records whose id is greater than 10002
SELECT * FROM workers
WHERE id > 10002;

--Get records whose salary is 2000 or 7000 or 12000
SELECT * FROM workers
WHERE salary = '2000' OR salary = '7000' OR salary = '12000';

SELECT * FROM workers
WHERE salary IN('2000', '7000', '12000');

SELECT * FROM workers;


CREATE TABLE students
(

	id SMALLINT,
	name VARCHAR(20),
	address VARCHAR(100),
	exam_grade SMALLINT,
	registration_date DATE

);

INSERT INTO students VALUES(120, 'Ali Can', 'Ankara', 70, '11.Feb.2023');
INSERT INTO students VALUES('121', 'Veli Han', 'Trabzon', 75, '11.02.2022');
INSERT INTO students VALUES(122, 'Ayşe Tan', 'Bursa', 85, '11.Aug.2021');
INSERT INTO students VALUES(123, 'Mary Star', 'İstanbul', 95, 'Jan.1.2020');
INSERT INTO students VALUES(124, 'Terry Star', 'Ankara', 95, '1.Sep.19');
INSERT INTO students VALUES(125, 'Herry Star', 'Antalya', 95, '1.2.18');
INSERT INTO students VALUES(126, 'Sally Otar', 'İzmir', 100, '30.6.17');

--Question 1: Get all columns from students table.
SELECT * FROM students;

--Question 2: Get the id and name columns in the students table.
SELECT id, name FROM students;

--Question 3: Get all student information with a grade above 85.
SELECT * FROM students WHERE exam_grade > 85;

--Question 4: Get the names of students whose address is Ankara
SELECT name FROM students
WHERE address = 'Ankara';

--Question 5: Get the students whose grade is above 85 and whose address is Ankara.
SELECT * FROM students
WHERE exam_grade > 85 AND address = 'Ankara';

--Question 6: Get all columns of the students whose exam_grade is 95 or 70.
SELECT * FROM students
WHERE exam_grade = 95 OR exam_grade = 70;

SELECT * FROM students
WHERE exam_grade IN(95, 70);

--Question 7: Get the names of the students whose exam_grade is between 75 and 95.
--1. Way:
SELECT name FROM students
WHERE exam_grade >=75 AND exam_grade<=95;

--2. Way:
SELECT name, exam_grade  FROM students
WHERE exam_grade BETWEEN 75 AND 95;--Boundries are inclusive

--Question 8: Get the addresses of students whose IDs are not between 122 and 125.
--1. Way: 
SELECT address, id FROM students
WHERE id <122 OR id > 125;

--2. Way: NOT BETWEEN
SELECT address FROM students
WHERE id NOT BETWEEN 122 AND 125;--Boundries are exclusive

--3. Way: NOT IN
SELECT address FROM students
WHERE id NOT IN(122,123, 124,125);

--Question 9: Delete the record whose address is 'Antalya'
DELETE FROM students
WHERE address = 'Antalya';

--Question 10: Delete the lines (record/row) whose names are 'Ali Can', 'Veli Han' and 'Sally Otar'.
DELETE FROM students
WHERE name IN('Ali Can', 'Veli Han', 'Sally Otar');

--Question 11: Delete the first and last created records
--1. Way:
DELETE FROM students
WHERE registration_date IN('2017-06-30','2023-02-11');


--2. Way:
DELETE FROM students
WHERE registration_date IN((SELECT MIN(registration_date) FROM students),(SELECT MAX(registration_date) FROM students));

--Question 12: Delete all rows whose ids are greater than 122
DELETE FROM students
WHERE id > 122;

--Question 13: Delete all records
DELETE FROM students;

TRUNCATE students;

----Question 14: Drop the table
DROP TABLE students;

--Question 15: Insert data only id and address columns.
INSERT INTO students(id, address) VALUES(128, 'London');

--Question 16: Insert data into null cells.
UPDATE students
SET name = 'John',
	exam_grade = 99,
	registration_date = '1.1.20'
WHERE name IS NULL;


SELECT * FROM students;