CREATE TABLE my_companies 
(  
  company_id CHAR(3), 
  company_name VARCHAR(20)
);

INSERT INTO my_companies VALUES(100, 'IBM');
INSERT INTO my_companies VALUES(101, 'GOOGLE');
INSERT INTO my_companies VALUES(102, 'MICROSOFT');
INSERT INTO my_companies VALUES(103, 'APPLE');

SELECT * FROM my_companies;

CREATE TABLE orders 
(  
  company_id CHAR(3),   
  order_id CHAR(3),
  order_date DATE
);

INSERT INTO orders VALUES(101, 11, '17-Apr-2020');
INSERT INTO orders VALUES(102, 22, '18-Apr-2020');
INSERT INTO orders VALUES(103, 33, '19-Apr-2020');
INSERT INTO orders VALUES(104, 44, '20-Apr-2020');
INSERT INTO orders VALUES(105, 55, '21-Apr-2020');

SELECT * FROM orders;


--JOINS: 1) INNER JOIN: Returns common data
--		 2) LEFT JOIN: Returns all data from first table
--		 3) RIGHT JOIN: Returns all data from second table 	
--		 4) FULL JOIN: Returns all data from both table
--		 5) SELF JOIN: You will have a single table but you will use it as two tables




--1) INNER JOIN: Returns common data

--Select company name, order id, order date for common companies

SELECT mc.company_name, o.order_id, o.order_date
FROM my_companies mc INNER JOIN orders o
ON mc.company_id = o.company_id;

--2) LEFT JOIN: Returns all data from first table

--Get company_name,  order id and order date for the companies in my_companies table

SELECT mc.company_name, o.order_id, o.order_date
FROM my_companies mc LEFT JOIN orders o
ON mc.company_id = o.company_id


--		 3) RIGHT JOIN: Returns all data from second table 	

--Get company_name, order id and order date for the companies in orders table

--1. Way:
SELECT mc.company_name, o.order_id, o.order_date
FROM my_companies mc RIGHT JOIN orders o
ON mc.company_id = o.company_id
ORDER BY o.order_date DESC

--2. Way:Right join is not used common, use left join by taking 2nd table as first table.
SELECT mc.company_name, o.order_id, o.order_date
FROM orders o LEFT JOIN my_companies mc
ON mc.company_id = o.company_id
ORDER BY o.order_date DESC


--		 4) FULL JOIN: Returns all data from both table
--Get company_name, order id and order date from both of the tables

SELECT mc.company_name, o.order_id, o.order_date
FROM my_companies mc FULL JOIN orders o
ON mc.company_id = o.company_id


--		 5) SELF JOIN: You will have a single table but you will use it as two tables

CREATE TABLE workers 
(  
  id CHAR(2), 
  name VARCHAR(20),
  title VARCHAR(60),
  manager_id CHAR(2) 
);

INSERT INTO workers VALUES(1, 'Ali Can', 'SDET', 2);
INSERT INTO workers VALUES(2, 'John Walker', 'QA', 3);
INSERT INTO workers VALUES(3, 'Angie Star', 'QA Lead', 4);
INSERT INTO workers VALUES(4, 'Amy Sky', 'CEO', 5);

SELECT * FROM workers;

--Create a table which displays the manager of employees

SELECT employee.name AS employee, manager.name AS manager
FROM workers employee INNER JOIN workers manager
ON employee.manager_id = manager.id


--ALTER TABLE
--The Alter Table statement is used to add, delete or modify columns in an existing table.
--The Alter Table statement is used to add and drop constarints in an existing table.

--1) We can add a column to an existing table
ALTER TABLE workers
ADD company_industry VARCHAR(20);

--2) How to add a field with default value
ALTER TABLE workers
ADD worker_address VARCHAR(100) DEFAULT 'Miami, FL, USA';

--3) How to add multiple fields into a table
ALTER TABLE workers
ADD number_of_workers SMALLINT DEFAULT 0,
ADD name_of_ceo VARCHAR(20);

--4)How to drop fields from a table
ALTER TABLE workers
DROP COLUMN name_of_ceo;

--5)How to rename a field/column
ALTER TABLE workers
RENAME COLUMN company_industry TO company_profession;

--6)How to rename table
ALTER TABLE workers
RENAME TO employees;

--7)How to modify(Add constraints, change data type, change the size) a field

--Note: Be careful about the existing data when you add a constraint into a field.

--a) How to add constraint
--Add "NOT NULL" constraint to number_of_workers field
ALTER TABLE employees
ALTER COLUMN number_of_workers SET NOT NULL;

--Add "UNIQUE" constraint to company_profession field
ALTER TABLE employees
ADD CONSTRAINT company_profession_unique UNIQUE(company_profession);--Unique constraint can accept duplicated null.

--Add "UNIQUE" constraint to worker_address field
ALTER TABLE employees
ADD CONSTRAINT worker_address_unique UNIQUE(worker_address);--Unique constraint can not accept duplicated data.


--b) How to change data size/type of a field
--Note: Be careful about existing data size when you change the data size of a field

--Change the data type of the company_profession field to CHAR(5)
ALTER TABLE employees
ALTER COLUMN company_profession TYPE CHAR(5);

--Change the data type of the worker_address field to CHAR(5)
ALTER TABLE employees
ALTER COLUMN worker_address TYPE CHAR(5);--value too long for type character(5)==> You can not decrease column length because some values are greater than 5 chars.

--Change the data type of the worker_address field to CHAR(30)
ALTER TABLE employees
ALTER COLUMN worker_address TYPE CHAR(30);

SELECT * FROM employees;


--How to write FUNCTION

--A Function is created to do some tasks faster.
--A Function can be created for CRUD operations.
--In SQL, every function returns a data as return type.
--Operations that doesnt return data as return type are called 'Procedure'

CREATE OR REPLACE FUNCTION add_two_numbers(x NUMERIC, y NUMERIC)
RETURNS NUMERIC
LANGUAGE plpgsql
AS
$$

BEGIN

RETURN x+y;

END

$$


SELECT * FROM add_two_numbers(-3,3) AS addition;


--Write a function that calculates the volume of the cone.


CREATE OR REPLACE FUNCTION volume_of_cone(r NUMERIC, h NUMERIC)
RETURNS NUMERIC
LANGUAGE plpgsql
AS
$$

BEGIN

RETURN r*r*h*3.14/3;

END

$$


SELECT * FROM volume_of_cone(5,6);

SELECT to_char(volume_of_cone(5,6), '000.0');