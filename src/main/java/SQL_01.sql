/*
SQL: Structured Query Language

It is a language to query, manage and design data in database.

Database: The place where the data related to each other exist

SQL Commands Are Grouped:

1. DQL: Data Query Language

SELECT: Fetch data from database(READING)

2. DML: Data Manipulation Language

INSERT: Adds data to database
DELETE: Deletes the data from database
UPDATE: Updates the data in the database

3. DDL: Data Definition Language

DROP: Deletes the table
ALTER: Updates the table
CREATE: CReates the table

4. DCL: Data Control Language

GRANT: Used to athorize the user
REVOKE: Used to revoke the privilige users

*/

--How to create table

--1. Way: Create table from scratch

CREATE TABLE students
(
	student_id SMALLINT,
	student_name VARCHAR(50),
	student_age SMALLINT,
	student_dob DATE
);

--2. Way: Create table by using another table

CREATE TABLE student_name_age
AS SELECT student_name, student_age
FROM students;

SELECT * FROM students;

SELECT * FROM student_name_age;

--While we create a table, we can put some "Constraints" for fields
--Constraints:
--a) Unique
--b) Not Null
--c) Primary Key
--d) Foreign Key
--e) Check Constraint

--There are 2 ways to create Primary Key

--1. Way to create Primary Key:

CREATE TABLE students
(
	student_id SMALLINT PRIMARY KEY,--student_id field can not have dublicate and null value. Because it is primary key.
	student_name VARCHAR(50) NOT NULL,--student_name field can not have null value
	student_age SMALLINT,
	student_dob DATE UNIQUE--student_dob fiels can not have dublicate value
);


--2. Way to create Primary Key

CREATE TABLE students
(
	student_id SMALLINT,
	student_name VARCHAR(50),
	student_age SMALLINT,
	student_dob DATE,
	
	CONSTRAINT student_id_pk PRIMARY KEY(student_id)
);

--How to add Foreign Key Constraint

CREATE TABLE parents
(
	student_id SMALLINT,
	parent_name VARCHAR(50),
	phone_number CHAR(10),
	
	CONSTRAINT student_id_pk PRIMARY KEY(student_id)
);


CREATE TABLE students
(
	student_id SMALLINT,
	student_name VARCHAR(50),
	student_age SMALLINT,
	student_dob DATE,
	
	CONSTRAINT student_id_fk FOREIGN KEY(student_id) REFERENCES parents(student_id)
	
);

--How to add "Check" constraint

CREATE TABLE students
(
	student_id SMALLINT,
	student_name VARCHAR(50),
	student_age SMALLINT,
	student_dob DATE
	
	CONSTRAINT student_age_check CHECK(student_age BETWEEN 15 AND 20),--15 and 20 are inclusive
	CONSTRAINT student_name_upper_case CHECK(student_name = upper(student_name))

);

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

--2. Way: How to insert data for specific field


INSERT INTO students(student_name, student_age, student_id) VALUES('MARK TWAIN', 16, 104);
INSERT INTO students(student_name, student_age, student_id) VALUES('MARY STAR', 16, 105);




SELECT * FROM student;
